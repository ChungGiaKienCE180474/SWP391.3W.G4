package group04.gundamshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import group04.gundamshop.domain.Voucher;
import group04.gundamshop.service.VoucherService;

@Controller
@RequestMapping("/voucher")
public class VoucherController {
    private final VoucherService voucherService;

    public VoucherController(VoucherService voucherService) {
        this.voucherService = voucherService;
    }

    // ✅ Hiển thị tất cả voucher khi truy cập /voucher (thêm mới để xử lý GET
    // /voucher)
    @GetMapping({ "", "/all" })
    public String getVoucherPage(Model model) {
        List<Voucher> vouchers = voucherService.getAllValidVouchers();
        model.addAttribute("vouchers", vouchers);
        return "customer/voucher/list"; // Trả về trang danh sách voucher
    }

    // ✅ Tìm kiếm voucher theo mã
    @GetMapping("/search")
    @ResponseBody
    public Map<String, Object> searchVoucher(@RequestParam("code") String code) {
        Map<String, Object> response = new HashMap<>();

        List<Voucher> vouchers = voucherService.searchAllValidVouchersByCode(code.trim());
        if (!vouchers.isEmpty()) {
            response.put("exists", true);
            response.put("vouchers", vouchers); // Trả về danh sách đầy đủ
        } else {
            response.put("exists", false);
        }

        return response;
    }
}