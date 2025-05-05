package group04.gundamshop.controller.admin;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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

@Controller
public class OrderController {

    private final OrderService orderService;
    private final UserService userService;

    public OrderController(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    // Existing methods (unchanged)
    @GetMapping("/admin/order")
    public String getDashboard(Model model) {
        List<Order> orders = this.orderService.fetchAllOrders();
        model.addAttribute("orders", orders);
        return "admin/order/show";
    }

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

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        model.addAttribute("newOrder", currentOrder.get());
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String handleUpdateOrder(@ModelAttribute("newOrder") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/customer/{customerId}/purchase-history")
    public String getPurchaseHistory(@PathVariable long customerId, Model model) {
        Optional<User> customer = userService.findUserById(customerId);
        if (customer.isPresent()) {
            List<Order> orders = orderService.fetchOrdersByCustomerId(customerId);
            model.addAttribute("customer", customer);
            model.addAttribute("orders", orders);
        } else {
            model.addAttribute("error", "Customer not found");
        }
        return "admin/customer/purchaseHistory";
    }

    @GetMapping("/customer/order/cancelled")
    public String getCancelledOrders(Model model) {
        User currentUser = getAuthenticatedUser();
        if (currentUser == null) {
            return handleUnauthenticated(model, "customer/order/cancelled");
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        List<Order> cancelledOrders = orderService.getOrdersByUser(currentUser)
                .stream()
                .filter(order -> "CANCEL".equals(order.getStatus()))
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId()))
                .peek(order -> order.setConvertedCancelDate(
                        order.getCancelDate() != null ? order.getCancelDate().format(formatter)
                                : order.getOrderDate().format(formatter)))
                .collect(Collectors.toList());
        model.addAttribute("orders", cancelledOrders);
        return "customer/order/cancelled";
    }

    @GetMapping("/customer/order/rated")
    public String getRatedOrders(Model model) {
        User currentUser = getAuthenticatedUser();
        if (currentUser == null) {
            return handleUnauthenticated(model, "customer/order/rated");
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        List<Order> ratedOrders = orderService.getOrdersByUser(currentUser)
                .stream()
                .filter(order -> "COMPLETE".equals(order.getStatus()) && order.getOrderDetails().stream()
                        .anyMatch(detail -> detail.getProductReview() != null))
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId()))
                .peek(order -> order.setConvertedCompleteDate(
                        order.getCompleteDate() != null ? order.getCompleteDate().format(formatter)
                                : order.getOrderDate().format(formatter)))
                .collect(Collectors.toList());
        model.addAttribute("orders", ratedOrders);
        return "customer/order/rated";
    }

    @GetMapping("/customer/order/unrated")
    public String getUnratedOrders(Model model) {
        User currentUser = getAuthenticatedUser();
        if (currentUser == null) {
            return handleUnauthenticated(model, "customer/order/unrated");
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        List<Order> unratedOrders = orderService.getOrdersByUser(currentUser)
                .stream()
                .filter(order -> "COMPLETE".equals(order.getStatus()) && order.getOrderDetails().stream()
                        .anyMatch(detail -> detail.getProductReview() == null))
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId()))
                .peek(order -> order.setConvertedCompleteDate(
                        order.getCompleteDate() != null ? order.getCompleteDate().format(formatter)
                                : order.getOrderDate().format(formatter)))
                .collect(Collectors.toList());
        model.addAttribute("orders", unratedOrders);
        return "customer/order/unrated";
    }

    @GetMapping("/customer/order/history")
    public String getOrderHistory(Model model) {
        User currentUser = getAuthenticatedUser();
        if (currentUser == null) {
            return handleUnauthenticated(model, "customer/order/history");
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        List<Order> historyOrders = orderService.getOrdersByUser(currentUser)
                .stream()
                .filter(order -> "COMPLETE".equals(order.getStatus()) || "CANCEL".equals(order.getStatus()))
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId()))
                .peek(order -> order.setConvertedCompleteDate(
                        order.getCompleteDate() != null ? order.getCompleteDate().format(formatter)
                                : order.getOrderDate().format(formatter)))
                .collect(Collectors.toList());
        model.addAttribute("orders", historyOrders);
        return "customer/order/history";
    }

    @GetMapping("/customer/order/tracking")
    public String getOrderTracking(Model model) {
        User currentUser = getAuthenticatedUser();
        if (currentUser == null) {
            return handleUnauthenticated(model, "customer/order/tracking");
        }
        List<Order> trackingOrders = orderService.getOrdersByUser(currentUser)
                .stream()
                .filter(order -> !"COMPLETE".equals(order.getStatus()) && !"CANCEL".equals(order.getStatus()))
                .sorted((o1, o2) -> Long.compare(o2.getId(), o1.getId()))
                .collect(Collectors.toList());
        model.addAttribute("orders", trackingOrders);
        return "customer/order/tracking";
    }

    // @GetMapping("/admin/order/update-to-complete/{id}")
    // public String updateOrderToComplete(@PathVariable long id) {
    // Optional<Order> optionalOrder = orderService.fetchOrderById(id);
    // if (optionalOrder.isPresent()) {
    // Order order = optionalOrder.get();
    // order.setStatus("COMPLETE");
    // orderService.updateOrder(order);
    // }
    // return "redirect:/admin/order";
    // }

    // New helper methods
    private User getAuthenticatedUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()
                || authentication.getPrincipal().equals("anonymousUser")) {
            return null;
        }
        String email = authentication.getName();
        return userService.findByEmail(email).orElse(null);
    }

    private String handleUnauthenticated(Model model, String view) {
        model.addAttribute("error", "Please log in to view your orders");
        return "redirect:/login";
    }
}