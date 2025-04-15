package group04.gundamshop.domain;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "wishlist")
public class WishList {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY) // Hoặc FetchType.EAGER tùy vào yêu cầu
    @JoinColumn(name = "user_id", nullable = false)
    @JsonIgnore
    private User user;

    @ManyToOne(fetch = FetchType.LAZY) // Hoặc FetchType.EAGER tùy vào yêu cầu
    @JoinColumn(name = "product_id", nullable = false)
    @JsonIgnore
    private Product product;

    public WishList() {
    }

    public WishList(User user, Product product) {
        this.user = user;
        this.product = product;
    }

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public Product getProduct() {
        return product;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}