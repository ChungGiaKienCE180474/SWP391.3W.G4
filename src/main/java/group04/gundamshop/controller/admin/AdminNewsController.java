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
        java.util.List<News> newsList = newsService.getAllNews();
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd 'at' HH:mm");
        java.util.List<java.util.Map<String, Object>> formattedNewsList = new java.util.ArrayList<>();
        for (News news : newsList) {
            java.util.Map<String, Object> newsMap = new java.util.HashMap<>();
            newsMap.put("id", news.getId());
            newsMap.put("title", news.getTitle());
            newsMap.put("content", news.getContent());
            newsMap.put("imageUrl", news.getImageUrl());
            newsMap.put("status", news.isStatus());
            newsMap.put("referenceLinks", news.getReferenceLinks());
            newsMap.put("createdAtFormatted", news.getCreatedAt() != null ? news.getCreatedAt().format(formatter) : null);
            newsMap.put("updatedAtFormatted", news.getUpdatedAt() != null ? news.getUpdatedAt().format(formatter) : null);
            formattedNewsList.add(newsMap);
        }
        model.addAttribute("newsList", formattedNewsList);
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
                             @RequestParam(value = "referenceLinks", required = false) java.util.List<String> referenceLinks,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        // Validate title and content
        final boolean[] hasErrors = {false};
        if (title == null || title.trim().isEmpty()) {
            model.addAttribute("titleError", "Title cannot be empty or whitespace.");
            hasErrors[0] = true;
        } else {
            String trimmedTitle = title.trim();
            // Validate title length > 3
            if (trimmedTitle.length() <= 3) {
                model.addAttribute("titleError", "Title must be longer than 3 characters.");
                hasErrors[0] = true;
            }
            // Validate first character is a letter (including Vietnamese accented letters)
            else if (!trimmedTitle.substring(0, 1).matches("[\\p{L}]")) {
                model.addAttribute("titleError", "Title must start with a letter.");
                hasErrors[0] = true;
            }
            // Validate no special characters or whitespace at start (already checked first char)
            // Check for duplicates case-insensitive
            else {
                java.util.List<News> existingNewsList = newsService.getNewsByTitleIgnoreCase(trimmedTitle);
                if (!existingNewsList.isEmpty()) {
                    model.addAttribute("titleError", "Title already exists. Please choose a different title.");
                    hasErrors[0] = true;
                }
            }
        }
        if (content == null || content.trim().isEmpty()) {
            model.addAttribute("contentError", "Content cannot be empty or whitespace.");
            hasErrors[0] = true;
        } else {
            String trimmedContent = content.trim();
            // Validate content length > 3
            if (trimmedContent.length() <= 3) {
                model.addAttribute("contentError", "Content must be longer than 3 characters.");
                hasErrors[0] = true;
            }
            // Validate first character is a letter (including Vietnamese accented letters)
            else if (!trimmedContent.substring(0, 1).matches("[\\p{L}]")) {
                model.addAttribute("contentError", "Content must start with a letter.");
                hasErrors[0] = true;
            }
        }
        if (hasErrors[0]) {
            // Preserve original input including leading/trailing spaces
            model.addAttribute("news", new News(title, content, null));
            return "admin/news/create-news";
        }

        String imageUrl = null;
        if (!file.isEmpty()) {
            imageUrl = uploadNewsService.handleSaveUploadFile(file, "news");
        }

        News news = new News(title, content, imageUrl);
        news.setReferenceLinks(referenceLinks != null ? referenceLinks : new java.util.ArrayList<>());
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
                             @RequestParam(value = "status", required = false) Boolean status,
                             @RequestParam(value = "referenceLinks", required = false) java.util.List<String> referenceLinks,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }

        // Validate title and content
        final boolean[] hasErrors = {false};
        if (title == null || title.trim().isEmpty()) {
            model.addAttribute("titleError", "Title cannot be empty or whitespace.");
            hasErrors[0] = true;
        }
        if (content == null || content.trim().isEmpty()) {
            model.addAttribute("contentError", "Content cannot be empty or whitespace.");
            hasErrors[0] = true;
        }
        // Normalize title before checking duplicate excluding current news
        String trimmedTitle = title.trim();
        // Validate title length > 3
        if (trimmedTitle.length() <= 3) {
            model.addAttribute("titleError", "Title must be longer than 3 characters.");
            hasErrors[0] = true;
        }
        // Validate first character is a letter (including Vietnamese accented letters)
        else if (!trimmedTitle.substring(0, 1).matches("[\\p{L}]")) {
            model.addAttribute("titleError", "Title must start with a letter.");
            hasErrors[0] = true;
        }
        // Check for duplicates case-insensitive excluding current news
        else {
                java.util.List<News> existingNewsList = newsService.getNewsByTitleIgnoreCase(trimmedTitle);
            boolean duplicateFound = false;
            for (News existingNews : existingNewsList) {
                if (existingNews.getId() != null && !existingNews.getId().equals(id)) {
                    if (existingNews.getTitle().equalsIgnoreCase(trimmedTitle)) {
                        duplicateFound = true;
                        break;
                    }
                }
            }
            if (duplicateFound) {
                model.addAttribute("titleError", "Title already exists. Please choose a different title.");
                hasErrors[0] = true;
                model.addAttribute("news", news);
                return "admin/news/update-news";
            }
        }
        if (content == null || content.trim().isEmpty()) {
            model.addAttribute("contentError", "Content cannot be empty or whitespace.");
            hasErrors[0] = true;
        } else {
            String trimmedContent = content.trim();
            // Validate content length > 3
            if (trimmedContent.length() <= 3) {
                model.addAttribute("contentError", "Content must be longer than 3 characters.");
                hasErrors[0] = true;
            }
            // Validate first character is a letter (including Vietnamese accented letters)
            else if (!trimmedContent.substring(0, 1).matches("[\\p{L}]")) {
                model.addAttribute("contentError", "Content must start with a letter.");
                hasErrors[0] = true;
            }
        }
        if (hasErrors[0]) {
            news.setTitle(title);
            if (status != null) {
                news.setStatus(status);
            }
            if (referenceLinks != null) {
                java.util.List<String> filteredLinks = new java.util.ArrayList<>();
                for (String link : referenceLinks) {
                    if (link != null && !link.trim().isEmpty()) {
                        filteredLinks.add(link.trim());
                    }
                }
                news.setReferenceLinks(filteredLinks);
            }
            model.addAttribute("news", news);
            return "admin/news/update-news";
        }

        news.setTitle(title);
        news.setContent(content);
        if (status != null) {
            news.setStatus(status);
        }
        if (referenceLinks != null) {
            java.util.List<String> filteredLinks = new java.util.ArrayList<>();
            for (String link : referenceLinks) {
                if (link != null && !link.trim().isEmpty()) {
                    filteredLinks.add(link.trim());
                }
            }
            news.setReferenceLinks(filteredLinks);
        } else {
            news.setReferenceLinks(new java.util.ArrayList<>());
        }
        System.out.println("Reference links on save: " + news.getReferenceLinks());

        news.setUpdatedAt(java.time.LocalDateTime.now());

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
