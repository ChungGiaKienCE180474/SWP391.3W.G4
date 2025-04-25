package group04.gundamshop.controller.client;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import group04.gundamshop.domain.Cart;
import group04.gundamshop.domain.CartDetail;
import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.OrderDetail;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.ProductReview;
import group04.gundamshop.domain.User;
import group04.gundamshop.domain.dto.ProductCriteriaDTO;
import group04.gundamshop.repository.CartDetailRepository;
import group04.gundamshop.repository.CartRepository;
import group04.gundamshop.service.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import group04.gundamshop.service.CartService;
import group04.gundamshop.service.CategoryService;
import group04.gundamshop.service.OrderService;
import group04.gundamshop.service.ProductReviewService;

@Controller
public class ItemController {

    private final CartDetailRepository cartDetailRepository;
    private final CartRepository cartRepository;
    private final ProductService productService;
    private final ProductReviewService productReviewService;
    private final CartService cartService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private CategoryService categoryService;

    public ItemController(ProductService productService, ProductReviewService productReviewService,
            CartDetailRepository cartDetailRepository, CartRepository cartRepository,
            CartService cartService, OrderService orderService) {
        this.productService = productService;
        this.productReviewService = productReviewService;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.cartService = cartService;
        this.orderService = orderService;
    }

    // Mapping cho trang sản phẩm chung
    @GetMapping("/products")
    public String getProductPage(Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request) {

        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            }
        } catch (Exception e) {
            // page = 1
        }

        // Set factory filter from request parameters
        String[] factoryParams = request.getParameterValues("factory");
        if (factoryParams != null && factoryParams.length > 0) {
            List<String> factoryList = new java.util.ArrayList<>();
            for (String param : factoryParams) {
                if (param != null && !param.isEmpty()) {
                    String[] splitParams = param.split(",");
                    for (String s : splitParams) {
                        factoryList.add(s);
                    }
                }
            }
            productCriteriaDTO.setFactory(java.util.Optional.of(factoryList));
        }

        // Set target filter from request parameters
        String[] targetParams = request.getParameterValues("target");
        if (targetParams != null && targetParams.length > 0) {
            List<String> targetList = new java.util.ArrayList<>();
            for (String param : targetParams) {
                if (param != null && !param.isEmpty()) {
                    String[] splitParams = param.split(",");
                    for (String s : splitParams) {
                        targetList.add(s);
                    }
                }
            }
            productCriteriaDTO.setTarget(java.util.Optional.of(targetList));
        }

        Pageable pageable;
        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if ("gia-tang-dan".equals(sort)) {
                pageable = PageRequest.of(page - 1, 9, org.springframework.data.domain.Sort.by("price").ascending());
            } else if ("gia-giam-dan".equals(sort)) {
                pageable = PageRequest.of(page - 1, 9, org.springframework.data.domain.Sort.by("price").descending());
            } else {
                pageable = PageRequest.of(page - 1, 9);
            }
        } else {
            pageable = PageRequest.of(page - 1, 9);
        }

        Page<Product> prs = this.productService.fetchProductsWithSpec(pageable, productCriteriaDTO);
        List<Product> products = prs.getContent().size() > 0 ? prs.getContent() : new ArrayList<Product>();

        List<group04.gundamshop.domain.Factory> factories = productService.getAllFactoryObjects();
        List<group04.gundamshop.domain.Target> targets = productService.getAllTargetObjects();

        java.util.Map<String, String[]> paramMap = request.getParameterMap();
        StringBuilder qsBuilder = new StringBuilder();
        for (java.util.Map.Entry<String, String[]> entry : paramMap.entrySet()) {
            String key = entry.getKey();
            if ("page".equalsIgnoreCase(key)) {
                continue;
            }
            String[] values = entry.getValue();
            if (values != null) {
                for (String value : values) {
                    if (value != null && !value.isEmpty()) {
                        if (qsBuilder.length() > 0) {
                            qsBuilder.append("&");
                        }
                        qsBuilder.append(java.net.URLEncoder.encode(key, java.nio.charset.StandardCharsets.UTF_8));
                        qsBuilder.append("=");
                        qsBuilder.append(java.net.URLEncoder.encode(value, java.nio.charset.StandardCharsets.UTF_8));
                    }
                }
            }
        }
        String qs = qsBuilder.length() > 0 ? "&" + qsBuilder.toString() : "";

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("queryString", qs);
        model.addAttribute("factories", factories);
        model.addAttribute("targets", targets);

        return "customer/product/show"; // Trang sản phẩm chung
    }

    // Mapping cho trang danh mục (showCategory.jsp)
    @GetMapping("/category")
    public String getCategoryPage(Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request,
            @RequestParam(value = "categoryId", required = false) Long categoryId) {

        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            }
        } catch (Exception e) {
            // page = 1
        }

        // Set factory filter from request parameters
        String factoryParam = request.getParameter("factory");
        if (factoryParam != null && !factoryParam.isEmpty()) {
            List<String> factoryList = java.util.Arrays.asList(factoryParam.split(","));
            productCriteriaDTO.setFactory(java.util.Optional.of(factoryList));
        }

        // Set target filter from request parameters
        String targetParam = request.getParameter("target");
        if (targetParam != null && !targetParam.isEmpty()) {
            List<String> targetList = java.util.Arrays.asList(targetParam.split(","));
            productCriteriaDTO.setTarget(java.util.Optional.of(targetList));
        }

        Pageable pageable;
        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if ("gia-tang-dan".equals(sort)) {
                pageable = PageRequest.of(page - 1, 9, org.springframework.data.domain.Sort.by("price").ascending());
            } else if ("gia-giam-dan".equals(sort)) {
                pageable = PageRequest.of(page - 1, 9, org.springframework.data.domain.Sort.by("price").descending());
            } else {
                pageable = PageRequest.of(page - 1, 9);
            }
        } else {
            pageable = PageRequest.of(page - 1, 9);
        }

        if (categoryId != null) {
            productCriteriaDTO.setCategoryId(Optional.of(categoryId.toString()));
            model.addAttribute("selectedCategory", categoryService.getCategoryById(categoryId));
        } else {
            return "redirect:/products"; // Nếu không có categoryId, chuyển về trang sản phẩm chung
        }

        Page<Product> prs = this.productService.fetchProductsWithSpec(pageable, productCriteriaDTO);
        List<Product> products = prs.getContent().size() > 0 ? prs.getContent() : new ArrayList<Product>();

        List<group04.gundamshop.domain.Factory> factories = productService.getAllFactoryObjects();
        List<group04.gundamshop.domain.Target> targets = productService.getAllTargetObjects();

        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            qs = qs.replace("page=" + page, "").replace("&&", "&").replaceAll("^&|&$", "");
            if (!qs.contains("categoryId=")) {
                qs = "categoryId=" + categoryId + (qs.isEmpty() ? "" : "&" + qs);
            }
        } else {
            qs = "categoryId=" + categoryId;
        }

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("queryString", qs);
        model.addAttribute("factories", factories);
        model.addAttribute("targets", targets);

        return "customer/category/show"; // Trang danh mục
    }

    // Các phương thức khác giữ nguyên...
    @GetMapping("/product/{id}")
    public String getProductPage(@PathVariable long id, Model model, HttpServletRequest request) {
        Optional<Product> productOptional = productService.getProductById(id);
        if (productOptional.isEmpty()) {
            return "error/404";
        }

        Product product = productOptional.get();
        if (!product.isStatus()) {
            return "customer/product/product-hidden";
        }

        model.addAttribute("product", product);

        List<CartDetail> productCartDetails = productService.getCartDetailsByProduct(product);
        CartDetail cartDetail = productCartDetails.isEmpty() ? null : productCartDetails.get(0);
        model.addAttribute("cartDetail", cartDetail);

        List<ProductReview> reviews = productReviewService.findReviewsByProductId(id);
        double averageRating = reviews.stream().mapToInt(ProductReview::getRating).average().orElse(0);

        model.addAttribute("reviews", reviews);
        model.addAttribute("averageRating", averageRating);

        return "customer/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, 1);
        return "redirect:/";
    }

    @PostMapping("/add-products-to-cart/{id}")
    public String addProductsToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, 1);
        return "redirect:/products";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/product/" + id;
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            Optional<Product> optionalProduct = this.productService.getProductById(cd.getProduct().getId());
            if (optionalProduct.isPresent()) {
                Product product = optionalProduct.get();
                if (cart.getSum() == 0) {
                    this.cartRepository.delete(cart);
                    session.setAttribute("sum", 0);
                }
                if (!product.isStatus()) {
                    this.cartDetailRepository.delete(cd);
                    int currentSum = cart.getSum();
                    cart.setSum(currentSum - 1);
                    session.setAttribute("sum", currentSum - 1);
                }
                if (cd.getPrice() != product.getPrice()) {
                    cd.setPrice(product.getPrice());
                    this.cartDetailRepository.save(cd);
                }
                totalPrice += cd.getPrice() * cd.getQuantity();
            }
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);

        return "customer/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.productService.handleRemoveCartDetail(id, session);
        return "redirect:/cart";
    }

    @GetMapping("/out-of-stock")
    public String getOutOfStock(Model model) {
        return "customer/cart/out-of-stock";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        for (CartDetail cd : cartDetails) {
            if (cd.getProduct().getQuantity() == 0) {
                return "redirect:/out-of-stock";
            }
            if (cd.getProduct().getQuantity() < cd.getQuantity()) {
                return "redirect:/cart?errorInventory";
            }
        }

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "customer/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("Note") String Note,
            @RequestParam(value = "voucherCode", required = false) String voucherCode,
            @RequestParam("finalTotal") double finalTotal,
            @RequestParam(value = "paymentMethod", defaultValue = "offline") String paymentMethod) {

        // Tạo đối tượng User từ session
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        // Loại bỏ dấu phẩy cuối và khoảng trắng thừa trong các trường nhập liệu
        receiverName = receiverName.replaceAll(",$", "").trim();
        receiverAddress = receiverAddress.replaceAll(",$", "").trim();
        receiverPhone = receiverPhone.replaceAll(",$", "").trim();
        Note = Note.replaceAll(",\\s*$", "").trim();

        if ("offline".equalsIgnoreCase(paymentMethod)) { // Thanh toán offline (COD)
            // Tạo đơn hàng cho phương thức offline
            Order order = new Order();
            order.setNote(Note);
            order.setTotalPrice(finalTotal);
            order.setStatus("PENDING"); // Trạng thái chờ xử lý
            order.setOrderDate(LocalDateTime.now());
            order.setReceiverAddress(receiverAddress);
            order.setReceiverName(receiverName);
            order.setReceiverPhone(receiverPhone);
            order.setUser(currentUser);
            order.setPaymentMethod("COD");

            // Lấy giỏ hàng của người dùng
            Cart cart = productService.fetchByUser(currentUser);
            List<OrderDetail> orderDetails = new ArrayList<>();
            if (cart != null && !cart.getCartDetails().isEmpty()) {
                for (CartDetail cartDetail : cart.getCartDetails()) {
                    // Tạo chi tiết đơn hàng
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setProduct(cartDetail.getProduct());
                    orderDetail.setPrice(BigDecimal.valueOf(cartDetail.getPrice()));
                    orderDetail.setQuantity((int) cartDetail.getQuantity());
                    orderDetail.setOrder(order);
                    orderDetails.add(orderDetail);

                    // Cập nhật số lượng trong kho và số lượng đã bán
                    Product product = cartDetail.getProduct();
                    long purchasedQuantity = cartDetail.getQuantity();
                    long currentQuantity = product.getQuantity();

                    // Kiểm tra nếu kho đủ hàng
                    if (currentQuantity < purchasedQuantity) {
                        throw new RuntimeException("Product " + product.getName() + " Not enough in stock! Left\r\n" + //
                                ": " + currentQuantity);
                    }

                    // Giảm quantity và tăng sold
                    product.setQuantity(currentQuantity - purchasedQuantity);
                    product.setSold(product.getSold() + purchasedQuantity);
                    product.setUpdatedAt(LocalDateTime.now()); // Cập nhật thời gian chỉnh sửa
                    productService.handleSaveProduct(product); // Lưu sản phẩm đã cập nhật
                }
                order.setOrderDetails(orderDetails);
            }

            // Lưu đơn hàng vào cơ sở dữ liệu
            orderService.saveOrder(order);

            // Xóa giỏ hàng sau khi đặt hàng thành công
            if (cart != null) {
                cart.getCartDetails().forEach(cartDetail -> cartDetailRepository.delete(cartDetail));
                cartRepository.delete(cart);
                session.setAttribute("sum", 0);
            }

            return "redirect:/thanks"; // Chuyển hướng đến trang cảm ơn
        } else if ("online".equalsIgnoreCase(paymentMethod)) { // Thanh toán online (VNPay)
            // Không tạo đơn hàng, chỉ chuyển hướng đến VNPay
            session.setAttribute("receiverName", receiverName);
            session.setAttribute("receiverAddress", receiverAddress);
            session.setAttribute("receiverPhone", receiverPhone);
            session.setAttribute("orderInfo", Note);
            session.setAttribute("amount", finalTotal); // Lưu finalTotal để dùng trong /createOrder

            // Chuyển hướng đến /createOrder với các tham số được mã hóa
            return "redirect:/createOrder?amount=" + finalTotal
                    + "&orderInfo=" + URLEncoder.encode(Note, StandardCharsets.UTF_8)
                    + "&receiverAddress=" + URLEncoder.encode(receiverAddress, StandardCharsets.UTF_8)
                    + "&receiverName=" + URLEncoder.encode(receiverName, StandardCharsets.UTF_8)
                    + "&phone=" + URLEncoder.encode(receiverPhone, StandardCharsets.UTF_8);
        }

        // Nếu phương thức thanh toán không hợp lệ
        return "redirect:/checkout?error=InvalidPaymentMethod";
    }

    @GetMapping("/thanks")
    public String getThankYouPage(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId"); // Lấy userId từ session

        if (userId != null) {
            Cart cart = cartService.getCartByUserId(userId);
            if (cart != null) {
                cartService.clearCart(cart);
            }
        }

        model.addAttribute("message", "Cảm ơn bạn đã mua hàng!");
        return "customer/cart/thank";
    }

    @GetMapping("/search")
    public String getSearchPage(Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {
        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            }
        } catch (Exception e) {
            // page = 1
        }

        String keyword = productCriteriaDTO.getSearchKeyword().orElse(request.getParameter("query"));
        if (keyword == null || keyword.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please enter a search keyword.");
            String referer = request.getHeader("Referer");
            if (referer != null) {
                return "redirect:" + referer;
            } else {
                return "redirect:/";
            }
        }
        keyword = keyword.trim();

        // Set factory filter from request parameters
        String[] factoryParams = request.getParameterValues("factory");
        if (factoryParams != null && factoryParams.length > 0) {
            productCriteriaDTO.setFactory(java.util.Optional.of(java.util.Arrays.asList(factoryParams)));
        }

        // Set target filter from request parameters
        String[] targetParams = request.getParameterValues("target");
        if (targetParams != null && targetParams.length > 0) {
            productCriteriaDTO.setTarget(java.util.Optional.of(java.util.Arrays.asList(targetParams)));
        }

        Pageable pageable;
        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if ("gia-tang-dan".equals(sort)) {
                pageable = PageRequest.of(page - 1, 9, org.springframework.data.domain.Sort.by("price").ascending());
            } else if ("gia-giam-dan".equals(sort)) {
                pageable = PageRequest.of(page - 1, 9, org.springframework.data.domain.Sort.by("price").descending());
            } else {
                pageable = PageRequest.of(page - 1, 9);
            }
        } else {
            pageable = PageRequest.of(page - 1, 9);
        }

        Page<Product> prs = this.productService.searchProducts(keyword, pageable, productCriteriaDTO);
        List<Product> products = prs.getContent().size() > 0 ? prs.getContent() : new ArrayList<Product>();

        List<group04.gundamshop.domain.Factory> factories = productService.getAllFactoryObjects();
        List<group04.gundamshop.domain.Target> targets = productService.getAllTargetObjects();

        java.util.Map<String, String[]> paramMap = request.getParameterMap();
        StringBuilder qsBuilder = new StringBuilder();
        for (java.util.Map.Entry<String, String[]> entry : paramMap.entrySet()) {
            String key = entry.getKey();
            if ("page".equalsIgnoreCase(key)) {
                continue;
            }
            for (String value : entry.getValue()) {
                if (value != null && !value.isEmpty()) {
                    if (qsBuilder.length() > 0) {
                        qsBuilder.append("&");
                    }
                    qsBuilder.append(java.net.URLEncoder.encode(key, java.nio.charset.StandardCharsets.UTF_8));
                    qsBuilder.append("=");
                    qsBuilder.append(java.net.URLEncoder.encode(value, java.nio.charset.StandardCharsets.UTF_8));
                }
            }
        }
        String qs = qsBuilder.length() > 0 ? "&" + qsBuilder.toString() : "";

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("queryString", qs);
        model.addAttribute("factories", factories);
        model.addAttribute("targets", targets);
        model.addAttribute("searchKeyword", keyword);

        return "customer/search/show";
    }

    @SuppressWarnings("unused")
    private double calculateCartTotal(Cart cart) {
        if (cart == null || cart.getCartDetails().isEmpty()) {
            return 0;
        }
        double total = 0;
        for (CartDetail detail : cart.getCartDetails()) {
            total += detail.getPrice() * detail.getQuantity();
        }
        return total;
    }

}
