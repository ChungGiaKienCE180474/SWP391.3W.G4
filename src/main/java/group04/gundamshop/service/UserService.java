package group04.gundamshop.service;

import group04.gundamshop.domain.dto.RegisterDTO;
import group04.gundamshop.domain.Role;
import group04.gundamshop.domain.User;
import group04.gundamshop.repository.RoleRepository;
import group04.gundamshop.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public void saveEmployeeWithEmail(User employee, String rawPassword) throws Exception {
        // Kiểm tra email trùng lặp
        if (checkEmailExist(employee.getEmail())) {
            throw new Exception("Email is already registered.");
        }

        // Lưu user (mật khẩu đã được mã hóa ở UserController)
        handleSaveUser(employee);

        // Gửi email
        try {
            emailService.sendRegistrationEmail(
                    employee.getEmail(),
                    employee.getFullName(),
                    employee.getEmail(),
                    rawPassword);
        } catch (Exception e) {
            System.err.println("Failed to send registration email: " + e.getMessage());
        }
    }

    public void resendEmployeeEmail(Long id) throws Exception {
        // Tìm employee
        User employee = userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Employee not found"));

        // Gửi email (không gửi mật khẩu vì không có mật khẩu gốc)
        try {
            emailService.sendRegistrationEmail(
                    employee.getEmail(),
                    employee.getFullName(),
                    employee.getEmail(),
                    "Your current password (please reset if forgotten)");
        } catch (Exception e) {
            throw new Exception("Failed to resend email: " + e.getMessage());
        }
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public List<User> getUsersByRoleId(long roleId, boolean status) {
        return userRepository.findAllByRole_IdAndStatus(roleId, status);
    }

    public List<User> getUsersRoleId(long roleId) {
        return userRepository.findAllByRole_Id(roleId);
    }

    public Optional<User> getUserById(long id) {
        return userRepository.findById(id);
    }

    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User handleSaveUser(User user) {
        return userRepository.save(user);
    }

    public void deleteAUser(long id) {
        userRepository.deleteById(id);
    }

    public Role getRoleByName(String name) {
        return roleRepository.findByName(name);
    }

    public boolean checkEmailExist(String email) {
        return userRepository.existsByEmail(email);
    }

    public Optional<User> findUserById(long id) {
        return userRepository.findById(id);
    }

    public void updatePassword(String email, String newPassword) {
        Optional<User> userOptional = userRepository.findByEmail(email);
        userOptional.ifPresent(user -> {
            user.setPassword(newPassword);
            userRepository.save(user);
        });
    }

    public void banCustomerAccount(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));
        if (user.getRole().getId() == 3) {
            user.setStatus(false);
            userRepository.save(user);
        } else {
            throw new IllegalArgumentException("Chỉ có thể cấm tài khoản khách hàng");
        }
    }

    public void unbanCustomerAccount(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));
        if (user.getRole().getId() == 3) {
            user.setStatus(true);
            userRepository.save(user);
        } else {
            throw new IllegalArgumentException("Chỉ có thể gỡ cấm tài khoản khách hàng");
        }
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setEmail(registerDTO.getEmail());
        user.setFullName(registerDTO.getFullName());
        user.setPhone(registerDTO.getPhone());
        user.setAddress(registerDTO.getAddress());
        user.setPassword(registerDTO.getPassword());
        return user;
    }

    public List<User> importFromExcel(MultipartFile excelFile) throws IOException {
        List<User> users = new ArrayList<>();
        try (Workbook workbook = new XSSFWorkbook(excelFile.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0);
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null || isRowEmpty(row))
                    continue;

                User user = new User();
                user.setEmail(getCellValue(row, 0));
                user.setPassword(getCellValue(row, 1));
                user.setPhone(getCellValue(row, 2));
                user.setFullName(getCellValue(row, 3));
                user.setAddress(getCellValue(row, 4));
                user.setStatus(true);
                user.setRole(getRoleByName("CUSTOMER"));
                user.setAvatar(null);

                if (user.getEmail() == null || user.getEmail().trim().isEmpty() ||
                        user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                    continue;
                }

                users.add(user);
            }
        }
        return users;
    }

    private boolean isRowEmpty(Row row) {
        if (row == null)
            return true;
        for (int i = 0; i < 5; i++) {
            var cell = row.getCell(i);
            if (cell != null && cell.getCellType() != org.apache.poi.ss.usermodel.CellType.BLANK) {
                String value = getCellValue(row, i);
                if (value != null && !value.trim().isEmpty()) {
                    return false;
                }
            }
        }
        return true;
    }

    private String getCellValue(Row row, int cellIndex) {
        var cell = row.getCell(cellIndex);
        if (cell == null)
            return "";
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                return String.valueOf((long) cell.getNumericCellValue());
            default:
                return "";
        }
    }
}