package group04.gundamshop.controller.admin;

import group04.gundamshop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Set;
import java.time.Year;
import java.util.Map;

/**
 * Controller quản lý trang tổng quan dành cho Admin, bao gồm thống kê doanh thu theo năm.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    private final OrderService orderService;

    /**
     * Khởi tạo AdminController với OrderService để lấy dữ liệu thống kê.
     * @param orderService Dịch vụ quản lý đơn hàng.
     */
    @Autowired
    public AdminController(OrderService orderService) {
        this.orderService = orderService;
    }

    /**
     * Hiển thị trang thống kê doanh thu theo năm.
     * Nếu không có năm được chọn, mặc định sử dụng năm hiện tại.
     *
     * @param year Năm cần thống kê, nếu không có sẽ lấy năm hiện tại.
     * @param model Model để truyền dữ liệu đến giao diện.
     * @return Tên template hiển thị trang thống kê.
     */
    @GetMapping
    public String showStatistics(@RequestParam(value = "year", required = false) Integer year, Model model) {
        // Nếu không có năm được chọn, sử dụng năm hiện tại
        if (year == null) {
            year = Year.now().getValue();
        }

        // Log năm nhận được từ client
        System.out.println("Received year: " + year);

        // Lấy doanh thu theo từng tháng của năm được chọn
        Map<Integer, Double> monthlyRevenue = orderService.getMonthlyRevenueForYear(year);

        // Lấy danh sách các năm có dữ liệu thống kê
        Set<Integer> yearsWithData = orderService.getYearsWithData();

        // Đưa dữ liệu vào model để hiển thị trên giao diện
        model.addAttribute("monthlyRevenue", monthlyRevenue); // Dữ liệu doanh thu từng tháng
        model.addAttribute("selectedYear", year); // Năm được chọn
        model.addAttribute("yearsWithData", yearsWithData); // Các năm có dữ liệu

        // Trả về trang thống kê doanh thu
        return "admin/homepage/statistics";
    }
}
