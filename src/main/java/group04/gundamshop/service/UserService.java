package group04.gundamshop.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import group04.gundamshop.domain.Role;
import group04.gundamshop.domain.User;
import group04.gundamshop.domain.dto.RegisterDTO;
import group04.gundamshop.repository.CartRepository;
import group04.gundamshop.repository.OrderRepository;
import group04.gundamshop.repository.RoleRepository;
import group04.gundamshop.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private OrderRepository orderRepository; // Repository cho bảng orders

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

    public List<User> getUsersByRoleId(long roleId) {
        return userRepository.findByRoleId(roleId);
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

    public boolean checkPhoneExist(String phone) {
        return this.userRepository.existsByPhone(phone);
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

    // Phương thức import từ Excel
    public List<User> importFromExcel(MultipartFile excelFile) throws IOException {
        List<User> users = new ArrayList<>();
        try (Workbook workbook = new XSSFWorkbook(excelFile.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0); // Lấy sheet đầu tiên
            for (int i = 1; i <= sheet.getLastRowNum(); i++) { // Bỏ qua header (dòng 0)
                Row row = sheet.getRow(i);
                if (row == null || isRowEmpty(row))
                    continue; // Bỏ qua dòng trống

                User user = new User();
                user.setEmail(getCellValue(row, 0)); // Cột 0: email
                user.setPassword(getCellValue(row, 1)); // Cột 1: password
                user.setPhone(getCellValue(row, 2)); // Cột 2: phone
                user.setFullName(getCellValue(row, 3)); // Cột 3: fullName
                user.setAddress(getCellValue(row, 4)); // Cột 4: address
                user.setStatus(true); // Mặc định status = true
                user.setRole(getRoleByName("CUSTOMER")); // Gán role CUSTOMER
                user.setAvatar(null); // Không có avatar từ Excel

                // Dù có lỗi vẫn add vào danh sách users
                users.add(user);
            }
        }
        return users;
    }

    public void banEmployeeAccount(Long userId) {
        User employee = getUserById(userId).orElseThrow(() -> new EntityNotFoundException());
        if (employee.getRole().getName().equals("EMPLOYEE")) {
            employee.setStatus(false);
            handleSaveUser(employee);
        } else {
            throw new IllegalArgumentException("User is not an employee.");
        }
    }

    public void unbanEmployeeAccount(Long userId) {
        User employee = getUserById(userId).orElseThrow(() -> new EntityNotFoundException());
        if (employee.getRole().getName().equals("EMPLOYEE")) {
            employee.setStatus(true);
            handleSaveUser(employee);
        } else {
            throw new IllegalArgumentException("User is not an employee.");
        }
    }

    private boolean isRowEmpty(Row row) {
        if (row == null)
            return true;

        for (int i = 0; i < 5; i++) { // Kiểm tra 5 cột (Email, Password, Phone, Full Name, Address)
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

    // Xóa hoàn toàn nhân viên khỏi cơ sở dữ liệu
    public void deleteEmployee(Long id) {
        if (!userRepository.existsById(id)) {
            throw new EntityNotFoundException("Employee not found with id: " + id);
        }

        // Kiểm tra xem nhân viên có liên quan đến carts hoặc orders không
        if (cartRepository.existsByUserId(id) || orderRepository.existsByUserId(id)) {
            throw new IllegalStateException("Cannot delete employee due to related records.");
        }

        // Nếu không có liên quan, xóa nhân viên
        userRepository.deleteById(id);
    }

    // Kiểm tra xem nhân viên có liên quan đến carts hoặc orders để quyết định hiển
    // thị nút Delete
    public boolean canDeleteEmployee(Long userId) {
        return !cartRepository.existsByUserId(userId) && !orderRepository.existsByUserId(userId);
    }

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}