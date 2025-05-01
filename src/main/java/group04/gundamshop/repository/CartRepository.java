package group04.gundamshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import group04.gundamshop.domain.Cart;
import group04.gundamshop.domain.User;
import java.util.Optional;


@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);
    Optional<Cart> findByUserId(Long userId);
    boolean existsByUserId(Long userId);
}
