package group04.gundamshop.domain;

import jakarta.persistence.*;

import org.hibernate.annotations.SoftDelete;

@Entity
@Table(name = "vouchers")
@SoftDelete
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private String description;

    @Column(nullable = false, unique = true)
    private String code; // Mã giảm giá duy nhất

    @Column(nullable = false)
    private int discount; // Tính theo %

    public Voucher() {}

    public Voucher(String title, String description, String code, int discount) {
        this.title = title;
        this.description = description;
        this.code = code;
        this.discount = discount;
    }

    // Getters và Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public int getDiscount() { return discount; }
    public void setDiscount(int discount) { this.discount = discount; }
}