package group04.gundamshop.domain.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import group04.gundamshop.domain.Voucher;

public class UpsertVoucherDTO {
    private String title;
    private String description;
    private String code;
    private int discount;
    private int quantity;
    private String validFrom;
    private String validTo;

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

    public String getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(String validFrom) {
        this.validFrom = validFrom;
    }

    public String getValidTo() {
        return validTo;
    }

    public void setValidTo(String validTo) {
        this.validTo = validTo;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Voucher mapToVoucher() throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return new Voucher(null,
                title,
                description,
                code,
                discount,
                quantity,
                sdf.parse(validFrom),
                sdf.parse(validTo));
    }
}
