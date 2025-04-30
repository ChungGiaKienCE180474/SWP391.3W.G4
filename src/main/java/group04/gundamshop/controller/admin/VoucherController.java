package group04.gundamshop.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group04.gundamshop.domain.Voucher;
import group04.gundamshop.service.VoucherService;
import jakarta.validation.Valid;

@RequestMapping("/admin/voucher")
@Controller
public class VoucherController {

    @Autowired
    public VoucherService voucherService;

    @GetMapping
    public String getAll(Model model) {
        List<Voucher> vouchers = voucherService.getAllVouchers();
        model.addAttribute("vouchers", vouchers);
        return "/admin/voucher/show";
    }

    @GetMapping("create")
    public String getCreate() {
        return "/admin/voucher/create";
    }

    @PostMapping("create")
    public String postCreate(Model model,
            RedirectAttributes redirectAttributes,
            @ModelAttribute("newVoucher") @Valid Voucher voucher) {
        try {
            voucherService.create(voucher);
            redirectAttributes.addFlashAttribute("successMessage", "Voucher created successfully");
            return "redirect:/admin/voucher";
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "/admin/voucher/create";
        }
    }

    @PostMapping("delete/{id}")
    public String postDelete(Model model,
            RedirectAttributes redirectAttributes,
            @PathVariable long id) {
        try {
            voucherService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Voucher created successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/admin/voucher";
    }

    @GetMapping("update/{id}")
    public String getUpdate(Model model,
            RedirectAttributes redirectAttributes,
            @PathVariable long id) {
        Voucher voucher = voucherService.getById(id);
        if (voucher == null) {
            redirectAttributes.addAttribute("errorMessage", "Voucher with id " + id + " not found");
            return "redirect:/admin/voucher";
        }

        model.addAttribute("voucher", voucher);
        return "/admin/voucher/update";
    }

    @PostMapping("update/{id}")
    public String postUpdate(Model model,
            RedirectAttributes redirectAttributes,
            @PathVariable long id,
            @ModelAttribute("newVoucher") @Valid Voucher voucher) {
        try {
            voucherService.update(id, voucher);
            redirectAttributes.addFlashAttribute("successMessage", "Voucher created successfully");
            return "redirect:/admin/voucher";
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "/admin/voucher/update";
        }
    }
}
