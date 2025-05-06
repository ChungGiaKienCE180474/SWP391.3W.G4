package group04.gundamshop.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.CascadeType;

import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.time.LocalDateTime;

@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @ManyToOne(cascade = jakarta.persistence.CascadeType.MERGE)
    @JoinColumn(name = "category_id")
    private Category category;
    @NotNull
    @Size(min = 4, message = "Name must at least 4 digits")
    private String name;
    @DecimalMin(value = "1000.01", message = "Price must >= 1000đ")
    private double price;
    private String image;
    private String detailDesc;
    private String shortDesc;
    private long quantity;
    private long sold;
    @ManyToOne(cascade = jakarta.persistence.CascadeType.MERGE)
    @JoinColumn(name = "factory_id")
    private Factory factory;

    @ManyToOne
    @JoinColumn(name = "target_id")
    private Target target;

    @NotNull(message = "Scale is required")
    @Pattern(regexp = "^1:\\d+$", message = "Scale must be in format 1:number, e.g. 1:6")
    private String scale;

    @NotNull(message = "Material is required")
    @Pattern(regexp = "^[a-zA-Z][a-zA-Z0-9 ]*$", message = "Material must start with a letter and contain only letters, numbers, and spaces")
    private String material;

    @NotNull(message = "Dimensions is required")
    @DecimalMin(value = "0", inclusive = true, message = "Dimensions must be non-negative")
    private Double dimensions;

    @NotNull(message = "Weight is required")
    @DecimalMin(value = "0", inclusive = true, message = "Weight must be non-negative")
    private Double weight;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private boolean status;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public long getSold() {
        return sold;
    }

    public void setSold(long sold) {
        this.sold = sold;
    }

    public Factory getFactory() {
        return factory;
    }

    public void setFactory(Factory factory) {
        this.factory = factory;
    }

    public Target getTarget() {
        return target;
    }

    public void setTarget(Target target) {
        this.target = target;
    }

    public String getScale() {
        return scale;
    }

    public void setScale(String scale) {
        this.scale = scale;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public Double getDimensions() {
        return dimensions;
    }

    public void setDimensions(Double dimensions) {
        this.dimensions = dimensions;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", categoryId=" + (category != null ? category.getId() : null) + ", name=" + name + ", price=" + price + ", image="
                + image + ", detailDesc=" + detailDesc + ", shortDesc=" + shortDesc + ", quantity=" + quantity

                + ", sold=" + sold + ", factory=" + factory + ", target=" + target + ", scale=" + scale + ", material=" + material + ", dimensions=" + dimensions + ", weight=" + weight + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt + ", status=" + status + "]";
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Product product = (Product) o;

        return id == product.id;
    }

    @Override
    public int hashCode() {
        return Long.hashCode(id);
    }

}
