package group04.gundamshop.controller.admin;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.User;
import group04.gundamshop.service.OrderService;
import group04.gundamshop.service.UserService;
// Import interface OrderService từ gói group04.gundamshop.service, định nghĩa các phương thức thao tác với đơn hàng.

/**
 * Controller quản lý các đơn hàng, cho phép quản trị viên xem, cập nhật, xóa và
 * quản lý lịch sử mua hàng của khách hàng.
 */// Mô tả chức năng của controller.
@Controller
// Đánh dấu lớp này là một controller, cho phép Spring Framework quản lý nó.
public class OrderController {

    private final OrderService orderService;
    // Khai báo một biến final thuộc kiểu OrderService, đại diện cho service xử lý
    // đơn hàng.
    private final UserService userService;
    // Khai báo một biến final thuộc kiểu UserService, đại diện cho service xử lý
    // người dùng.

    /**
     * Constructor khởi tạo dịch vụ đơn hàng và dịch vụ người dùng.
     *
     * @param orderService Dịch vụ quản lý đơn hàng.
     * @param userService  Dịch vụ quản lý người dùng.
     */
    public OrderController(OrderService orderService, UserService userService) {
        // Constructor của lớp OrderController.
        this.orderService = orderService;
        // Khởi tạo orderService bằng giá trị được truyền vào.
        this.userService = userService;
        // Khởi tạo userService bằng giá trị được truyền vào.
    }

    /**
     * Lấy danh sách tất cả các đơn hàng và hiển thị trên trang quản trị.
     *
     * @param model Đối tượng Model để truyền dữ liệu sang view.
     * @return Trang hiển thị danh sách đơn hàng.
     */
    @GetMapping("/admin/order")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/order" đến phương thức này.
    public String getDashboard(Model model) {
        // Phương thức xử lý yêu cầu hiển thị danh sách đơn hàng.
        List<Order> orders = this.orderService.fetchAllOrders();
        // Lấy danh sách tất cả các đơn hàng từ orderService.
        model.addAttribute("orders", orders);
        // Thêm danh sách đơn hàng vào model để truyền đến view.
        return "admin/order/show";
        // Trả về tên view để hiển thị danh sách đơn hàng.
    }

    /**
     * Lấy chi tiết của một đơn hàng cụ thể và hiển thị trên trang quản trị.
     *
     * @param model Đối tượng Model để truyền dữ liệu sang view.
     * @param id    ID của đơn hàng cần xem chi tiết.
     * @return Trang hiển thị chi tiết đơn hàng.
     */
    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Order order = this.orderService.fetchOrderById(id).get();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        String formattedDate = order.getOrderDate().format(formatter);

        model.addAttribute("order", order);
        model.addAttribute("id", id);
        model.addAttribute("orderDetails", order.getOrderDetails());
        model.addAttribute("formattedOrderDate", formattedDate);

        return "admin/order/detail";
    }

    /**
     * Hiển thị trang cập nhật đơn hàng.
     *
     * @param model Đối tượng Model để truyền dữ liệu sang view.
     * @param id    ID của đơn hàng cần cập nhật.
     * @return Trang cập nhật đơn hàng.
     */
    @GetMapping("/admin/order/update/{id}")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ "/admin/order/update/{id}" đến phương
    // thức này.
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        // Phương thức xử lý yêu cầu hiển thị trang cập nhật đơn hàng.
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        // Lấy đơn hàng từ database dựa trên ID.
        model.addAttribute("newOrder", currentOrder.get());
        // Thêm đơn hàng vào model để form cập nhật có thể sử dụng.
        return "admin/order/update";
        // Trả về tên view để hiển thị trang cập nhật đơn hàng.
    }

    /**
     * Xử lý yêu cầu cập nhật thông tin đơn hàng.
     *
     * @param order Đối tượng đơn hàng chứa thông tin mới.
     * @return Chuyển hướng đến trang danh sách đơn hàng sau khi cập nhật.
     */
    @PostMapping("/admin/order/update")
    // Ánh xạ các yêu cầu HTTP POST đến địa chỉ "/admin/order/update" đến phương
    // thức này.
    public String handleUpdateOrder(@ModelAttribute("newOrder") Order order) {
        // Phương thức xử lý yêu cầu cập nhật đơn hàng.
        this.orderService.updateOrder(order);
        // Cập nhật thông tin đơn hàng vào database.
        return "redirect:/admin/order";
        // Chuyển hướng đến trang danh sách đơn hàng.
    }

    /**
     * Lấy lịch sử mua hàng của một khách hàng cụ thể và hiển thị trên trang quản
     * trị.
     *
     * @param customerId ID của khách hàng cần xem lịch sử mua hàng.
     * @param model      Đối tượng Model để truyền dữ liệu sang view.
     * @return Trang hiển thị lịch sử mua hàng của khách hàng.
     */
    @GetMapping("/admin/customer/{customerId}/purchase-history")
    // Ánh xạ các yêu cầu HTTP GET đến địa chỉ
    // "/admin/customer/{customerId}/purchase-history" đến phương thức này.
    public String getPurchaseHistory(@PathVariable long customerId, Model model) {
        // Phương thức xử lý yêu cầu hiển thị lịch sử mua hàng của khách hàng.
        // Tìm kiếm khách hàng theo customerId
        Optional<User> customer = userService.findUserById(customerId);
        // Lấy thông tin khách hàng từ database dựa trên ID.
        // Kiểm tra khách hàng có tồn tại hay không
        if (customer.isPresent()) {
            // Kiểm tra nếu khách hàng tồn tại.
            // Nếu khách hàng tồn tại, lấy danh sách đơn hàng của họ
            List<Order> orders = orderService.fetchOrdersByCustomerId(customerId);
            // Lấy danh sách đơn hàng của khách hàng từ database.
            // Đưa dữ liệu khách hàng và danh sách đơn hàng vào model để hiển thị trên view
            model.addAttribute("customer", customer);
            // Thêm thông tin khách hàng vào model để trang lịch sử mua hàng có thể sử dụng.
            model.addAttribute("orders", orders);
            // Thêm danh sách đơn hàng vào model.
        } else {
            // Nếu khách hàng không tồn tại, thêm thông báo lỗi vào model
            model.addAttribute("error", "Customer not found");
            // Thêm thông báo lỗi vào model.
        }
        // Trả về đường dẫn trang hiển thị lịch sử mua hàng của khách hàng
        return "admin/customer/purchaseHistory";
        // Trả về tên view để hiển thị trang lịch sử mua hàng.
    }

    @GetMapping("/customer/order/cancelled")
    public String getCancelledOrders(Model model) {
        List<Order> cancelledOrders = orderService.getCancelledOrders().stream()
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId())) // Sort by ID descending
                .collect(Collectors.toList());
        model.addAttribute("orders", cancelledOrders);
        return "customer/order/cancelled";
    }

    @GetMapping("/customer/order/rated")
    public String getRatedOrders(Model model) {
        List<Order> ratedOrders = orderService.getRatedOrders().stream()
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId())) // Sort by ID descending
                .collect(Collectors.toList());
        model.addAttribute("orders", ratedOrders);
        return "customer/order/rated";
    }

    @GetMapping("/customer/order/unrated")
    public String getUnratedOrders(Model model) {
        List<Order> unratedOrders = orderService.getUnratedOrders().stream()
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId())) // Sort by ID descending
                .collect(Collectors.toList());
        model.addAttribute("orders", unratedOrders);
        return "customer/order/unrated";
    }

    @GetMapping("/customer/order/history")
    public String getOrderHistory(Model model) {
        List<Order> historyOrders = orderService.fetchAllOrders().stream()
                .filter(order -> "COMPLETE".equals(order.getStatus()) || "CANCEL".equals(order.getStatus()))
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId())) // Sort by ID descending
                .collect(Collectors.toList());
        model.addAttribute("orders", historyOrders);
        return "customer/order/history";
    }

    @GetMapping("/customer/order/tracking")
    public String getOrderTracking(Model model) {
        List<Order> trackingOrders = orderService.fetchAllOrders().stream()
                .filter(order -> !"COMPLETE".equals(order.getStatus()) && !"CANCEL".equals(order.getStatus()))
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId())) // Sort by ID descending
                .collect(Collectors.toList());
        model.addAttribute("orders", trackingOrders);
        return "customer/order/tracking";
    }

    /**
     * Cập nhật trạng thái đơn hàng thành COMPLETE (dùng cho đơn hàng BANKING).
     *
     * @param id ID của đơn hàng cần cập nhật.
     * @return Chuyển hướng đến trang danh sách đơn hàng.
     */
    @GetMapping("/admin/order/update-to-complete/{id}")
    public String updateOrderToComplete(@PathVariable long id) {
        Optional<Order> optionalOrder = orderService.fetchOrderById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setStatus("COMPLETE");
            orderService.updateOrder(order);
        }
        return "redirect:/admin/order";
    }
}