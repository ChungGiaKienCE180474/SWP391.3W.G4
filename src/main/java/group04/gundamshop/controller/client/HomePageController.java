package group04.gundamshop.controller.client;

import group04.gundamshop.domain.Category;
import group04.gundamshop.domain.News;
import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.OrderDetail;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.User;
import group04.gundamshop.service.CategoryService;
import group04.gundamshop.service.NewsService;
import group04.gundamshop.service.OrderService;
import group04.gundamshop.service.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Controller
public class HomePageController {

    private final OrderService orderService;
    private final ProductService productService;
    private final CategoryService categoryService;
    private final NewsService newsService;

    // Constructor injection để đưa các service vào controller
    public HomePageController(ProductService productService, CategoryService categoryService,
            OrderService orderService, NewsService newsService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.orderService = orderService;
        this.newsService = newsService;
    }

    // Phương thức hiển thị trang chủ
    @GetMapping("/")
    public String getHomePage(Model model) {
        // Lấy danh sách sản phẩm, danh mục và tin tức từ service
        List<Product> products = this.productService.fetchProducts();
        List<Category> categories = this.categoryService.getCategoryByStatus(true); // Lấy danh mục đang hoạt động
        List<News> newsList = this.newsService.getActiveNews(); // Lấy tin tức đang hoạt động từ NewsService

        // Thêm các danh sách vào model để hiển thị trong view
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("newsList", newsList); // Thêm danh sách tin tức vào model

        // Trả về view trang chủ
        return "customer/homepage/show";
    }

    // Phương thức hiển thị trang tin tức
    @GetMapping("/news")
    public String showNewsPage(Model model) {
        // Lấy danh sách tin tức và thêm vào model
        List<News> newsList = newsService.getActiveNews();
        model.addAttribute("newsList", newsList);
        return "customer/news/list"; // Chỉ dẫn đến view hiển thị danh sách tin tức
    }

    // Phương thức hiển thị lịch sử đơn hàng của người dùng
    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            long userId = (long) session.getAttribute("id");
            User currentUser = new User();
            currentUser.setId(userId);

            // Lấy danh sách đơn hàng của người dùng từ OrderService
            List<Order> orders = orderService.getOrdersByUser(currentUser);
            model.addAttribute("orders", orders);
        }
        return "customer/order/history"; // Trả về view lịch sử đơn hàng
    }

    // Phương thức hiển thị theo dõi đơn hàng
    @GetMapping("/order-tracking")
    public String getOrderTracking(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            long userId = (long) session.getAttribute("id");
            User currentUser = new User();
            currentUser.setId(userId);

            // Lấy danh sách đơn hàng của người dùng, ngoại trừ các đơn hàng có trạng thái
            // "COMPLETE" và "CANCEL"
            List<Order> orders = orderService.getOrdersByUserAndStatusNotIn(currentUser,
                    Arrays.asList("COMPLETE", "CANCEL"));
            model.addAttribute("orders", orders);
        }
        return "customer/order/tracking"; // Trả về view theo dõi đơn hàng
    }

    // Phương thức hiển thị trang xóa đơn hàng
    @GetMapping("/customer/order-delete/{id}")
    public String getOrderDelete(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        if (currentOrder.isEmpty()) {
            model.addAttribute("error", "Order not found");
            return "error"; // Hoặc redirect
        }
        model.addAttribute("newOrder", currentOrder.get());
        return "customer/order/delete";
    }

    // Phương thức xử lý khi xóa đơn hàng
    @PostMapping("/customer/order/delete")
    @Transactional
    public String postOrderDelete(@ModelAttribute("newOrder") Order order,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {
        // Kiểm tra đơn hàng tồn tại
        Optional<Order> existingOrder = orderService.fetchOrderById(order.getId());
        if (existingOrder.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Order not found");
            return "redirect:/order-tracking";
        }

        Order currentOrder = existingOrder.get();

        // Kiểm tra quyền người dùng
        HttpSession session = request.getSession(false);
        if (session == null || (long) session.getAttribute("id") != currentOrder.getUser().getId()) {
            redirectAttributes.addFlashAttribute("error", "You are not authorized to cancel this order");
            return "redirect:/order-tracking";
        }

        // Kiểm tra trạng thái để tránh hoàn lại nhiều lần
        if (currentOrder.getStatus().equals("CANCEL")) {
            redirectAttributes.addFlashAttribute("error", "Order is already cancelled");
            return "redirect:/order-tracking";
        }

        // Chỉ cho phép hủy khi trạng thái là PENDING
        if (!currentOrder.getStatus().equals("PENDING")) {
            redirectAttributes.addFlashAttribute("error", "Order cannot be cancelled at this stage");
            return "redirect:/order-tracking";
        }

        // Lấy danh sách OrderDetail từ Order
        List<OrderDetail> orderDetails = currentOrder.getOrderDetails();
        if (orderDetails == null || orderDetails.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "No order details found");
            return "redirect:/order-tracking";
        }

        // Hoàn lại số lượng sản phẩm và giảm sold
        for (OrderDetail detail : orderDetails) {
            Product product = detail.getProduct();
            if (product != null) {
                long returnQuantity = detail.getQuantity();
                // Cộng lại quantity và giảm sold
                product.setQuantity(product.getQuantity() + returnQuantity);
                product.setSold(product.getSold() - returnQuantity);
                product.setUpdatedAt(LocalDateTime.now());
                productService.handleSaveProduct(product); // Dùng handleSaveProduct như trong place-order
            } else {
                redirectAttributes.addFlashAttribute("warning",
                        "Product for OrderDetail ID " + detail.getId() + " not found");
            }
        }

        // Cập nhật trạng thái đơn hàng
        currentOrder.setStatus("CANCEL");
        orderService.saveOrder(currentOrder); // Dùng saveOrder như trong place-order

        redirectAttributes.addFlashAttribute("message", "Order cancelled successfully");
        return "redirect:/order-tracking";
    }

    @GetMapping("/news/{id}")
    public String getNewsDetail(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id); // Lấy trực tiếp News thay vì Optional<News>
        model.addAttribute("news", news);
        return "customer/news/detail"; // Hiển thị chi tiết tin tức
    }

}
