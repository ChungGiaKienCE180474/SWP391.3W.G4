package group04.gundamshop.controller;

import group04.gundamshop.domain.Voucher;
import group04.gundamshop.service.VoucherService;
import group04.gundamshop.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/voucher")
public class VoucherController {
    private final VoucherService voucherService;
    private final UserService userService;

    public VoucherController(VoucherService voucherService, UserService userService) {
        this.voucherService = voucherService;
        this.userService = userService;
    }

    // ✅ Hiển thị tất cả voucher khi truy cập /voucher (thêm mới để xử lý GET /voucher)
    @GetMapping("")
    public String getVoucherPage(Model model) {
        List<Voucher> vouchers = voucherService.getAllVouchers();
        model.addAttribute("vouchers", vouchers);
        return "customer/voucher/list"; // Trả về trang danh sách voucher
    }

    // ✅ Hiển thị tất cả voucher có sẵn 
    @GetMapping("/all")
    public String getAllVouchers(Model model) {
        List<Voucher> vouchers = voucherService.getAllVouchers();
        model.addAttribute("vouchers", vouchers);
        return "customer/voucher/list"; // Trả về cùng trang danh sách voucher
    }

    // ✅ Tìm kiếm voucher theo mã 
    @GetMapping("/search")
    @ResponseBody
    public Map<String, Object> searchVoucher(@RequestParam("code") String code) {
        Map<String, Object> response = new HashMap<>();

        List<Voucher> vouchers = voucherService.findByCode(code.trim());
        if (!vouchers.isEmpty()) {
            response.put("exists", true);
            response.put("vouchers", vouchers); // Trả về danh sách đầy đủ
        } else {
            response.put("exists", false);
        }

        return response;
    }
}