package group04.gundamshop.repository;

import group04.gundamshop.domain.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    Optional<Voucher> findByCodeIgnoreCase(String code); // Không phân biệt hoa/thường

    List<Voucher> findByCodeContainingIgnoreCase(String code); // Lấy danh sách voucher chứa mã
}
