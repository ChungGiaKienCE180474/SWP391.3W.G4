package group04.gundamshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import group04.gundamshop.domain.Category;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.Order;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.CriteriaBuilder;

public class ProductSpecs {

    // Product Specifications
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.like(root.get("name"), "%" + name + "%");
    }

    public static Specification<Product> minPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.ge(root.get("price"), price);
    }

    public static Specification<Product> maxPrice(double price) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.le(root.get("price"), price);
    }

    public static Specification<Product> matchFactory(Long factoryId) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("factory").get("id"), factoryId);
    }

    public static Specification<Product> matchListFactory(List<Long> factoryIds) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            CriteriaBuilder.In<Long> inClause = criteriaBuilder.in(root.get("factory").get("id").as(Long.class));
            for (Long id : factoryIds) {
                inClause.value(id);
            }
            return inClause;
        };
    }

    public static Specification<Product> matchListTarget(List<Long> targetIds) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            CriteriaBuilder.In<Long> inClause = criteriaBuilder.in(root.get("target").get("id").as(Long.class));
            for (Long id : targetIds) {
                inClause.value(id);
            }
            return inClause;
        };
    }

    public static Specification<Product> matchPrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.and(
                criteriaBuilder.gt(root.get("price"), min),
                criteriaBuilder.le(root.get("price"), max));
    }

    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.between(
                root.get("price"), min, max);
    }

    public static Specification<Product> matchStatus(boolean status) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("status"), status);
    }

    // Thêm specification để lọc theo categoryId
    public static Specification<Product> matchCategoryId(Long categoryId) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("category").get("id"),
                categoryId);
    }

    // Order Specifications
    public static Specification<Order> matchOrderStatus(String status) {
        return (root, query, criteriaBuilder) -> criteriaBuilder.equal(root.get("status"), status);
    }

    public static Specification<Order> matchAnyOrderStatus() {
        return (root, query, criteriaBuilder) -> criteriaBuilder.conjunction();
    }

    public static Specification<Product> matchNameOrCategory(String keyword) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true); // Đảm bảo không có bản sao
            String lowerKeyword = keyword.toLowerCase();
            Predicate namePredicate = criteriaBuilder.like(
                    criteriaBuilder.lower(root.get("name")),
                    "%" + lowerKeyword + "%");
            Predicate categoryNamePredicate = criteriaBuilder.like(
                    criteriaBuilder.lower(root.join("category").get("name")),
                    "%" + lowerKeyword + "%");
            return criteriaBuilder.or(namePredicate, categoryNamePredicate);
        };
    }
}
