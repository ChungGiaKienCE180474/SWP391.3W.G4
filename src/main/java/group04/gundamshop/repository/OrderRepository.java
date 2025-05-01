package group04.gundamshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import group04.gundamshop.domain.Order;
import group04.gundamshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    // Tìm đơn hàng theo trạng thái
    List<Order> findByStatus(String status);

    // Tìm đơn hàng theo người dùng và trạng thái
    List<Order> findByUserAndStatus(User user, String status);

    // Tìm tất cả đơn hàng theo người dùng
    List<Order> findByUser(User user);

    // Tìm các đơn hàng của người dùng với trạng thái khác "COMPLETE"
    List<Order> findByUserAndStatusNotIn(User user, List<String> statuses);

    List<Order> findByUser_Id(long userId);

    // Tìm các đơn hàng của người dùng với trạng thái khác "COMPLETE"
    List<Order> findByUserAndStatusNot(User user, String status);

<<<<<<< HEAD
    // Tìm các đơn hàng có ít nhất một chi tiết đơn hàng đã được đánh giá
    @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.productReview IS NOT NULL")
    List<Order> findOrdersWithRatedDetails();

    // Tìm các đơn hàng có ít nhất một chi tiết đơn hàng chưa được đánh giá
    @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.productReview IS NULL AND o.status = 'COMPLETE'")
    List<Order> findOrdersWithUnratedDetails();

=======
    boolean existsByUserId(Long userId);
>>>>>>> 1a7df5b08f9f23771aa35ac6ef96afb76deaf4e7
}
