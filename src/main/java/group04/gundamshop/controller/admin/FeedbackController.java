package group04.gundamshop.controller.admin;

import group04.gundamshop.domain.ProductReview;
import group04.gundamshop.service.FeedbackService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Controller quản lý phản hồi của khách hàng, cho phép quản trị viên xem và cập nhật trạng thái hiển thị của phản hồi.
 */
@Controller
@RequestMapping("/admin/customer")
public class FeedbackController {

    private final FeedbackService feedbackService;

    /**
     * Constructor khởi tạo FeedbackService.
     *
     * @param feedbackService Dịch vụ xử lý phản hồi.
     */
    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    /**
     * Lấy danh sách phản hồi của một khách hàng cụ thể và hiển thị trên trang quản trị.
     *
     * @param userId ID của khách hàng.
     * @param model  Đối tượng Model để truyền dữ liệu sang view.
     * @return Trang phản hồi của khách hàng.
     */
    @GetMapping("/{userId}/feedback")
    public String getFeedback(@PathVariable Long userId, Model model) {
        // Lấy danh sách phản hồi của khách hàng theo userId
        List<ProductReview> feedbackList = feedbackService.getFeedbackByUserId(userId);
        model.addAttribute("feedbackList", feedbackList);
        model.addAttribute("userId", userId);

        // Tạo một đối tượng phản hồi mẫu để binding form
        model.addAttribute("feedback", new ProductReview());

        return "admin/customer/feedback"; // Trả về trang JSP hiển thị phản hồi
    }

    /**
     * Cập nhật trạng thái hiển thị của một phản hồi cụ thể.
     *
     * @param feedbackId ID của phản hồi cần cập nhật.
     * @param visible    Trạng thái hiển thị mới của phản hồi (có thể là "true" hoặc "false").
     * @return Chuyển hướng về trang phản hồi của khách hàng sau khi cập nhật.
     */
    @PostMapping("/feedback/{feedbackId}")
    public String updateFeedbackVisibility(@PathVariable Long feedbackId, @RequestParam String visible) {
        // Cập nhật trạng thái hiển thị của phản hồi
        feedbackService.updateFeedbackVisibility(feedbackId, visible);

        // Lấy userId của phản hồi vừa cập nhật để chuyển hướng về đúng trang khách hàng
        Long userId = feedbackService.getFeedbackById(feedbackId).getUser().getId();

        return "redirect:/admin/customer/" + userId + "/feedback"; // Điều hướng về trang phản hồi của user
    }
}
