package group04.gundamshop.controller.client;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import group04.gundamshop.domain.Cart;
import group04.gundamshop.domain.CartDetail;
import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.OrderDetail;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.User;
import group04.gundamshop.domain.Voucher;
import group04.gundamshop.repository.CartDetailRepository;
import group04.gundamshop.repository.CartRepository;
import group04.gundamshop.service.OrderService;
import group04.gundamshop.service.ProductService;
import group04.gundamshop.service.VNPayService;
import group04.gundamshop.service.VoucherService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @Autowired
    private VNPayService vnPayService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private ProductService productService;

    @Autowired
    private VoucherService voucherService;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    // Xử lý trang tạo đơn hàng ban đầu
    @GetMapping("/createOrder")
    public String createOrder(
            @RequestParam(value = "amount", defaultValue = "0.0") double amount, // Tổng số tiền của đơn hàng
            @RequestParam("orderInfo") String orderInfo, // Mô tả đơn hàng
            @RequestParam(value = "receiverAddress", required = false) String receiverAddress, // Địa chỉ giao hàng
            @RequestParam(value = "receiverName", required = false) String receiverName, // Tên người nhận
            @RequestParam(value = "phone", required = false) String receiverPhone, // Số điện thoại người nhận
            Model model, HttpSession session) { // Model của Spring và phiên HTTP

        // Kiểm tra số tiền phải lớn hơn 0
        if (amount <= 0) {
            model.addAttribute("error", "Số tiền phải lớn hơn 0!");
            return "customer/vnpay/createOrder"; // Trả về trang tạo đơn hàng với thông báo lỗi
        }

        int totalAmount = (int) amount; // Chuyển đổi từ double sang integer
        model.addAttribute("totalAmount", totalAmount); // Thêm số tiền vào model để hiển thị
        model.addAttribute("orderDetails", orderInfo); // Thêm thông tin đơn hàng vào model

        // Lưu thông tin đơn hàng vào session để sử dụng sau
        session.setAttribute("receiverAddress", receiverAddress);
        session.setAttribute("receiverName", receiverName);
        session.setAttribute("receiverPhone", receiverPhone);
        session.setAttribute("orderInfo", orderInfo);
        session.setAttribute("amount", totalAmount);

        // Ghi log chi tiết chuẩn bị thanh toán
        System.out.println("Chuẩn bị thanh toán - Số tiền: " + totalAmount + ", Thông tin đơn: " + orderInfo);
        return "customer/vnpay/createOrder"; // Trả về giao diện tạo đơn hàng
    }

    // Xử lý việc gửi đơn hàng và chuyển hướng đến cổng thanh toán VNPay
    @GetMapping("/submitOrder")
    public String submitOrder(
            @RequestParam("amount") String orderTotalStr, // Tổng số tiền đơn hàng dưới dạng chuỗi
            @RequestParam("orderInfo") String orderInfo, // Mô tả đơn hàng
            @RequestParam("address") String address, // Địa chỉ giao hàng
            @RequestParam("name") String name, // Tên người nhận
            @RequestParam("phone") String phone, // Số điện thoại người nhận
            HttpServletRequest request, // Đối tượng yêu cầu HTTP
            HttpSession session) { // Phiên HTTP

        int orderTotal;
        try {
            // Làm sạch và phân tích chuỗi số tiền
            String cleanedAmount = orderTotalStr.replace(".", "");
            orderTotal = Integer.parseInt(cleanedAmount);
        } catch (NumberFormatException e) {
            orderTotal = 0; // Mặc định là 0 nếu phân tích thất bại
        }

        // Lưu thông tin đơn hàng vào session
        session.setAttribute("receiverAddress", address);
        session.setAttribute("receiverName", name);
        session.setAttribute("receiverPhone", phone);
        session.setAttribute("orderInfo", orderInfo);
        session.setAttribute("amount", orderTotal);

        // Tạo URL cơ sở cho việc trả về sau thanh toán
        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        // Tạo URL thanh toán VNPay
        String vnpayUrl = vnPayService.createOrder(request, orderTotal, orderInfo, baseUrl, null);
        return "redirect:" + vnpayUrl; // Chuyển hướng đến trang thanh toán VNPay
    }

    // Xử lý phản hồi từ cổng thanh toán VNPay
    @GetMapping("/vnpay-payment-return")
    public String paymentCompleted(HttpServletRequest request, Model model, HttpSession session) {
        int paymentStatus = vnPayService.orderReturn(request);
        String orderInfo = request.getParameter("vnp_OrderInfo");
        String paymentTimeRaw = request.getParameter("vnp_PayDate");
        String transactionId = request.getParameter("vnp_TransactionNo");
        String totalPriceRaw = request.getParameter("vnp_Amount");
        double totalPrice = totalPriceRaw != null ? Double.parseDouble(totalPriceRaw) / 100 : 0;

        String paymentTime = paymentTimeRaw != null ? formatPaymentTime(paymentTimeRaw) : "[Không có thời gian]";

        if (paymentStatus == 1) { // Thanh toán thành công
            Order order = new Order();
            order.setNote(orderInfo + " | Transaction ID: " + transactionId + " | Payment Time: " + paymentTime);
            order.setTotalPrice(totalPrice);
            order.setStatus("BANKING"); // Trạng thái xác nhận sau khi thanh toán
            order.setOrderDate(LocalDateTime.now());
            order.setPaymentMethod("VNPAY");
            order.setReceiverAddress((String) session.getAttribute("receiverAddress"));
            order.setReceiverName((String) session.getAttribute("receiverName"));
            order.setReceiverPhone((String) session.getAttribute("receiverPhone"));
            String voucherCode = (String) session.getAttribute("voucherCode");
            if (voucherCode != null && !voucherCode.isBlank()) {
                Voucher voucher = voucherService.getByCode(voucherCode);
                if (voucher.getQuantity() > 0) {
                    order.setVoucher(voucher);
                    voucherService.updateAfterCheckout(voucher);
                }
            }

            User currentUser = new User();
            long id = (long) session.getAttribute("id");
            currentUser.setId(id);
            order.setUser(currentUser);

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
                        throw new RuntimeException(
                                "Product " + product.getName() + " Not enough in stock! Left: " + currentQuantity);
                    }

                    // Giảm quantity và tăng sold
                    product.setQuantity(currentQuantity - purchasedQuantity);
                    product.setSold(product.getSold() + purchasedQuantity);
                    product.setUpdatedAt(LocalDateTime.now()); // Cập nhật thời gian chỉnh sửa
                    productService.handleSaveProduct(product); // Lưu sản phẩm đã cập nhật
                }
                order.setOrderDetails(orderDetails);
            }

            // Lưu đơn hàng
            order = orderService.saveOrder(order);

            // Xóa giỏ hàng
            if (cart != null) {
                cart.getCartDetails().forEach(cartDetail -> cartDetailRepository.delete(cartDetail));
                cartRepository.delete(cart);
                session.setAttribute("sum", 0);
            }

            model.addAttribute("orderDetails", order.getOrderDetails());
            model.addAttribute("order", order);

            // Xóa các thuộc tính session
            session.removeAttribute("receiverAddress");
            session.removeAttribute("receiverName");
            session.removeAttribute("receiverPhone");
            session.removeAttribute("orderInfo");
            session.removeAttribute("amount");
            session.removeAttribute("cart");
            session.removeAttribute("voucherCode");
            session.removeAttribute("paymentInfo");
        }

        model.addAttribute("orderInfo", orderInfo != null ? orderInfo : "[]");
        model.addAttribute("amount", totalPrice);
        model.addAttribute("paymentTime", paymentTime);
        model.addAttribute("transactionId", transactionId != null ? transactionId : "[]");
        return paymentStatus == 1 ? "customer/vnpay/ordersuccess" : "customer/vnpay/orderfail";
    }

    private String formatPaymentTime(String paymentTimeRaw) {
        try {
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            SimpleDateFormat outputFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Date date = inputFormat.parse(paymentTimeRaw);
            return outputFormat.format(date);
        } catch (Exception e) {
            return paymentTimeRaw;
        }
    }

    // Hiển thị trang cảm ơn sau khi đặt hàng thành công
    @GetMapping("/thank")
    public String thankYouPage(HttpSession session) {
        // Xóa các thuộc tính session còn lại
        session.removeAttribute("cart");
        session.removeAttribute("paymentInfo");
        return "thank"; // Trả về giao diện cảm ơn
    }
}