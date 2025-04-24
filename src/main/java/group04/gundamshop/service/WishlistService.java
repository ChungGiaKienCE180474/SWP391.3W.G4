package group04.gundamshop.service;

import group04.gundamshop.domain.Product;
import group04.gundamshop.domain.User;
import group04.gundamshop.domain.WishList;
import group04.gundamshop.repository.WishlistRepository;
import group04.gundamshop.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service // Đánh dấu đây là một service của Spring
public class WishlistService {
    private final WishlistRepository wishlistRepository;
    private final ProductRepository productRepository;

    // Khởi tạo service với các repository cần thiết
    public WishlistService(WishlistRepository wishlistRepository, ProductRepository productRepository) {
        this.wishlistRepository = wishlistRepository;
        this.productRepository = productRepository;
    }

    /**
     * Lấy danh sách sản phẩm trong wishlist của người dùng
     * 
     * @param user Đối tượng người dùng
     * @return Danh sách sản phẩm trong wishlist
     */
    public List<Product> getWishlist(User user) {
        return wishlistRepository.findByUser(user).stream()
                .map(WishList::getProduct) // Lấy danh sách sản phẩm từ danh sách wishlist
                .toList();
    }

    /**
     * Thêm sản phẩm vào wishlist của người dùng
     * 
     * @param user      Đối tượng người dùng
     * @param productId ID của sản phẩm cần thêm
     * @return true nếu thêm thành công, false nếu sản phẩm đã tồn tại trong
     *         wishlist hoặc không tìm thấy sản phẩm
     */
    @Transactional
    public boolean addToWishlist(User user, Long productId) {
        return productRepository.findById(productId) // Tìm sản phẩm theo ID
                .filter(product -> wishlistRepository.findByUserAndProduct(user, product) == null) // Kiểm tra nếu chưa
                                                                                                   // có trong wishlist
                .map(product -> {
                    wishlistRepository.save(new WishList(user, product)); // Lưu vào wishlist
                    return true;
                }).orElse(false); // Trả về false nếu sản phẩm không tồn tại hoặc đã có trong wishlist
    }

    /**
     * Xóa sản phẩm khỏi wishlist của người dùng
     * 
     * @param user      Đối tượng người dùng
     * @param productId ID của sản phẩm cần xóa
     * @return true nếu xóa thành công, false nếu sản phẩm không có trong wishlist
     */
    @Transactional
    public boolean removeFromWishlist(User user, Long productId) {
        return productRepository.findById(productId) // Tìm sản phẩm theo ID
                .map(product -> wishlistRepository.findByUserAndProduct(user, product)) // Tìm mục wishlist tương ứng
                .filter(wishlistItem -> wishlistItem != null) // Kiểm tra nếu sản phẩm có trong wishlist
                .map(wishlistItem -> {
                    wishlistRepository.delete(wishlistItem); // Xóa khỏi wishlist
                    return true;
                }).orElse(false); // Trả về false nếu không tìm thấy sản phẩm trong wishlist
    }
}
