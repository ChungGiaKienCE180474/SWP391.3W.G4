// FeedbackRepository.java
package group04.gundamshop.repository;

import group04.gundamshop.domain.ProductReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FeedbackRepository extends JpaRepository<ProductReview, Long> {
    List<ProductReview> findByUserId(Long userId);
}
