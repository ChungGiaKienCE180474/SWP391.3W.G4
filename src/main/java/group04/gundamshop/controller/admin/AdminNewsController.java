package group04.gundamshop.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group04.gundamshop.domain.News;
import group04.gundamshop.service.NewsService;
import group04.gundamshop.service.UploadNewsService;

/**
 * Controller quản lý tin tức trong trang admin.
 */
@Controller
@RequestMapping("/admin/news")
public class AdminNewsController {
    private final NewsService newsService;
    private final UploadNewsService uploadNewsService;

    /**
     * Khởi tạo AdminNewsController với các service cần thiết.
     * @param newsService Dịch vụ xử lý tin tức.
     * @param uploadNewsService Dịch vụ xử lý upload ảnh.
     */
    @Autowired
    public AdminNewsController(NewsService newsService, UploadNewsService uploadNewsService) {
        this.newsService = newsService;
        this.uploadNewsService = uploadNewsService;
    }

    /**
     * Hiển thị danh sách tin tức.
     * @param model Đối tượng Model để chứa dữ liệu.
     * @return Trang quản lý tin tức.
     */
    @GetMapping
    public String showNewsList(Model model) {
        model.addAttribute("newsList", newsService.getAllNews());
        return "admin/news/manage-news";
    }

    /**
     * Hiển thị form thêm tin tức mới.
     * @param model Đối tượng Model để chứa dữ liệu.
     * @return Trang thêm tin tức.
     */
    @GetMapping("/create")
    public String showCreateNewsForm(Model model) {
        model.addAttribute("news", new News());
        return "admin/news/create-news";
    }

    /**
     * Xử lý tạo mới tin tức.
     * @param title Tiêu đề bài viết.
     * @param content Nội dung bài viết.
     * @param file Ảnh đính kèm bài viết.
     * @return Chuyển hướng về danh sách tin tức.
     */
    @PostMapping("/create")
    public String createNews(@RequestParam("title") String title,
                             @RequestParam("content") String content,
                             @RequestParam("image_url") MultipartFile file,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        // Validate title and content
        boolean hasErrors = false;
        if (title == null || title.trim().isEmpty()) {
            model.addAttribute("titleError", "Title cannot be empty or whitespace.");
            hasErrors = true;
        }
        if (content == null || content.trim().isEmpty()) {
            model.addAttribute("contentError", "Content cannot be empty or whitespace.");
            hasErrors = true;
        }
        if (hasErrors) {
            // Preserve original input including leading/trailing spaces
            model.addAttribute("news", new News(title, content, null));
            return "admin/news/create-news";
        }

        String imageUrl = null;
        if (!file.isEmpty()) {
            imageUrl = uploadNewsService.handleSaveUploadFile(file, "news");
        }

        News news = new News(title, content, imageUrl);
        news.setStatus(false);
        newsService.saveNews(news);
        redirectAttributes.addFlashAttribute("message", "News created successfully.");
        return "redirect:/admin/news";
    }

    /**
     * Hiển thị form cập nhật tin tức.
     * @param id ID của bài viết cần cập nhật.
     * @param model Đối tượng Model để chứa dữ liệu.
     * @return Trang cập nhật tin tức hoặc quay về danh sách nếu không tìm thấy bài viết.
     */
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }
        model.addAttribute("news", news);
        return "admin/news/update-news";
    }

    /**
     * Xử lý cập nhật tin tức.
     * @param id ID bài viết cần cập nhật.
     * @param title Tiêu đề bài viết.
     * @param content Nội dung bài viết.
     * @param file Ảnh mới (nếu có).
     * @return Chuyển hướng về danh sách tin tức.
     */
    @PostMapping("/update/{id}")
    public String updateNews(@PathVariable Long id,
                             @RequestParam("title") String title,
                             @RequestParam("content") String content,
                             @RequestParam("image") MultipartFile file,
                             @RequestParam(value = "status", required = false, defaultValue = "true") boolean status,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }

        // Validate title and content
        boolean hasErrors = false;
        if (title == null || title.trim().isEmpty()) {
            model.addAttribute("titleError", "Title cannot be empty or whitespace.");
            hasErrors = true;
        }
        if (content == null || content.trim().isEmpty()) {
            model.addAttribute("contentError", "Content cannot be empty or whitespace.");
            hasErrors = true;
        }
        if (hasErrors) {
            // Preserve original input including leading/trailing spaces
            news.setTitle(title);
            news.setContent(content);
            news.setStatus(status);
            model.addAttribute("news", news);
            return "admin/news/update-news";
        }

        news.setTitle(title);
        news.setContent(content);
        news.setStatus(status);

        if (!file.isEmpty()) {
            String imageUrl = uploadNewsService.handleSaveUploadFile(file, "news");
            news.setImageUrl(imageUrl);
        }

        newsService.saveNews(news);
        redirectAttributes.addFlashAttribute("message", "News updated successfully.");
        return "redirect:/admin/news";
    }

    /**
     * Hiển thị trang xác nhận xóa tin tức.
     * @param id ID bài viết cần xóa.
     * @param model Đối tượng Model để chứa dữ liệu.
     * @return Trang xác nhận xóa hoặc quay về danh sách nếu không tìm thấy bài viết.
     */
    @GetMapping("/confirm-delete/{id}")
    public String showDeleteConfirmPage(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }
        model.addAttribute("news", news);
        return "admin/news/delete-news";
    }

    /**
     * Xử lý xóa tin tức.
     * @param id ID bài viết cần xóa.
     * @return Chuyển hướng về danh sách tin tức.
     */
    @PostMapping("/delete/{id}")
    public String deleteNews(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        newsService.deleteNews(id);
        redirectAttributes.addFlashAttribute("message", "News deleted successfully.");
        return "redirect:/admin/news";
    }

    /**
     * Hiển thị chi tiết tin tức.
     * @param id ID bài viết cần xem.
     * @param model Đối tượng Model để chứa dữ liệu.
     * @return Trang chi tiết tin tức hoặc quay về danh sách nếu không tìm thấy bài viết.
     */
    @GetMapping("/detail/{id}")
    public String showNewsDetail(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }
        model.addAttribute("news", news);
        return "admin/news/detail";
    }

    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        News news = newsService.getNewsById(id);
        if (news != null) {
            news.setStatus(!news.isStatus());
            newsService.saveNews(news);
            redirectAttributes.addFlashAttribute("message", "News status updated successfully.");
        }
        return "redirect:/admin/news";
    }
}
