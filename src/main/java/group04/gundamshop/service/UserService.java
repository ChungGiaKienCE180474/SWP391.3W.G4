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
import group04.gundamshop.repository.RoleRepository;
import group04.gundamshop.repository.UserRepository;
import jakarta.persistence.EntityNotFoundException;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    @Autowired
    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
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
            if (row == null || isRowEmpty(row)) continue; // Bỏ qua dòng trống

            User user = new User();
            user.setEmail(getCellValue(row, 0));        // Cột 0: email
            user.setPassword(getCellValue(row, 1));     // Cột 1: password
            user.setPhone(getCellValue(row, 2));        // Cột 2: phone
            user.setFullName(getCellValue(row, 3));     // Cột 3: fullName
            user.setAddress(getCellValue(row, 4));      // Cột 4: address
            user.setStatus(true);                       // Mặc định status = true
            user.setRole(getRoleByName("CUSTOMER"));    // Gán role CUSTOMER
            user.setAvatar(null);                       // Không có avatar từ Excel

            // Dù có lỗi vẫn add vào danh sách users
            users.add(user);
        }
    }
    return users;
}

    // Thêm phương thức kiểm tra dòng trống
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
}