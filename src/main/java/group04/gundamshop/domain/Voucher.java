package group04.gundamshop.domain;

import org.hibernate.annotations.SoftDelete;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

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

    public Voucher() {
    }

    public Voucher(String title, String description, String code, int discount) {
        this.title = title;
        this.description = description;
        this.code = code;
        this.discount = discount;
    }

    // Getters và Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public static void validateVoucher(Voucher voucher) throws Exception {
        if (voucher.getCode() == null || voucher.getCode().isBlank())
            throw new Exception("Code must be filled");

        if (voucher.getDescription() == null || voucher.getDescription().isBlank())
            throw new Exception("Description must be filled");

        if (voucher.getTitle() == null || voucher.getTitle().isBlank())
            throw new Exception("Title must be filled");

        if (voucher.getCode().length() > 255)
            throw new Exception("Code max length is 255 characters");

        if (voucher.getDescription().length() > 255)
            throw new Exception("Description max length is 255 characters");

        if (voucher.getTitle().length() > 255)
            throw new Exception("Title max length is 255 characters");

        if (voucher.getDiscount() < 1 || voucher.getDiscount() > 75)
            throw new Exception("Discount must be from 1% to 75%");
    }
}