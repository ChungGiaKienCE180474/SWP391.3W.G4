package group04.gundamshop.domain.dto;

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

    public ProductCriteriaDTO() {
        // Bảo đảm tất cả các trường Optional được khởi tạo với Optional.empty()
        this.page = Optional.empty();
        this.factory = Optional.empty();
        this.target = Optional.empty();
        this.price = Optional.empty();
        this.sort = Optional.empty(); // Quan trọng nhất là dòng này
        this.searchKeyword = Optional.empty(); // Khởi tạo với Optional.empty()
        this.categoryId = Optional.empty(); // Khởi tạo với Optional.empty()
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
}
