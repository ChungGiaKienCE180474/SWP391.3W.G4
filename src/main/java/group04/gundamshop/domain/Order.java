package group04.gundamshop.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "receiver_name")
    private String receiverName;

    @Column(name = "receiver_address")
    private String receiverAddress;

    @Column(name = "receiver_phone")
    private String receiverPhone;

    @Column(name = "note")
    private String note;

    @Column(name = "order_date")
    private LocalDateTime orderDate;

    @Column(name = "complete_date")
    private LocalDateTime completeDate; // Thêm trường hoàn thành

    @Column(name = "cancel_date")
    private LocalDateTime cancelDate; // Thêm trường hủy

    @Column(name = "status")
    private String status;

    @Column(name = "total_price")
    private double totalPrice;

    @Column(name = "payment_method")
    private String paymentMethod;

    @Transient
    private String displayStatus;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetails;

    @ManyToOne
    @JoinColumn(name = "voucher_id")
    private Voucher voucher;

    // Getters và Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public LocalDateTime getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(LocalDateTime completeDate) {
        this.completeDate = completeDate;
    }

    public LocalDateTime getCancelDate() {
        return cancelDate;
    }

    public void setCancelDate(LocalDateTime cancelDate) {
        this.cancelDate = cancelDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getDisplayStatus() {
        return displayStatus;
    }

    public void setDisplayStatus(String displayStatus) {
        this.displayStatus = displayStatus;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    // Getter cho convertedOrderDate
    @Transient
    public String getConvertedOrderDate() {
        if (orderDate == null)
            return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        return orderDate.format(formatter);
    }

    @Transient
    private String convertedCompleteDate;

    public String getConvertedCompleteDate() {
        if (convertedCompleteDate == null && "COMPLETE".equals(status)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            convertedCompleteDate = (completeDate != null ? completeDate : orderDate).format(formatter);
        }
        return convertedCompleteDate;
    }

    public void setConvertedCompleteDate(String convertedCompleteDate) {
        this.convertedCompleteDate = convertedCompleteDate;
    }

    @Transient
    private String convertedCancelDate;

    public String getConvertedCancelDate() {
        if (convertedCancelDate == null && ("CANCEL".equals(status))) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            convertedCancelDate = (cancelDate != null ? cancelDate : orderDate).format(formatter);
        }
        return convertedCancelDate;
    }

    public void setConvertedCancelDate(String convertedCancelDate) {
        this.convertedCancelDate = convertedCancelDate;
    }
}