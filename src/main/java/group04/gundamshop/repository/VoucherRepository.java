package group04.gundamshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import group04.gundamshop.domain.Voucher;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    Optional<Voucher> findByCodeIgnoreCase(String code); // Không phân biệt hoa/thường

    @Query(value = "SELECT * FROM vouchers WHERE upper(code) = upper(:code)", nativeQuery = true)
    Optional<Voucher> findByCodeIgnoreCaseAndIgnoreDeleted(@Param("code") String code);

    List<Voucher> findByCodeContainingIgnoreCase(String code); // Lấy danh sách voucher chứa mã

    @Query("SELECT v FROM Voucher v WHERE v.quantity > 0 AND CURRENT_TIMESTAMP BETWEEN v.validFrom AND v.validTo")
    List<Voucher> findAllValidVouchers();

    @Query("SELECT v FROM Voucher v WHERE LOWER(v.code) LIKE LOWER(CONCAT('%', :code, '%')) AND v.quantity > 0 AND CURRENT_TIMESTAMP BETWEEN v.validFrom AND v.validTo")
    List<Voucher> findAllValidVouchersByContainingCode(@Param("code") String code);

}
