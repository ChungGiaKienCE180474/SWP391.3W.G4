package group04.gundamshop.controller.admin;

import java.util.List;
// Import lớp List từ gói java.util, dùng để làm việc với danh sách.
import java.util.Optional;
// Import lớp Optional từ gói java.util, dùng để xử lý các giá trị có thể null.

import org.springframework.stereotype.Controller;
// Import annotation Controller từ Spring Framework, đánh dấu lớp này là một controller.
import org.springframework.ui.Model;
// Import interface Model từ Spring Framework, dùng để truyền dữ liệu từ controller đến view.
import org.springframework.validation.BindingResult;
// Import lớp BindingResult từ Spring Framework, chứa kết quả của quá trình validation.
import org.springframework.validation.FieldError;
// Import lớp FieldError từ Spring Framework, biểu diễn một lỗi validation trên một trường cụ thể.
import org.springframework.web.bind.annotation.GetMapping;
// Import annotation GetMapping từ Spring Framework, ánh xạ các yêu cầu HTTP GET đến các phương thức xử lý.
import org.springframework.web.bind.annotation.ModelAttribute;
// Import annotation ModelAttribute từ Spring Framework, liên kết một tham số phương thức hoặc giá trị trả về phương thức đến một thuộc tính model.
import org.springframework.web.bind.annotation.PathVariable;
// Import annotation PathVariable từ Spring Framework, trích xuất giá trị từ một biến đường dẫn trong URI.
import org.springframework.web.bind.annotation.PostMapping;
// Import annotation PostMapping từ Spring Framework, ánh xạ các yêu cầu HTTP POST đến các phương thức xử lý.
import org.springframework.web.bind.annotation.RequestMapping;
// Import annotation RequestMapping từ Spring Framework, ánh xạ các yêu cầu HTTP đến các phương thức xử lý (tổng quát hơn GetMapping, PostMapping).
import org.springframework.web.bind.annotation.RequestParam;
// Import annotation RequestParam từ Spring Framework, trích xuất giá trị từ một tham số request.
import org.springframework.web.multipart.MultipartFile;
// Import interface MultipartFile từ Spring Framework, đại diện cho một file được tải lên.
import java.time.LocalDateTime;
// Import lớp LocalDateTime từ gói java.time, dùng để làm việc với ngày giờ.
import group04.gundamshop.domain.Category;
// Import lớp Category từ gói group04.gundamshop.domain, đại diện cho một danh mục sản phẩm.
import group04.gundamshop.domain.Product;
// Import lớp Product từ gói group04.gundamshop.domain, đại diện cho một sản phẩm.
import group04.gundamshop.service.CategoryService;
// Import interface CategoryService từ gói group04.gundamshop.service, định nghĩa các phương thức thao tác với danh mục sản phẩm.
import group04.gundamshop.service.ProductService;
// Import interface ProductService từ gói group04.gundamshop.service, định nghĩa các phương thức thao tác với sản phẩm.
import group04.gundamshop.service.UploadService;
// Import interface UploadService từ gói group04.gundamshop.service, định nghĩa các phương thức xử lý việc tải file lên.
import jakarta.validation.Valid;
// Import annotation Valid từ Jakarta Bean Validation, kích hoạt validation trên một đối tượng.

@Controller
// Đánh dấu lớp này là một controller, cho phép Spring Framework quản lý nó.
public class ProductController {

    private final ProductService productService;
    // Khai báo một biến final thuộc kiểu ProductService, đại diện cho service xử lý
    // sản phẩm.
    private final UploadService uploadService;
    // Khai báo một biến final thuộc kiểu UploadService, đại diện cho service xử lý
    // việc tải file lên.
    private final CategoryService categoryService;
    // Khai báo một biến final thuộc kiểu CategoryService, đại diện cho service xử
    // lý danh mục sản phẩm.

    public ProductController(ProductService productService, UploadService uploadService,
            CategoryService categoryService) {
        // Constructor của lớp ProductController.
        this.productService = productService;
        // Khởi tạo productService bằng giá trị được truyền vào.
        this.uploadService = uploadService;
        // Khởi tạo uploadService bằng giá trị được truyền vào.
        this.categoryService = categoryService;
        // Khởi tạo categoryService bằng giá trị được truyền vào.
    }

    @GetMapping("/admin/product")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/product" đến phương thức này.
    public String getProduct(Model model) {
        // Phương thức xử lý yêu cầu hiển thị danh sách sản phẩm.
        List<Product> products = this.productService.getProductByStatus(true);
        // Lấy danh sách sản phẩm có trạng thái là true (đang hoạt động) từ
        // productService.
        model.addAttribute("products", products);
        // Thêm danh sách sản phẩm vào model để truyền đến view.
        return "admin/product/show";
        // Trả về tên view để hiển thị danh sách sản phẩm.
    }
    
    @GetMapping("/admin/product/create") // GET
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/product/create" đến phương
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

        return "admin/product/create";
        // Trả về tên view để hiển thị trang tạo sản phẩm.
    }

    @PostMapping(value = "/admin/product/create")
    // Ánh xạ các yêu cầu HTTP POST đến địa chỉ "/admin/product/create" đến phương
    // thức này.
    public String createProductPage(Model model, @ModelAttribute("newProduct") @Valid Product product,
            // Liên kết dữ liệu form với đối tượng Product và kích hoạt validation.
            BindingResult newProductBindingResult,
            // Chứa kết quả của quá trình validation.
            @RequestParam("productFile") MultipartFile file) {
        // Lấy file tải lên từ request.
        // validation
        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        // Lấy danh sách các lỗi validation.
        for (FieldError error : errors) {
            // Duyệt qua danh sách các lỗi.
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
            // In ra thông tin về trường bị lỗi và thông báo lỗi.
        }
        if (newProductBindingResult.hasErrors()) {
            // Kiểm tra nếu có lỗi validation.
            List<Category> categories = this.categoryService.getCategoryByStatus(true);
            // Lấy danh sách danh mục sản phẩm có trạng thái là true (đang hoạt động) từ
            // categoryService.
            model.addAttribute("categories", categories);
            // Thêm danh sách danh mục sản phẩm vào model để select box chọn danh mục có thể
            // sử dụng.
            return "admin/product/create";
            // Trả về trang tạo sản phẩm để hiển thị lỗi.
        }
        //

        product.setCategory(this.productService.getCategoryByName(product.getCategory().getName()));
        // Lấy đối tượng Category từ database dựa trên tên và set vào đối tượng product.
        String image = this.uploadService.handleSaveUploadFile(file, "product");
        // Lưu file tải lên và lấy đường dẫn.
        System.out.println(image);
        product.setImage(image);
        // Set đường dẫn hình ảnh vào đối tượng product.
        product.setStatus(true);
        // Set trạng thái sản phẩm là true (đang hoạt động).
        product.setCreatedAt(LocalDateTime.now());
        // Set thời gian tạo sản phẩm là thời điểm hiện tại.
        product.setUpdatedAt(LocalDateTime.now());
        // Set thời gian cập nhật sản phẩm là thời điểm hiện tại.

        // save
        this.productService.handleSaveProduct(product);
        // Lưu sản phẩm vào database.

        return "redirect:/admin/product";
        // Chuyển hướng đến trang danh sách sản phẩm.
    }

    @RequestMapping("/admin/product/update/{id}") // GET
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/product/update/{id}" đến
    // phương thức này.
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        // Phương thức xử lý yêu cầu hiển thị trang cập nhật sản phẩm.
        // chú ý category sử lý chỗ này

        Optional<Product> Product = this.productService.getProductById(id);
        // Lấy sản phẩm từ database dựa trên ID.

        Product currentProduct = Product.get();
        // Lấy đối tượng Product từ Optional.
        // Ensure products is not null before adding to model
        if (currentProduct == null) {
            // Kiểm tra nếu sản phẩm không tồn tại.
            // Handle the case where the user is not found

            return "redirect:/admin/product";
            // Chuyển hướng đến trang danh sách sản phẩm. // Redirect or show an error page
        }
        // Ensure customer is not null before adding to model
        if (!currentProduct.isStatus()) {
            // Kiểm tra nếu sản phẩm không hoạt động.
            // Handle the case where the user is not found
            return "redirect:/admin/product";
            // Chuyển hướng đến trang danh sách sản phẩm. // Redirect or show an error page
        }
        model.addAttribute("newProduct", currentProduct);
        // Thêm sản phẩm vào model để form cập nhật có thể sử dụng.
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        // Lấy danh sách danh mục sản phẩm có trạng thái là true (đang hoạt động) từ
        // categoryService.
        model.addAttribute("categories", categories);
        // Thêm danh sách danh mục sản phẩm vào model để select box chọn danh mục có thể
        // sử dụng.
        return "admin/product/update";
        // Trả về tên view để hiển thị trang cập nhật sản phẩm.
    }

    @PostMapping("/admin/product/update")
    // Ánh xạ các yêu cầu HTTP POST đến địa chỉ "/admin/product/update" đến phương
    // thức này.
    public String postUpdateProduct(Model model, @ModelAttribute("newProduct") @Valid Product product,
            // Liên kết dữ liệu form với đối tượng Product và kích hoạt validation.
            BindingResult newProductBindingResult,
            // Chứa kết quả của quá trình validation.
            @RequestParam("productFile") MultipartFile file) {
        // Lấy file tải lên từ request.
        // validate
        if (newProductBindingResult.hasErrors()) {
            // Kiểm tra nếu có lỗi validation.

            return "admin/product/update";
            // Trả về trang cập nhật sản phẩm để hiển thị lỗi.
        }

        Optional<Product> currentProductOpt = this.productService.getProductById(product.getId());
        // Lấy sản phẩm từ database dựa trên ID.

        if (currentProductOpt.isPresent()) { // Correct handling of Optional
            // Kiểm tra nếu sản phẩm tồn tại.
            Product currentProduct = currentProductOpt.get(); // Unwrap the Optional
            // Lấy đối tượng Product từ Optional.
            if (currentProduct != null) {
                // Kiểm tra nếu sản phẩm khác null
                // update new image
                if (!file.isEmpty()) {
                    // Kiểm tra nếu có file mới được tải lên.
                    String img = this.uploadService.handleSaveUploadFile(file, "product");
                    // Lưu file tải lên và lấy đường dẫn.
                    currentProduct.setImage(img);
                    // Set đường dẫn hình ảnh mới vào đối tượng product.
                }
                currentProduct.setCategory(this.productService.getCategoryByName(product.getCategory().getName()));
                // Lấy đối tượng Category từ database dựa trên tên và set vào đối tượng product.
                currentProduct.setUpdatedAt(LocalDateTime.now());
                // Set thời gian cập nhật sản phẩm là thời điểm hiện tại.
                currentProduct.setName(product.getName());
                // Cập nhật tên sản phẩm.
                currentProduct.setPrice(product.getPrice());
                // Cập nhật giá sản phẩm.
                currentProduct.setQuantity(product.getQuantity());
                // Cập nhật số lượng sản phẩm.
                currentProduct.setDetailDesc(product.getDetailDesc());
                // Cập nhật mô tả chi tiết sản phẩm.
                currentProduct.setShortDesc(product.getShortDesc());
                // Cập nhật mô tả ngắn sản phẩm.
                currentProduct.setFactory(product.getFactory());
                // Cập nhật nhà sản xuất sản phẩm.
                currentProduct.setTarget(product.getTarget());
                // Cập nhật đối tượng mục tiêu của sản phẩm.

                this.productService.handleSaveProduct(currentProduct);
                // Lưu sản phẩm đã cập nhật vào database.
            }
        }
        return "redirect:/admin/product";
        // Chuyển hướng đến trang danh sách sản phẩm.
    }

    @GetMapping("/admin/product/delete/{id}")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/product/delete/{id}" đến
    // phương thức này.
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        // Phương thức xử lý yêu cầu hiển thị trang xác nhận xóa sản phẩm.
        model.addAttribute("id", id);
        // Thêm ID sản phẩm vào model để trang xác nhận xóa có thể sử dụng.

        model.addAttribute("Product", new Product());
        return "admin/product/delete";
        // Trả về tên view để hiển thị trang xác nhận xóa sản phẩm.
    }

    @PostMapping("/admin/product/delete")
    // Ánh xạ các yêu cầu HTTP POST đến địa chỉ "/admin/product/delete" đến phương
    // thức này.
    public String postDeleteProduct(Model model, @ModelAttribute("Product") Product product) {
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
        return "redirect:/admin/product";
        // Chuyển hướng đến trang danh sách sản phẩm.
    }

    @GetMapping("/admin/product/{id}")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/product/{id}" đến phương thức
    // này.
    public String getProductDetailPage(Model model, @PathVariable long id) {
        // Phương thức xử lý yêu cầu hiển thị trang chi tiết sản phẩm.
        Product newProduct = this.productService.getProductById(id).get();
        // Lấy sản phẩm từ database dựa trên ID.
        model.addAttribute("newProduct", newProduct);
        // Thêm sản phẩm vào model để trang chi tiết sản phẩm có thể sử dụng.
        model.addAttribute("id", id);
        // Thêm ID sản phẩm vào model.
        return "admin/product/detail";
        // Trả về tên view để hiển thị trang chi tiết sản phẩm.
    }

    @GetMapping("/admin/product/search")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/product/search" đến phương
    // thức này.
    public String getProduct(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        // Phương thức xử lý yêu cầu tìm kiếm sản phẩm.
        List<Product> products;
        // Khai báo một danh sách sản phẩm.

        if (keyword != null && !keyword.isEmpty()) {
            // Kiểm tra nếu có từ khóa tìm kiếm.
            products = productService.getProductByNameOrCategory(keyword, true);
            // Tìm kiếm sản phẩm theo tên hoặc danh mục và trạng thái là true (đang hoạt
            // động).
        } else {
            // Nếu không có từ khóa tìm kiếm.
            products = productService.getProductByStatus(true);
            // Lấy tất cả sản phẩm có trạng thái là true (đang hoạt động).
        }

        model.addAttribute("products", products);
        // Thêm danh sách sản phẩm vào model để trang danh sách sản phẩm có thể sử dụng.
        model.addAttribute("keyword", keyword); // Để giữ giá trị tìm kiếm trong form
        // Thêm từ khóa tìm kiếm vào model để giữ giá trị trong form.

        return "admin/product/show";
        // Trả về tên view để hiển thị trang danh sách sản phẩm.
    }
}