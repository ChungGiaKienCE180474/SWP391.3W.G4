package group04.gundamshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import group04.gundamshop.domain.Category_;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.Product_;
import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.Order_;
import jakarta.persistence.criteria.Predicate;

public class ProductSpecs {

    // Product Specifications
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get(Product_.NAME), "%" + name + "%");
    }

    public static Specification<Product> minPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get(Product_.PRICE), price);
    }

    public static Specification<Product> maxPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.le(root.get(Product_.PRICE), price);
    }

    public static Specification<Product> matchFactory(String factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Product_.FACTORY), factory);
    }

    public static Specification<Product> matchListFactory(List<String> factory) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.FACTORY)).value(factory);
    }

    public static Specification<Product> matchListTarget(List<String> target) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.in(root.get(Product_.TARGET)).value(target);
    }

    public static Specification<Product> matchPrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.and(
                criteriaBuilder.gt(root.get(Product_.PRICE), min),
                criteriaBuilder.le(root.get(Product_.PRICE), max));
    }

    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(
                root.get(Product_.PRICE), min, max);
    }

    public static Specification<Product> matchStatus(boolean status) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Product_.STATUS), status);
    }

    // Thêm specification để lọc theo categoryId
    public static Specification<Product> matchCategoryId(Long categoryId) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Product_.CATEGORY).get(Category_.ID),
                categoryId);
    }

    // Order Specifications
    public static Specification<Order> matchOrderStatus(String status) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get(Order_.STATUS), status);
    }

    public static Specification<Order> matchAnyOrderStatus() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.conjunction();
    }

    public static Specification<Product> matchNameOrCategory(String keyword) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true); // Đảm bảo không có bản sao
            String lowerKeyword = keyword.toLowerCase();
            Predicate namePredicate = criteriaBuilder.like(
                    criteriaBuilder.lower(root.get(Product_.NAME)),
                    "%" + lowerKeyword + "%");
            Predicate categoryNamePredicate = criteriaBuilder.like(
                    criteriaBuilder.lower(root.join(Product_.CATEGORY).get(Category_.NAME)),
                    "%" + lowerKeyword + "%");
            return criteriaBuilder.or(namePredicate, categoryNamePredicate);
        };
    }
}