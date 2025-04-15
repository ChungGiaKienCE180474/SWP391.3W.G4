package group04.gundamshop.controller.client;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import group04.gundamshop.domain.Category;
import group04.gundamshop.domain.News;
import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.User;
import group04.gundamshop.domain.dto.ProductCriteriaDTO;
import group04.gundamshop.service.CategoryService;
import group04.gundamshop.service.NewsService;
import group04.gundamshop.service.OrderService;
import group04.gundamshop.service.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomePageController {

    private final OrderService orderService;
    private final ProductService productService;
    private final CategoryService categoryService;
    private final NewsService newsService; // Thêm NewsService để lấy thông tin tin tức

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
        List<News> newsList = this.newsService.getAllNews(); // Lấy tất cả tin tức từ NewsService

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
        List<News> newsList = newsService.getAllNews();
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

            // Lấy danh sách đơn hàng của người dùng, ngoại trừ các đơn hàng có trạng thái "COMPLETE" và "CANCEL"
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
        model.addAttribute("newOrder", currentOrder.get()); // Thêm đơn hàng cần xóa vào model
        return "customer/order/delete"; // Trả về view xóa đơn hàng
    }

    // Phương thức xử lý khi xóa đơn hàng
    @PostMapping("/customer/order/delete")
    public String postOrderDelete(@ModelAttribute("newOrder") Order order) {
        // Cập nhật trạng thái của đơn hàng khi xóa
        this.orderService.updateOrder(order);
        return "redirect:/order-tracking"; // Chuyển hướng về trang theo dõi đơn hàng
    }
    @GetMapping("/news/{id}")
    public String getNewsDetail(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id); // Lấy trực tiếp News thay vì Optional<News>
        model.addAttribute("news", news);
        return "customer/news/detail"; // Hiển thị chi tiết tin tức
    }


}
