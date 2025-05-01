package group04.gundamshop.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import group04.gundamshop.domain.Category;
import group04.gundamshop.service.CategoryService;
import group04.gundamshop.service.ProductService;
import group04.gundamshop.service.UploadService;
import jakarta.validation.Valid;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller quản lý danh mục sản phẩm (Category) trong trang Admin.
 * Cung cấp các chức năng CRUD (Create, Read, Update, Delete) cho danh mục.
 */
@Controller
public class CategoryController {

    private final CategoryService categoryService;
    private final UploadService uploadService;
    private final ProductService productService;

    /**
     * Constructor để inject các service cần thiết.
     *
     * @param categoryService Dịch vụ quản lý danh mục.
     * @param uploadService   Dịch vụ xử lý tải lên hình ảnh.
     * @param productService  Dịch vụ quản lý sản phẩm.
     */
    public CategoryController(CategoryService categoryService, UploadService uploadService,
            ProductService productService) {
        this.categoryService = categoryService;
        this.uploadService = uploadService;
        this.productService = productService;
    }

    /**
     * Hiển thị danh sách các danh mục có trạng thái hoạt động.
     *
     * @param model Model để truyền dữ liệu đến giao diện.
     * @return Trang hiển thị danh sách danh mục.
     */
    @GetMapping("/admin/category")
    public String redirectCategory() {
        return "redirect:/admin/category/list";
    }

    @GetMapping("/admin/category/list")
    public String getCategory(Model model) {
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        model.addAttribute("categories", categories);
        return "admin/category/show";
    }

    /**
     * Hiển thị trang tạo danh mục mới.
     *
     * @param model Model để truyền dữ liệu đến giao diện.
     * @return Trang tạo danh mục mới.
     */
    @GetMapping("/admin/category/create")
    public String getCreateCategoryPage(Model model) {
        model.addAttribute("newCategory", new Category());
        return "admin/category/create";
    }

    /**
     * Xử lý yêu cầu tạo danh mục mới.
     * Kiểm tra dữ liệu nhập vào, xử lý tải lên ảnh và lưu danh mục vào database.
     *
     * @param model                    Model để truyền dữ liệu đến giao diện.
     * @param category                 Đối tượng danh mục được nhập từ form.
     * @param newCategoryBindingResult Đối tượng kiểm tra lỗi đầu vào.
     * @param file                     Hình ảnh danh mục tải lên.
     * @return Điều hướng về trang danh sách danh mục hoặc hiển thị lại form nếu có
     *         lỗi.
     */
    @PostMapping(value = "/admin/category/create")
    public String createCategoryPage(Model model,
            @ModelAttribute("newCategory") @Valid Category category,
            BindingResult newCategoryBindingResult,
            @RequestParam("imageFile") MultipartFile file,
            RedirectAttributes redirectAttributes) {

        // Validate Category Name
        String name = category.getName();
        if (name == null || name.trim().isEmpty()) {
            newCategoryBindingResult.rejectValue("name", "error.name", "Category name cannot be empty!");
        } else if (!name.matches("^(?=.*[A-Za-z])[A-Za-z0-9 ]+$")) {
            newCategoryBindingResult.rejectValue("name", "error.name",
                    "Category name must contain letters and can include numbers, not only numbers!");
        } else if (name.trim().length() < 3) {
            newCategoryBindingResult.rejectValue("name", "error.name", "Category name must be at least 3 characters!");
        } else if (categoryService.existsByName(name.trim())) {
            newCategoryBindingResult.rejectValue("name", "error.name", "Category name already exists");
        }

        // Kiểm tra xem người dùng có tải ảnh lên không
        if (file.isEmpty()) {
            newCategoryBindingResult.rejectValue("image", "error.image", "  img CANNOT EMPTY");
            model.addAttribute("newCategory", category);
            return "admin/category/create";
        }
        // Kiểm tra lỗi validate dữ liệu nhập vào
        if (newCategoryBindingResult.hasErrors()) {
            model.addAttribute("newCategory", category);
            return "admin/category/create";
        }

        // Xử lý lưu hình ảnh và cập nhật đường dẫn ảnh vào category
        String image = this.uploadService.handleSaveUploadFile(file, "category");
        category.setImage(image);
        category.setStatus(true);

        // Lưu danh mục vào database
        this.categoryService.handleSaveCategory(category);

        // Fallback: redirect with query parameter for success message
        return "redirect:/admin/category/list?successMessage=Category+created+successfully";
    }

    /**
     * Hiển thị trang cập nhật danh mục.
     *
     * @param model Model để truyền dữ liệu đến giao diện.
     * @param id    ID của danh mục cần cập nhật.
     * @return Trang cập nhật danh mục hoặc điều hướng về danh sách nếu không tìm
     *         thấy danh mục.
     */
    @RequestMapping("/admin/category/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        Category currentCategory = this.categoryService.getCategoryById(id);

        // Kiểm tra xem danh mục có tồn tại không
        if (currentCategory == null || !currentCategory.isStatus()) {
            return "redirect:/admin/category"; // Nếu không tồn tại hoặc bị vô hiệu hóa, điều hướng về danh sách
        }

        model.addAttribute("newCategory", currentCategory);
        return "admin/category/update";
    }

    /**
     * Xử lý yêu cầu cập nhật danh mục.
     * Kiểm tra dữ liệu nhập, xử lý hình ảnh nếu có thay đổi và cập nhật thông tin
     * danh mục.
     *
     * @param model                    Model để truyền dữ liệu đến giao diện.
     * @param category                 Đối tượng danh mục nhập từ form.
     * @param newCategoryBindingResult Đối tượng kiểm tra lỗi đầu vào.
     * @param file                     Hình ảnh danh mục tải lên.
     * @return Điều hướng về trang danh sách danh mục hoặc hiển thị lại form nếu có
     *         lỗi.
     */
    @PostMapping("/admin/category/update")
    public String postUpdateCategory(Model model,
            @ModelAttribute("newCategory") @Valid Category category,
            BindingResult newCategoryBindingResult,
            @RequestParam("imageFile") MultipartFile file,
            RedirectAttributes redirectAttributes) {

        Category currentCategory = this.categoryService.getCategoryById(category.getId());

        if (newCategoryBindingResult.hasErrors()) {
            model.addAttribute("newCategory", category);
            return "admin/category/update";
        }

        Category existingCategory = this.categoryService.getCategoryByName(category.getName());
        if (existingCategory != null && existingCategory.getId() != category.getId()) {
            newCategoryBindingResult.rejectValue("name", "error.name", "Category name already exists.");
            model.addAttribute("newCategory", category);
            return "admin/category/update";
        }

        if (file.isEmpty() && (currentCategory.getImage() == null || currentCategory.getImage().isEmpty())) {
            newCategoryBindingResult.rejectValue("image", "error.image", "IMG CANNOT BE EMPTY");
            model.addAttribute("newCategory", category);
            return "admin/category/update";
        }

        if (!file.isEmpty()) {
            String img = this.uploadService.handleSaveUploadFile(file, "category");
            currentCategory.setImage(img);
        }

        currentCategory.setName(category.getName());
        this.categoryService.handleSaveCategory(currentCategory);

        return "redirect:/admin/category/list?successMessage=Category+updated+successfully";
    }

    /**
     * Hiển thị trang xác nhận xóa danh mục.
     *
     * @param model Model để truyền dữ liệu đến giao diện.
     * @param id    ID của danh mục cần xóa.
     * @return Trang xác nhận xóa danh mục.
     */
    @GetMapping("/admin/category/delete/{id}")
    public String getDeleteCategoryPage(Model model, @PathVariable long id) {
        Category category = this.categoryService.getCategoryById(id);
        model.addAttribute("id", id);
        model.addAttribute("name", category.getName());
        model.addAttribute("newCategory", new Category());
        return "admin/category/delete";
    }

    /**
     * Xử lý yêu cầu xóa danh mục bằng cách vô hiệu hóa trạng thái của danh mục.
     *
     * @param model    Model để truyền dữ liệu đến giao diện.
     * @param category Đối tượng danh mục nhập từ form.
     * @return Điều hướng về trang danh sách danh mục.
     */
    @PostMapping("/admin/category/delete")
    public String postDeleteCategory(Model model, @ModelAttribute("newCategory") Category category,
            RedirectAttributes redirectAttributes) {
        Category currentCategory = this.categoryService.getCategoryById(category.getId());

        // Nếu danh mục tồn tại, kiểm tra xem có sản phẩm nào gán với danh mục không
        if (currentCategory != null) {
            boolean hasProducts = productService.existsByCategoryId(currentCategory.getId());
            if (hasProducts) {
    redirectAttributes.addFlashAttribute("errorMessage",
        "Cannot delete category because it has assigned products.");
    return "redirect:/admin/category/list";
}

            currentCategory.setStatus(false);
            this.categoryService.handleSaveCategory(currentCategory);
            // Fallback: redirect with query parameter for success message
            return "redirect:/admin/category/list?successMessage=Category+deleted+successfully";
        } else {
            // Fallback: redirect with query parameter for error message
            return "redirect:/admin/category/list?errorMessage=Category+not+found";
        }

         //return "redirect:/admin/category";
    }

    /**
     * Hiển thị chi tiết danh mục.
     *
     * @param model Model để truyền dữ liệu đến giao diện.
     * @param id    ID của danh mục cần hiển thị chi tiết.
     * @return Trang hiển thị chi tiết danh mục.
     */
    @GetMapping("/admin/category/{id}")
    public String getCategoryDetailPage(Model model, @PathVariable long id) {
        Category newCategory = this.categoryService.getCategoryById(id);
        model.addAttribute("newCategory", newCategory);
        model.addAttribute("id", id);
        return "admin/category/detail";
    }
}
