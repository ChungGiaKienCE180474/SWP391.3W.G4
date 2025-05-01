package group04.gundamshop.domain.dto;

import java.util.List;
import java.util.Optional;

import java.util.List;
import java.util.Optional;

public class ProductCriteriaDTO {
    private Optional<String> page = Optional.empty();
    private Optional<List<String>> factory = Optional.empty();
    private Optional<List<String>> target = Optional.empty();
    private Optional<List<String>> price = Optional.empty();
    private Optional<String> sort = Optional.empty(); // Đảm bảo sort luôn khởi tạo với Optional.empty()
    private Optional<String> searchKeyword = Optional.empty(); // Thêm trường tìm kiếm
    private Optional<String> categoryId = Optional.empty(); // Thêm trường danh mục

    private Optional<String> scale = Optional.empty();
    private Optional<String> material = Optional.empty();
    private Optional<String> dimensions = Optional.empty();
    private Optional<String> weight = Optional.empty();

    private Optional<Double> dimensionsMin = Optional.empty();
    private Optional<Double> dimensionsMax = Optional.empty();
    private Optional<Double> weightMin = Optional.empty();
    private Optional<Double> weightMax = Optional.empty();
    private Optional<Double> priceMin = Optional.empty();
    private Optional<Double> priceMax = Optional.empty();

    public ProductCriteriaDTO() {
        // Bảo đảm tất cả các trường Optional được khởi tạo với Optional.empty()
        this.page = Optional.empty();
        this.factory = Optional.empty();
        this.target = Optional.empty();
        this.price = Optional.empty();
        this.sort = Optional.empty(); // Quan trọng nhất là dòng này
        this.searchKeyword = Optional.empty(); // Khởi tạo với Optional.empty()
        this.categoryId = Optional.empty(); // Khởi tạo với Optional.empty()
        this.scale = Optional.empty();
        this.material = Optional.empty();
        this.dimensions = Optional.empty();
        this.weight = Optional.empty();

        this.dimensionsMin = Optional.empty();
        this.dimensionsMax = Optional.empty();
        this.weightMin = Optional.empty();
        this.weightMax = Optional.empty();
        this.priceMin = Optional.empty();
        this.priceMax = Optional.empty();
    }

    public Optional<String> getPage() {
        return page;
    }

    public void setPage(Optional<String> page) {
        this.page = page;
    }

    public Optional<List<String>> getFactory() {
        return factory;
    }

    public void setFactory(Optional<List<String>> factory) {
        this.factory = factory;
    }

    public Optional<List<String>> getTarget() {
        return target;
    }

    public void setTarget(Optional<List<String>> target) {
        this.target = target;
    }

    public Optional<List<String>> getPrice() {
        return price;
    }

    public void setPrice(Optional<List<String>> price) {
        this.price = price;
    }

    public Optional<String> getSort() {
        return sort;
    }

    public void setSort(Optional<String> sort) {
        this.sort = sort;
    }

    public Optional<String> getSearchKeyword() {
        return searchKeyword; // Getter cho searchKeyword
    }

    public void setSearchKeyword(Optional<String> searchKeyword) {
        this.searchKeyword = searchKeyword; // Setter cho searchKeyword
    }

    public Optional<String> getCategoryId() {
        return categoryId; // Getter cho categoryId
    }

    public void setCategoryId(Optional<String> categoryId) {
        this.categoryId = categoryId; // Setter cho categoryId
    }

    public Optional<String> getScale() {
        return scale;
    }

    public void setScale(Optional<String> scale) {
        this.scale = scale;
    }

    public Optional<String> getMaterial() {
        return material;
    }

    public void setMaterial(Optional<String> material) {
        this.material = material;
    }

    public Optional<String> getDimensions() {
        return dimensions;
    }

    public void setDimensions(Optional<String> dimensions) {
        this.dimensions = dimensions;
    }

    public Optional<String> getWeight() {
        return weight;
    }

    public void setWeight(Optional<String> weight) {
        this.weight = weight;
    }

    public Optional<Double> getDimensionsMin() {
        return dimensionsMin;
    }

    public void setDimensionsMin(Optional<Double> dimensionsMin) {
        this.dimensionsMin = dimensionsMin;
    }

    public Optional<Double> getDimensionsMax() {
        return dimensionsMax;
    }

    public void setDimensionsMax(Optional<Double> dimensionsMax) {
        this.dimensionsMax = dimensionsMax;
    }

    public Optional<Double> getWeightMin() {
        return weightMin;
    }

    public void setWeightMin(Optional<Double> weightMin) {
        this.weightMin = weightMin;
    }

    public Optional<Double> getWeightMax() {
        return weightMax;
    }

    public void setWeightMax(Optional<Double> weightMax) {
        this.weightMax = weightMax;
    }

    public Optional<Double> getPriceMin() {
        return priceMin;
    }

    public void setPriceMin(Optional<Double> priceMin) {
        this.priceMin = priceMin;
    }

    public Optional<Double> getPriceMax() {
        return priceMax;
    }

    public void setPriceMax(Optional<Double> priceMax) {
        this.priceMax = priceMax;
    }
}
