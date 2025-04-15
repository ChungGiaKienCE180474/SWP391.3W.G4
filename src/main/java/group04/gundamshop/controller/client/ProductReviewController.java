package group04.gundamshop.controller.client;

import group04.gundamshop.domain.OrderDetail;
import group04.gundamshop.domain.ProductReview;
import group04.gundamshop.domain.User;
import group04.gundamshop.service.OrderDetailService;
import group04.gundamshop.service.ProductReviewService;
import group04.gundamshop.service.ProductService;
import group04.gundamshop.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import java.util.Optional;

// Import thêm các thư viện cần thiết nếu chưa có


@Controller

public class ProductReviewController {

    private final ProductService productService;
    private final UserService userService;
    private final ProductReviewService productReviewService;
    private final OrderDetailService orderDetailService;

    public ProductReviewController(ProductService productService, UserService userService,
                                   ProductReviewService productReviewService, OrderDetailService orderDetailService) {
        this.productService = productService;
        this.userService = userService;
        this.productReviewService = productReviewService;
        this.orderDetailService = orderDetailService;
    }

    @GetMapping("/customer/product-review/{orderDetailId}")
    public String showReviewPage(@PathVariable long orderDetailId, Model model, HttpSession session) {
        OrderDetail orderDetail = orderDetailService.findById(orderDetailId).orElse(null);
        String email = (String) session.getAttribute("email");
        Optional<User> user = userService.getUserByEmail(email);

        if (orderDetail == null || user.isEmpty()) {
            return "error/404";
        }

        // Kiểm tra xem đã có đánh giá cho OrderDetail này hay chưa
        ProductReview existingReview = productReviewService.findByOrderDetail(orderDetail);

        model.addAttribute("product", orderDetail.getProduct());
        model.addAttribute("user", user);
        model.addAttribute("orderDetail", orderDetail);
        model.addAttribute("existingReview", existingReview); // Truyền thông tin đánh giá hiện tại (nếu có)

        // Thêm cờ kiểm tra cho giao diện
        model.addAttribute("isReviewed", existingReview != null); // true nếu đã đánh giá
        return "customer/product/review";
    }

    @PostMapping("/customer/submit-review/{orderDetailId}")
    public String submitReview(@PathVariable long orderDetailId,
                               @RequestParam(value = "rating", required = false) Integer rating, // Đánh giá sao có thể là null
                               @RequestParam("reviewContent") String reviewContent,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {

        String email = (String) session.getAttribute("email");
        Optional<User> user = userService.getUserByEmail(email);
        OrderDetail orderDetail = orderDetailService.findById(orderDetailId).orElse(null);

        if (orderDetail == null) {
            return "error/404"; // Nếu không tìm thấy OrderDetail
        }

        ProductReview review = productReviewService.findByOrderDetail(orderDetail);

        if (review == null) {
            // Tạo đánh giá mới
            review = new ProductReview();
            review.setOrderDetail(orderDetail);
            review.setUser(user.orElse(null));
            review.setProduct(orderDetail.getProduct());
            review.setRating(rating); // Chỉ cho phép set khi là đánh giá mới
        } else {
            // Nếu đã có đánh giá, không cho phép cập nhật rating
            if (rating != null) {
                redirectAttributes.addFlashAttribute("error", "Bạn không thể cập nhật số sao đã đánh giá.");
                return "redirect:/customer/product-review/" + orderDetailId;
            }
        }

        // Cập nhật nội dung đánh giá
        review.setReviewContent(reviewContent);
        productReviewService.saveProductReview(review);

        redirectAttributes.addFlashAttribute("message", "Đánh giá của bạn đã được cập nhật!");
        return "redirect:/customer/product/review-success";
    }
    //chuyển hướng qua trang đánh giá thành công
    @GetMapping("/customer/product/review-success")
    public String reviewSuccess(Model model) {
        model.addAttribute("message", "Cảm ơn bạn đã đánh giá sản phẩm!");
        return "customer/product/review-success";
    }
}



