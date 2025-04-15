package group04.gundamshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import group04.gundamshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    @Query("SELECT p FROM Product p WHERE p.status = true")
    Page<Product> findAll(Pageable page);

    Page<Product> findAll(Specification<Product> spec, Pageable page);

    Product save(Product product);

    Optional<Product> findById(long id);

    Product findByIdAndStatus(long id, boolean status);

    List<Product> findAllByStatus(boolean status);


    @Query("SELECT p FROM Product p WHERE " +
           "(LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(p.category.name) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
           "AND p.status = :status")
    List<Product> findByNameOrCategoryNameAndStatus(@Param("keyword") String keyword, @Param("status") boolean status);

}


