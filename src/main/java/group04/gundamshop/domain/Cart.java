package group04.gundamshop.domain;

import java.util.List;
import java.util.stream.Collectors;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;

@Entity
@Table(name = "carts")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Min(value = 0)
    private int sum;

    // user_id
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    // cart_detail_id
    @OneToMany(mappedBy = "cart")
    private List<CartDetail> cartDetails;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<CartDetail> getCartDetails() {
        return cartDetails;
    }

    public void setCartDetails(List<CartDetail> cartDetails) {
        this.cartDetails = cartDetails;
    }

    // ✅ Phương thức này để tính tổng tiền trong giỏ hàng
    public double getTotalPrice() {
        return cartDetails.stream()
                .mapToDouble(cd -> cd.getPrice() * cd.getQuantity())
                .sum();
    }

    // ✅ Phương thức này để lấy danh sách các item từ cartDetails
    public List<CartDetail> getItems() {
        return cartDetails;
    }

    // ✅ Phương thức để kiểm tra xem giỏ hàng có chứa sản phẩm hay không
    public boolean hasItems() {
        return cartDetails != null && !cartDetails.isEmpty();
    }
}
