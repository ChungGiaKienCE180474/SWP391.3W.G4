package group04.gundamshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import group04.gundamshop.domain.Category;
import group04.gundamshop.repository.CategoryRepository;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getAllCategories() {
        return this.categoryRepository.findAll();
    }

    public Category handleSaveCategory(Category category) {
        return this.categoryRepository.save(category);
    }

    public Category getCategoryById(long id) {
        return this.categoryRepository.findById(id);
    }

    public List<Category> getCategoryByStatus(boolean status) {
        return categoryRepository.findAllByStatus(status);
    }
// check tên cate không cho trùng
public boolean existsByName(String name) {
    return this.categoryRepository.findByName(name) != null;
}
public Category getCategoryByName(String name) {
    return categoryRepository.findByName(name); // Giả sử bạn có repository tương ứng
}
}
