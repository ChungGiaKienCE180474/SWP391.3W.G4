package group04.gundamshop.repository;

import group04.gundamshop.domain.ProductReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

import group04.gundamshop.domain.OrderDetail;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.User;

import java.util.Optional;

@Repository
public interface ProductReviewRepository extends JpaRepository<ProductReview, Long> {

    // Phương thức tìm kiếm đánh giá theo người dùng và sản phẩm
    Optional<ProductReview> findByUserAndProduct(User user, Product product);

    ProductReview findByOrderDetail(OrderDetail orderDetail); // Tìm đánh giá dựa vào OrderDetail

    List<ProductReview> findByProductId(long productId);

}
