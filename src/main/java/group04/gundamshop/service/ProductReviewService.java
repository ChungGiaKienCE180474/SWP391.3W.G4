package group04.gundamshop.service;

import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.ProductReview;
import group04.gundamshop.domain.User;
import group04.gundamshop.repository.ProductReviewRepository;
import org.springframework.stereotype.Service;
import group04.gundamshop.domain.OrderDetail;
import java.util.List;
import java.util.Optional;

@Service
public class ProductReviewService {

    private final ProductReviewRepository productReviewRepository;

    public ProductReviewService(ProductReviewRepository productReviewRepository) {
        this.productReviewRepository = productReviewRepository;
    }

    // Thêm phương thức findById
    public Optional<ProductReview> findById(long id) {
        return productReviewRepository.findById(id);
    }

    public ProductReview findByOrderDetail(OrderDetail orderDetail) {
        return productReviewRepository.findByOrderDetail(orderDetail);
    }

    public void saveProductReview(ProductReview review) {
        productReviewRepository.save(review);
    }

    public List<ProductReview> findReviewsByProductId(long productId) {
        return productReviewRepository.findByProductId(productId);
    }

    // Thêm phương thức này để tìm kiếm đánh giá theo User và Product
    public Optional<ProductReview> findByUserAndProduct(User user, Product product) {
        return productReviewRepository.findByUserAndProduct(user, product);
    }
}
