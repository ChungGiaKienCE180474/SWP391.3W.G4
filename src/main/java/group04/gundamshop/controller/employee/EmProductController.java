package group04.gundamshop.controller.employee;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

import group04.gundamshop.domain.Category;
import group04.gundamshop.domain.Product;
import group04.gundamshop.service.CategoryService;
import group04.gundamshop.service.ProductService;
import group04.gundamshop.service.UploadService;
import group04.gundamshop.service.FactoryService;
import group04.gundamshop.service.TargetService;

import jakarta.validation.Valid;

@Controller
public class EmProductController {

    private final ProductService productService;
    
    @GetMapping("/employee")
    public String redirectToEmployeeProduct() {
        return "redirect:/employee/product";
    }

    private final UploadService uploadService;
    private final CategoryService categoryService;
    private final FactoryService factoryService;
    private final TargetService targetService;

    public EmProductController(ProductService productService, UploadService uploadService,
            CategoryService categoryService, FactoryService factoryService, TargetService targetService) {
        this.productService = productService;
        this.uploadService = uploadService;
        this.categoryService = categoryService;
        this.factoryService = factoryService;
        this.targetService = targetService;
    }

    @GetMapping("/employee/product")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/employee/product" đến phương thức này.
    public String getProduct(@RequestParam(value = "page", defaultValue = "0") int page, Model model) {
        // Phương thức xử lý yêu cầu hiển thị danh sách sản phẩm với phân trang.
        int pageSize = 10;
        org.springframework.data.domain.Pageable pageable = org.springframework.data.domain.PageRequest.of(page, pageSize);
        org.springframework.data.domain.Page<Product> productPage = this.productService.fetchProducts(pageable);
        model.addAttribute("productPage", productPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        return "employee/product/show";
        // Trả về tên view để hiển thị danh sách sản phẩm.
    }
 
    
    @GetMapping("/employee/product/create") // GET
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/employee/product/create" đến phương
    // thức này.
    public String getCreateUserPage(Model model) {
        // Phương thức xử lý yêu cầu hiển thị trang tạo sản phẩm mới.
        model.addAttribute("newProduct", new Product());
        // Thêm một đối tượng Product mới vào model để form tạo sản phẩm có thể sử dụng.
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        // Lấy danh sách danh mục sản phẩm có trạng thái là true (đang hoạt động) từ
        // categoryService.
        model.addAttribute("categories", categories);
        // Thêm danh sách danh mục sản phẩm vào model để select box chọn danh mục có thể
        // sử dụng.

        List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
        model.addAttribute("factories", factories);

        List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
        model.addAttribute("targets", targets);

        return "employee/product/create";
        // Trả về tên view để hiển thị trang tạo sản phẩm.
    }

    @PostMapping(value = "/employee/product/create")
    // Ánh xạ các yêu cầu HTTP POST đến địa chỉ "/employee/product/create" đến phương
    // thức này.
    public String createProductPage(Model model, @ModelAttribute("newProduct") @Valid Product product,
            // Liên kết dữ liệu form với đối tượng Product và kích hoạt validation.
            BindingResult newProductBindingResult,
            // Chứa kết quả của quá trình validation.
            @RequestParam("productFile") MultipartFile file,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        // Lấy file tải lên từ request.
        // validation
        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        // Lấy danh sách các lỗi validation.
        for (FieldError error : errors) {
            // Duyệt qua danh sách các lỗi.
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
            // In ra thông tin về trường bị lỗi và thông báo lỗi.
        }
        // Additional manual validation for Scale, Material, Dimensions, Weight
        /*
        if (product.getScale() == null || !product.getScale().matches("^1:\\d+$")) {
            newProductBindingResult.rejectValue("scale", "error.newProduct", "Scale must be in format 1:number, e.g. 1:6");
        }
        if (product.getMaterial() == null || !product.getMaterial().matches("^[a-zA-Z]+$")) {
            newProductBindingResult.rejectValue("material", "error.newProduct", "Material must contain only letters");
        }
        */
        if (product.getDimensions() == null || product.getDimensions() < 0) {
            newProductBindingResult.rejectValue("dimensions", "error.newProduct", "Dimensions must be non-negative");
        }
        if (product.getWeight() == null || product.getWeight() < 0) {
            newProductBindingResult.rejectValue("weight", "error.newProduct", "Weight must be non-negative");
        }
        // Additional manual validation for Scale, Material, Dimensions, Weight
        /*
        if (product.getScale() == null || !product.getScale().matches("^1:\\d+$")) {
            newProductBindingResult.rejectValue("scale", "error.newProduct", "Scale must be in format 1:number, e.g. 1:6");
        }
        if (product.getMaterial() == null || !product.getMaterial().matches("^[a-zA-Z]+$")) {
            newProductBindingResult.rejectValue("material", "error.newProduct", "Material must contain only letters");
        }
        */
        if (newProductBindingResult.hasErrors()) {
            // Kiểm tra nếu có lỗi validation.
            List<Category> categories = this.categoryService.getCategoryByStatus(true);
            model.addAttribute("categories", categories);
            List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
            model.addAttribute("factories", factories);
            List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
            model.addAttribute("targets", targets);
            return "employee/product/create";
        }

        // Validate negative quantity
        if (product.getQuantity() < 0) {
            newProductBindingResult.rejectValue("quantity", "error.newProduct", "Quantity cannot be negative");
            List<Category> categories = this.categoryService.getCategoryByStatus(true);
            model.addAttribute("categories", categories);
            List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
            model.addAttribute("factories", factories);
            List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
            model.addAttribute("targets", targets);
            return "employee/product/create";
        }

        // Validate unique product name with same factory and target
        Long factoryId = product.getFactory() != null ? product.getFactory().getId() : null;
        Long targetId = product.getTarget() != null ? product.getTarget().getId() : null;
        if (factoryId != null && targetId != null) {
            boolean exists = this.productService.existsByNameAndFactoryIdAndTargetId(product.getName(), factoryId, targetId);
            if (exists) {
                newProductBindingResult.rejectValue("name", "error.newProduct", "Product with the same name, factory, and target already exists");
                List<Category> categories = this.categoryService.getCategoryByStatus(true);
                model.addAttribute("categories", categories);
                List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
                model.addAttribute("factories", factories);
                List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
                model.addAttribute("targets", targets);
                return "employee/product/create";
            }
        }

        product.setCategory(this.productService.getCategoryByName(product.getCategory().getName()));

        if (factoryId != null) {
            group04.gundamshop.domain.Factory factory = this.factoryService.getFactoryById(factoryId).orElse(null);
            if (factory == null) {
                newProductBindingResult.rejectValue("factory", "error.newProduct", "Selected factory does not exist");
                List<Category> categories = this.categoryService.getCategoryByStatus(true);
                model.addAttribute("categories", categories);
                List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
                model.addAttribute("factories", factories);
                List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
                model.addAttribute("targets", targets);
                product.setFactory(null);
                return "employee/product/create";
            } else {
                product.setFactory(factory);
            }
        }

        if (targetId != null) {
            group04.gundamshop.domain.Target target = this.targetService.getTargetById(targetId).orElse(null);
            if (target == null) {
                newProductBindingResult.rejectValue("target", "error.newProduct", "Selected target does not exist");
                List<Category> categories = this.categoryService.getCategoryByStatus(true);
                model.addAttribute("categories", categories);
                List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
                model.addAttribute("factories", factories);
                List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
                model.addAttribute("targets", targets);
                return "employee/product/create";
            }
            product.setTarget(target);
        }

        String image = this.uploadService.handleSaveUploadFile(file, "product");
        System.out.println(image);
        product.setImage(image);
        product.setStatus(true);
        product.setCreatedAt(LocalDateTime.now());
        product.setUpdatedAt(LocalDateTime.now());

        this.productService.handleSaveProduct(product);

        redirectAttributes.addFlashAttribute("successMessage", "Product created successfully!");

        return "redirect:/employee/product";
    }

    @RequestMapping("/employee/product/update/{id}") // GET
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/employee/product/update/{id}" đến
    // phương thức này.
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        // Phương thức xử lý yêu cầu hiển thị trang cập nhật sản phẩm.
        // chú ý category sử lý chỗ này

        Optional<Product> productOptional = this.productService.getProductById(id);
        if (productOptional.isEmpty()) {
            return "redirect:/employee/product";
        }
        Product currentProduct = productOptional.get();
        if (!currentProduct.isStatus()) {
            return "redirect:/employee/product";
        }
        model.addAttribute("newProduct", currentProduct);
        // Thêm sản phẩm vào model để form cập nhật có thể sử dụng.
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        // Lấy danh sách danh mục sản phẩm có trạng thái là true (đang hoạt động) từ
        // categoryService.
        model.addAttribute("categories", categories);
        // Thêm danh sách danh mục sản phẩm vào model để select box chọn danh mục có thể
        // sử dụng.

        List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
        model.addAttribute("factories", factories);

        List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
        model.addAttribute("targets", targets);

        return "employee/product/update";
        // Trả về tên view để hiển thị trang cập nhật sản phẩm.
    }

    @PostMapping("/employee/product/update")
    // Ánh xạ các yêu cầu HTTP POST đến địa chỉ "/employee/product/update" đến phương
    // thức này.
    public String postUpdateProduct(Model model, @ModelAttribute("newProduct") @Valid Product product,
            // Liên kết dữ liệu form với đối tượng Product và kích hoạt validation.
            BindingResult newProductBindingResult,
            // Chứa kết quả của quá trình validation.
            @RequestParam("productFile") MultipartFile file,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        // Lấy file tải lên từ request.
        // validate
        // Additional manual validation for Scale, Material, Dimensions, Weight
        /*
        if (product.getScale() == null || !product.getScale().matches("^1:\\d+$")) {
            newProductBindingResult.rejectValue("scale", "error.newProduct", "Scale must be in format 1:number, e.g. 1:6");
        }
        if (product.getMaterial() == null || !product.getMaterial().matches("^[a-zA-Z]+$")) {
            newProductBindingResult.rejectValue("material", "error.newProduct", "Material must contain only letters");
        }
        */
        if (product.getDimensions() == null || product.getDimensions() < 0) {
            newProductBindingResult.rejectValue("dimensions", "error.newProduct", "Dimensions must be non-negative");
        }
        if (product.getWeight() == null || product.getWeight() < 0) {
            newProductBindingResult.rejectValue("weight", "error.newProduct", "Weight must be non-negative");
        }
        if (newProductBindingResult.hasErrors()) {
            // Kiểm tra nếu có lỗi validation.

            return "employee/product/update";
            // Trả về trang cập nhật sản phẩm để hiển thị lỗi.
        }

        // Validate unique product name with same factory and target (excluding current product)
        Long factoryId = product.getFactory() != null ? product.getFactory().getId() : null;
        Long targetId = product.getTarget() != null ? product.getTarget().getId() : null;
        if (factoryId != null && targetId != null) {
            boolean exists = this.productService.existsByNameAndFactoryIdAndTargetId(product.getName(), factoryId, targetId);
            if (exists) {
                List<Product> existingProducts = this.productService.findAllByNameAndFactoryIdAndTargetId(product.getName(), factoryId, targetId);
                boolean duplicateExists = existingProducts.stream()
                        .anyMatch(p -> p.getId() != product.getId());
                if (duplicateExists) {
                    newProductBindingResult.rejectValue("name", "error.newProduct", "Product with the same name, factory, and target already exists");
                    List<Category> categories = this.categoryService.getCategoryByStatus(true);
                    model.addAttribute("categories", categories);
                    List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
                    model.addAttribute("factories", factories);
                    List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
                    model.addAttribute("targets", targets);
                    return "employee/product/update";
                }
            }
        }

        Optional<Product> currentProductOpt = this.productService.getProductById(product.getId());
        if (currentProductOpt.isPresent()) {
            Product currentProduct = currentProductOpt.get();
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "product");
                currentProduct.setImage(img);
            }
            currentProduct.setCategory(this.productService.getCategoryByName(product.getCategory().getName()));
            currentProduct.setUpdatedAt(LocalDateTime.now());
            currentProduct.setName(product.getName());
            currentProduct.setPrice(product.getPrice());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setDetailDesc(product.getDetailDesc());
            currentProduct.setShortDesc(product.getShortDesc());
            currentProduct.setScale(product.getScale());
            currentProduct.setMaterial(product.getMaterial());
            currentProduct.setDimensions(product.getDimensions());
            currentProduct.setWeight(product.getWeight());
            if (product.getFactory() != null && product.getFactory().getId() > 0) {
                group04.gundamshop.domain.Factory factory = this.factoryService.getFactoryById(product.getFactory().getId()).orElse(null);
                if (factory == null) {
                    newProductBindingResult.rejectValue("factory", "error.newProduct", "Selected factory does not exist");
                    List<Category> categories = this.categoryService.getCategoryByStatus(true);
                    model.addAttribute("categories", categories);
                    List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
                    model.addAttribute("factories", factories);
                    List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
                    model.addAttribute("targets", targets);
                    currentProduct.setFactory(null);
                    return "employee/product/update";
                } else {
                    currentProduct.setFactory(factory);
                }
            } else {
                currentProduct.setFactory(null);
            }
            if (product.getTarget() != null && product.getTarget().getId() > 0) {
                group04.gundamshop.domain.Target target = this.targetService.getTargetById(product.getTarget().getId()).orElse(null);
                if (target == null) {
                    newProductBindingResult.rejectValue("target", "error.newProduct", "Selected target does not exist");
                    List<Category> categories = this.categoryService.getCategoryByStatus(true);
                    model.addAttribute("categories", categories);
                    List<group04.gundamshop.domain.Factory> factories = this.productService.getAllFactoryObjects();
                    model.addAttribute("factories", factories);
                    List<group04.gundamshop.domain.Target> targets = this.productService.getAllTargetObjects();
                    model.addAttribute("targets", targets);
                    return "employee/product/update";
                }
                currentProduct.setTarget(target);
            } else {
                currentProduct.setTarget(null);
            }
            this.productService.handleSaveProduct(currentProduct);
        }
        redirectAttributes.addFlashAttribute("successMessage", "Product updated successfully!");
        return "redirect:/employee/product";
        // Chuyển hướng đến trang danh sách sản phẩm.
    }

    @GetMapping("/employee/product/delete/{id}")
public String getDeleteProductPage(Model model, @PathVariable long id) {
    Optional<Product> productOptional = this.productService.getProductById(id);
    if (productOptional.isEmpty()) {
        return "redirect:/employee/product";
    }
    Product product = productOptional.get();
    if (!product.isStatus()) {
        return "redirect:/employee/product";
    }
    model.addAttribute("id", id);
    model.addAttribute("productName", product.getName()); // Add product name to the model
    model.addAttribute("Product", new Product());
    return "employee/product/delete";
}

    @PostMapping("/employee/product/delete")
    // Ánh xạ các yêu cầu HTTP POST đến địa chỉ "/employee/product/delete" đến phương
    // thức này.
    public String postDeleteProduct(Model model, @ModelAttribute("Product") Product product,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        // Phương thức xử lý yêu cầu xóa sản phẩm.
        Product currentProduct = this.productService.getProductById(product.getId()).get();
        // Lấy sản phẩm từ database dựa trên ID.

        if (currentProduct != null) {
            // Kiểm tra nếu sản phẩm tồn tại.

            currentProduct.setStatus(false);
            // Set trạng thái sản phẩm là false (ngừng hoạt động).

            this.productService.handleSaveProduct(currentProduct);
            // Lưu sản phẩm đã cập nhật vào database.
        }
        redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully!");
        return "redirect:/employee/product";
        // Chuyển hướng đến trang danh sách sản phẩm.
    }

    @GetMapping("/employee/product/{id}")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/employee/product/{id}" đến phương thức
    // này.
    public String getProductDetailPage(Model model, @PathVariable long id) {
        // Phương thức xử lý yêu cầu hiển thị trang chi tiết sản phẩm.
        Product newProduct = this.productService.getProductById(id).get();
        // Lấy sản phẩm từ database dựa trên ID.
        model.addAttribute("newProduct", newProduct);
        // Thêm sản phẩm vào model để trang chi tiết sản phẩm có thể sử dụng.
        model.addAttribute("id", id);
        // Thêm ID sản phẩm vào model.
        return "employee/product/detail";
        // Trả về tên view để hiển thị trang chi tiết sản phẩm.
    }

    @GetMapping("/employee/product/search")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/employee/product/search" đến phương
    // thức này.
    public String getProduct(@RequestParam(value = "keyword", required = false) String keyword,
                             @RequestParam(value = "page", defaultValue = "0") int page,
                             Model model) {
        int pageSize = 10;
        org.springframework.data.domain.Pageable pageable = org.springframework.data.domain.PageRequest.of(page, pageSize);
        org.springframework.data.domain.Page<Product> productPage;

        if (keyword != null && !keyword.isEmpty()) {
            productPage = productService.searchProducts(keyword, pageable, new group04.gundamshop.domain.dto.ProductCriteriaDTO());
        } else {
            productPage = productService.fetchProducts(pageable);
        }

        model.addAttribute("productPage", productPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("keyword", keyword); // Để giữ giá trị tìm kiếm trong form

        return "employee/product/show";
        // Trả về tên view để hiển thị trang danh sách sản phẩm.
    }
}