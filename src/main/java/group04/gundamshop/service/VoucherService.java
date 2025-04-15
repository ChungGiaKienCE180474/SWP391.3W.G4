package group04.gundamshop.service;

import group04.gundamshop.domain.User;
import group04.gundamshop.domain.Voucher;
import group04.gundamshop.repository.UserRepository;
import group04.gundamshop.repository.VoucherRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VoucherService {
    private final VoucherRepository voucherRepository;
    private final UserRepository userRepository;

    public VoucherService(VoucherRepository voucherRepository, UserRepository userRepository) {
        this.voucherRepository = voucherRepository;
        this.userRepository = userRepository;
    }

    // ✅ Thu thập voucher cho user
    public void collectVoucherForUser(String email, Long voucherId) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        Optional<Voucher> voucherOpt = voucherRepository.findById(voucherId);

        if (userOpt.isPresent() && voucherOpt.isPresent()) {
            User user = userOpt.get();
            Voucher voucher = voucherOpt.get();

            if (!user.getCollectedVouchers().contains(voucher)) {
                user.getCollectedVouchers().add(voucher);
                userRepository.save(user);
            }
        }
    }

    // ✅ Lấy danh sách voucher đã thu thập
    public List<Voucher> getCollectedVouchers(String email) {
        return userRepository.findByEmail(email)
                .map(User::getCollectedVouchers)
                .orElse(List.of());
    }

    // ✅ Lấy tất cả voucher có sẵn
    public List<Voucher> getAllVouchers() {
        return voucherRepository.findAll();
    }

    // ✅ Lấy voucher theo mã không phân biệt hoa/thường
    public Optional<Voucher> getVoucherByCode(String code) {
        return voucherRepository.findByCodeIgnoreCase(code.trim());
    }

    // ✅ Lấy danh sách voucher có chứa đoạn mã
    public List<Voucher> findByCode(String code) {
        return voucherRepository.findByCodeContainingIgnoreCase(code.trim());
    }
}
