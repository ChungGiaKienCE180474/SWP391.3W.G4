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

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.factory.id = :factoryId")
    boolean existsByFactoryId(@Param("factoryId") Long factoryId);

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.factory.id = :factoryId AND p.status = true")
    boolean existsByFactoryIdAndStatusTrue(@Param("factoryId") Long factoryId);

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.target.id = :targetId")
    boolean existsByTargetId(@Param("targetId") Long targetId);

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.target.id = :targetId AND p.status = true")
    boolean existsByTargetIdAndStatusTrue(@Param("targetId") Long targetId);

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.category.id = :categoryId")
    boolean existsByCategoryId(@Param("categoryId") Long categoryId);

    @Query("SELECT CASE WHEN COUNT(p) > 0 THEN true ELSE false END FROM Product p WHERE p.name = :name AND p.factory.id = :factoryId AND p.target.id = :targetId")
    boolean existsByNameAndFactoryIdAndTargetId(@Param("name") String name, @Param("factoryId") Long factoryId, @Param("targetId") Long targetId);

    @Query("SELECT p FROM Product p WHERE p.name = :name AND p.factory.id = :factoryId AND p.target.id = :targetId")
    List<Product> findAllByNameAndFactoryIdAndTargetId(@Param("name") String name, @Param("factoryId") Long factoryId, @Param("targetId") Long targetId);
    @org.springframework.data.jpa.repository.Modifying
    @org.springframework.data.jpa.repository.Query("UPDATE Product p SET p.target = null WHERE p.target.id = :targetId")
    void unsetTargetByTargetId(@org.springframework.data.repository.query.Param("targetId") Long targetId);

    @org.springframework.data.jpa.repository.Modifying
    @org.springframework.data.jpa.repository.Query("UPDATE Product p SET p.factory = null WHERE p.factory.id = :factoryId")
    void unsetFactoryByFactoryId(@org.springframework.data.repository.query.Param("factoryId") Long factoryId);
}


