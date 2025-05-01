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
import group04.gundamshop.domain.Factory;
import group04.gundamshop.service.FactoryService;

@Controller
public class FactoryController {

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // Trim all string inputs and convert empty strings to null
        StringTrimmerEditor stringTrimmer = new StringTrimmerEditor(true);
        binder.registerCustomEditor(String.class, stringTrimmer);
    }

    private final FactoryService factoryService;

    public FactoryController(FactoryService factoryService) {
        this.factoryService = factoryService;
    }

    @GetMapping("/admin/factory")
    public String getFactoryList(Model model) {
        List<Factory> factories = factoryService.getAllFactories();
        model.addAttribute("factories", factories);
        return "admin/factory/show";
    }

    @GetMapping("/admin/factory/create")
    public String getCreateFactoryPage(Model model) {
        model.addAttribute("newFactory", new Factory());
        return "admin/factory/create";
    }

    @PostMapping("/admin/factory/create")
    public String createFactory(Model model, @ModelAttribute("newFactory") @Valid Factory factory,
            BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        // Check for duplicate name
        Factory existingFactory = factoryService.getFactoryByName(factory.getName());
        if (existingFactory != null) {
            bindingResult.rejectValue("name", "error.factory", "Factory name already exists.");
        }
        if (bindingResult.hasErrors()) {
            List<FieldError> errors = bindingResult.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println(error.getField() + " - " + error.getDefaultMessage());
            }
            return "admin/factory/create";
        }
        factoryService.saveFactory(factory);
        redirectAttributes.addFlashAttribute("message", "Factory created successfully.");
        return "redirect:/admin/factory";
    }

    @GetMapping("/admin/factory/update/{id}")
    public String getUpdateFactoryPage(Model model, @PathVariable long id) {
        Optional<Factory> factoryOpt = factoryService.getFactoryById(id);
        if (factoryOpt.isEmpty()) {
            return "redirect:/admin/factory";
        }
        model.addAttribute("newFactory", factoryOpt.get());
        return "admin/factory/update";
    }

    @PostMapping("/admin/factory/update")
    public String postUpdateFactory(Model model, @ModelAttribute("newFactory") @Valid Factory factory,
            BindingResult bindingResult, RedirectAttributes redirectAttributes) {
        // Check for duplicate name excluding current factory
        Factory existingFactory = factoryService.getFactoryByName(factory.getName());
        if (existingFactory != null && existingFactory.getId() != factory.getId()) {
            bindingResult.rejectValue("name", "error.factory", "Factory name already exists.");
        }
        if (bindingResult.hasErrors()) {
            model.addAttribute("newFactory", factory);
            return "admin/factory/update";
        }
        factoryService.saveFactory(factory);
        redirectAttributes.addFlashAttribute("message", "Factory updated successfully.");
        return "redirect:/admin/factory";
    }

    @GetMapping("/admin/factory/delete/{id}")
    public String getDeleteFactoryPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("factory", new Factory());
        return "admin/factory/delete";
    }

    @PostMapping("/admin/factory/delete")
    public String postDeleteFactory(Model model, @ModelAttribute("factory") Factory factory, RedirectAttributes redirectAttributes) {
        if (factoryService.isFactoryAssigned(factory.getId())) {
            model.addAttribute("id", factory.getId());
            model.addAttribute("assigned", true);
            return "admin/factory/delete";
        }
        factoryService.deleteFactory(factory.getId());
        redirectAttributes.addFlashAttribute("message", "Factory deleted successfully.");
        return "redirect:/admin/factory";
    }
}
