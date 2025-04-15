package group04.gundamshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import group04.gundamshop.domain.Cart;
import group04.gundamshop.domain.CartDetail;
import group04.gundamshop.domain.Product;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);

    CartDetail findByCartAndProduct(Cart cart, Product product);

    List<CartDetail> findByProduct(Product product);

}
