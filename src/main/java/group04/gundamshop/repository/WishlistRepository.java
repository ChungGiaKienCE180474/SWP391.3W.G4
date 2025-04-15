package group04.gundamshop.repository;

import group04.gundamshop.domain.User;
import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.WishList;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface WishlistRepository extends JpaRepository<WishList, Long> {
    List<WishList> findByUser(User user);
    WishList findByUserAndProduct(User user, Product product);
}
