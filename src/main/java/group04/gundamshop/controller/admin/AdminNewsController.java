package group04.gundamshop.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
                             @RequestParam("image_url") MultipartFile file) {
        String imageUrl = null;

        // Nếu file không rỗng, lưu ảnh vào thư mục 'news'
        if (!file.isEmpty()) {
            imageUrl = uploadNewsService.handleSaveUploadFile(file, "news");
        }

        // Tạo đối tượng News và lưu vào DB
        News news = new News(title, content, imageUrl);
        newsService.saveNews(news);
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
                             @RequestParam("image") MultipartFile file) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }

        // Cập nhật thông tin bài viết
        news.setTitle(title);
        news.setContent(content);

        // Nếu có file ảnh mới, cập nhật ảnh
        if (!file.isEmpty()) {
            String imageUrl = uploadNewsService.handleSaveUploadFile(file, "news");
            news.setImageUrl(imageUrl);
        }

        newsService.saveNews(news);
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
    public String deleteNews(@PathVariable Long id) {
        newsService.deleteNews(id);
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
}