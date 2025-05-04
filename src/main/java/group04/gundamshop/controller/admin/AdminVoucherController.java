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
import group04.gundamshop.domain.dto.UpsertVoucherDTO;
import group04.gundamshop.service.VoucherService;
import jakarta.validation.Valid;

@RequestMapping("/admin/voucher")
@Controller
public class AdminVoucherController {

    @Autowired
    public VoucherService voucherService;

    @GetMapping
    public String getAll(Model model) {
        List<Voucher> vouchers = voucherService.getAllVouchersOrderByIdDesc();
        model.addAttribute("vouchers", vouchers);
        return "admin/voucher/show";
    }

    @GetMapping("{id}")
    public String getById(Model model, RedirectAttributes redirectAttributes, @PathVariable Long id) {
        Voucher voucher = voucherService.getById(id);
        if (voucher == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Voucher with id " + id + " not found");
            return "redirect:/admin/voucher";
        }

        model.addAttribute("voucher", voucher);
        return "admin/voucher/detail";
    }

    @GetMapping("create")
    public String getCreate(Model model) {
        model.addAttribute("newVoucher", new Voucher());
        return "admin/voucher/create";
    }

    @PostMapping("create")
    public String postCreate(Model model,
            RedirectAttributes redirectAttributes,
            @ModelAttribute("newVoucher") @Valid UpsertVoucherDTO upsertVoucherDTO) {
        try {
            voucherService.create(upsertVoucherDTO.mapToVoucher());
            redirectAttributes.addFlashAttribute("successMessage", "Voucher created successfully");
            return "redirect:/admin/voucher";
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "admin/voucher/create";
        }
    }

    @GetMapping("delete/{id}")
    public String getDelete(Model model,
            RedirectAttributes redirectAttributes,
            @PathVariable long id) {
        try {
            voucherService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Voucher deleted successfully");
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
            redirectAttributes.addFlashAttribute("errorMessage", "Voucher with id " + id + " not found");
            return "redirect:/admin/voucher";
        }

        model.addAttribute("voucher", voucher);
        return "admin/voucher/update";
    }

    @PostMapping("update/{id}")
    public String postUpdate(Model model,
            RedirectAttributes redirectAttributes,
            @PathVariable long id,
            @ModelAttribute("voucher") @Valid UpsertVoucherDTO upsertVoucherDTO) {
        try {
            voucherService.update(id, upsertVoucherDTO.mapToVoucher());
            redirectAttributes.addFlashAttribute("successMessage", "Voucher " + id + " updated successfully");
            return "redirect:/admin/voucher";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/voucher/update/" + id;
        }
    }
}
