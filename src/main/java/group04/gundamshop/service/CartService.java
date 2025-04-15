package group04.gundamshop.service;

import org.springframework.stereotype.Service;
import group04.gundamshop.domain.Cart;
import group04.gundamshop.repository.CartRepository;

@Service
public class CartService {
    private final CartRepository cartRepository;

    public CartService(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
    }

    public Cart getCartByUserId(Long userId) {
        return cartRepository.findByUserId(userId).orElse(null); // Đảm bảo trả về null nếu không có giỏ hàng
    }

    public void clearCart(Cart cart) {
        cart.getCartDetails().clear();
        cartRepository.save(cart);
    }
}
