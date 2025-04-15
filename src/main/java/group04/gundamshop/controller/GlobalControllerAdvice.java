package group04.gundamshop.controller;

import group04.gundamshop.domain.Category;
import group04.gundamshop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private CategoryService categoryService;

    @ModelAttribute("categories")
    public List<Category> categories() {
        return categoryService.getCategoryByStatus(true); // Lấy danh mục có status = true
    }
}