package group04.gundamshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import group04.gundamshop.domain.Category;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.Order;
import jakarta.persistence.criteria.Predicate;
import jakarta.persistence.criteria.CriteriaBuilder;

public class ProductSpecs {

    // Product Specifications
    public static Specification<Product> nameLike(String name) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.like(root.get("name"), "%" + name + "%");
        };
    }

    public static Specification<Product> minPrice(double price) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.ge(root.get("price"), price);
        };
    }

    public static Specification<Product> maxPrice(double price) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.le(root.get("price"), price);
        };
    }

    public static Specification<Product> matchFactory(Long factoryId) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.equal(root.get("factory").get("id"), factoryId);
        };
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
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.and(
                criteriaBuilder.ge(root.get("price"), min),
                criteriaBuilder.le(root.get("price"), max));
        };
    }

    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.between(
                root.get("price"), min, max);
        };
    }

    public static Specification<Product> matchStatus(boolean status) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.equal(root.get("status"), status);
        };
    }

    // Thêm specification để lọc theo categoryId
    public static Specification<Product> matchCategoryId(Long categoryId) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.equal(root.get("category").get("id"),
                categoryId);
        };
    }

    public static Specification<Product> matchScale(String scale) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.like(root.get("scale"), "%" + scale + "%");
        };
    }

    public static Specification<Product> matchScales(List<String> scales) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            CriteriaBuilder.In<String> inClause = criteriaBuilder.in(root.get("scale"));
            for (String scale : scales) {
                inClause.value(scale);
            }
            return inClause;
        };
    }

    public static Specification<Product> matchMaterial(String material) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.like(root.get("material"), "%" + material + "%");
        };
    }

    public static Specification<Product> matchMaterials(List<String> materials) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            CriteriaBuilder.In<String> inClause = criteriaBuilder.in(root.get("material"));
            for (String material : materials) {
                inClause.value(material);
            }
            return inClause;
        };
    }

    public static Specification<Product> matchDimensions(String dimensions) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.like(root.get("dimensions").as(String.class), "%" + dimensions + "%");
        };
    }

    public static Specification<Product> matchDimensionsRange(Double min, Double max) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.and(
                criteriaBuilder.ge(root.get("dimensions").as(Double.class), min),
                criteriaBuilder.le(root.get("dimensions").as(Double.class), max));
        };
    }

    public static Specification<Product> matchWeight(String weight) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.like(root.get("weight").as(String.class), "%" + weight + "%");
        };
    }

    public static Specification<Product> matchWeightRange(Double min, Double max) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.and(
                criteriaBuilder.ge(root.get("weight").as(Double.class), min),
                criteriaBuilder.le(root.get("weight").as(Double.class), max));
        };
    }

    // Order Specifications
    public static Specification<Order> matchOrderStatus(String status) {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.equal(root.get("status"), status);
        };
    }

    public static Specification<Order> matchAnyOrderStatus() {
        return (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.conjunction();
        };
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
