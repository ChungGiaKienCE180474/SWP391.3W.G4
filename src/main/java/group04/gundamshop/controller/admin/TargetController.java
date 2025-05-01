package group04.gundamshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;

import jakarta.validation.Valid;
import group04.gundamshop.domain.Target;
import group04.gundamshop.service.TargetService;

@Controller
public class TargetController {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // Trim all string inputs and convert empty strings to null
        StringTrimmerEditor stringTrimmer = new StringTrimmerEditor(true);
        binder.registerCustomEditor(String.class, stringTrimmer);
    }

    private final TargetService targetService;

    public TargetController(TargetService targetService) {
        this.targetService = targetService;
    }

    @GetMapping("/admin/target")
    public String getTargetList(Model model) {
        List<Target> targets = targetService.getAllTargets();
        model.addAttribute("targets", targets);
        return "admin/target/show";
    }

    @GetMapping("/admin/target/create")
    public String getCreateTargetPage(Model model) {
        model.addAttribute("newTarget", new Target());
        return "admin/target/create";
    }

    @PostMapping("/admin/target/create")
    public String createTarget(Model model, @ModelAttribute("newTarget") @Valid Target target,
            BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        // Check for duplicate name
        Target existingTarget = targetService.getTargetByName(target.getName());
        if (existingTarget != null) {
            bindingResult.rejectValue("name", "error.target", "Target name already exists.");
        }
        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println(error.getField() + " - " + error.getDefaultMessage());
            }
            return "admin/target/create";
        }
        targetService.saveTarget(target);
        redirectAttributes.addFlashAttribute("message", "Target created successfully.");
        return "redirect:/admin/target";
    }

    @GetMapping("/admin/target/update/{id}")
    public String getUpdateTargetPage(Model model, @PathVariable long id) {
        Optional<Target> targetOpt = targetService.getTargetById(id);
        if (targetOpt.isEmpty()) {
            return "redirect:/admin/target";
        }
        model.addAttribute("newTarget", targetOpt.get());
        return "admin/target/update";
    }

    @PostMapping("/admin/target/update")
    public String postUpdateTarget(Model model, @ModelAttribute("newTarget") @Valid Target target,
            BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        // Check for duplicate name excluding current target
        Target existingTarget = targetService.getTargetByName(target.getName());
        if (existingTarget != null && existingTarget.getId() != target.getId()) {
            bindingResult.rejectValue("name", "error.target", "Target name already exists.");
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("newTarget", target);
            return "admin/target/update";
        }
        targetService.saveTarget(target);
        redirectAttributes.addFlashAttribute("message", "Target updated successfully.");
        return "redirect:/admin/target";
    }

    @GetMapping("/admin/target/delete/{id}")
    public String getDeleteTargetPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("target", new Target());
        return "admin/target/delete";
    }

    @PostMapping("/admin/target/delete")
    public String postDeleteTarget(Model model, @ModelAttribute("target") Target target, RedirectAttributes redirectAttributes) {
        if (targetService.isTargetAssigned(target.getId())) {
            model.addAttribute("id", target.getId());
            model.addAttribute("assigned", true);
            return "admin/target/delete";
        }
        targetService.deleteTarget(target.getId());
        redirectAttributes.addFlashAttribute("message", "Target deleted successfully.");
        return "redirect:/admin/target";
    }
}
