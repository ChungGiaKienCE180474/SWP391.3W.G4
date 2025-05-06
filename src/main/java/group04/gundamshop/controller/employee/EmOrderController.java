package group04.gundamshop.controller.employee;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import group04.gundamshop.domain.Order;
import group04.gundamshop.service.OrderService;

@Controller
public class EmOrderController {

    private final OrderService orderService;

    public EmOrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/employee/order")
    public String getDashboard(Model model) {
        List<Order> orders = this.orderService.fetchAllOrders();
        model.addAttribute("orders", orders);
        return "employee/order/show";
    }

    @GetMapping("/employee/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Order order = this.orderService.fetchOrderById(id).get();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        String formattedDate = order.getOrderDate().format(formatter);

        model.addAttribute("order", order);
        model.addAttribute("id", id);
        model.addAttribute("orderDetails", order.getOrderDetails());
        model.addAttribute("formattedOrderDate", formattedDate);

        return "employee/order/detail";
    }

    @GetMapping("/employee/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newOrder", new Order());
        return "employee/order/delete";
    }

    @PostMapping("/employee/order/delete")
    public String postDeleteOrder(@ModelAttribute("newOrder") Order order) {
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/employee/order";
    }

    @GetMapping("/employee/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        model.addAttribute("newOrder", currentOrder.get());
        return "employee/order/update";
    }

    @PostMapping("/employee/order/update")
    public String handleUpdateOrder(@ModelAttribute("newOrder") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/employee/order";
    }

    /**
     * Cập nhật trạng thái đơn hàng thành COMPLETE (dùng cho đơn hàng BANKING).
     *
     * @param id ID của đơn hàng cần cập nhật.
     * @return Chuyển hướng đến trang danh sách đơn hàng.
     */
    // @GetMapping("/employee/order/update-to-complete/{id}")
    // public String updateOrderToComplete(@PathVariable long id) {
    //     Optional<Order> optionalOrder = orderService.fetchOrderById(id);
    //     if (optionalOrder.isPresent()) {
    //         Order order = optionalOrder.get();
    //         order.setStatus("COMPLETE");
    //         orderService.updateOrder(order);
    //     }
    //     return "redirect:/employee/order";
    // }
}
