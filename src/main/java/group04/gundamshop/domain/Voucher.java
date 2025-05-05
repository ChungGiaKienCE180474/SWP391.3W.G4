package group04.gundamshop.domain;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

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

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private Date validFrom;

    @Column(nullable = false)
    private Date validTo;

    public Voucher() {
    }

    public Voucher(Long id, String title, String description, String code, int discount, int quantity, Date validFrom,
            Date validTo) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.code = code;
        this.discount = discount;
        this.quantity = quantity;
        this.validFrom = validFrom;
        this.validTo = validTo;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidTo() {
        return validTo;
    }

    public void setValidTo(Date validTo) {
        this.validTo = validTo;
    }

    public static void validateVoucher(Voucher voucher) throws Exception {
        validateStringField(voucher.getCode(), "Code");
        validateStringField(voucher.getDescription(), "Description");
        validateStringField(voucher.getTitle(), "Title");
        validateStringField(voucher.getValidFrom().toString(), "Start date");
        validateStringField(voucher.getValidTo().toString(), "End date");

        if (voucher.getDiscount() < 1 || voucher.getDiscount() > 75)
            throw new Exception("Discount must be from 1% to 75%");

        if (voucher.getQuantity() < 0) {
            throw new Exception("Quantity can't be negative number");
        }

        LocalDate localDate = LocalDate.now();
        Date today = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

        if (voucher.getValidFrom().before(today))
            throw new Exception("Start date must be after today");

        if (voucher.getValidTo().before(voucher.getValidFrom()))
            throw new Exception("End date must be after start date");
    }

    private static void validateStringField(String field, String fieldName) throws Exception {
        if (field == null || field.isBlank())
            throw new Exception(fieldName + " must be filled");

        if (field.length() > 255)
            throw new Exception(fieldName + " max length is 255 characters");
    }
}