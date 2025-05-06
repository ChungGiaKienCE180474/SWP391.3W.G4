package group04.gundamshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group04.gundamshop.domain.User;
import group04.gundamshop.service.UploadService;
import group04.gundamshop.service.UserService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    // -------------------------------- User ---------------------------------
    @GetMapping("/admin/user")
    public String getDashboard(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user/show";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(Model model, @ModelAttribute("newUser") @Valid User user,
            BindingResult newUserBindingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {
        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create";
        }
        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setAvatar(avatar);
        user.setPassword(hashPassword);
        user.setStatus(true);
        user.setRole(this.userService.getRoleByName(user.getRole().getName()));
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUser(Model model, @ModelAttribute("newUser") User eric) {
        this.userService.deleteAUser(eric.getId());
        return "redirect:/admin/user";
    }

    // -------------------------------- Customer Ban/Unban
    // ---------------------------------
    @PostMapping("/admin/customer/ban/{userId}")
    public String banOrUnbanCustomer(@PathVariable Long userId, @RequestParam boolean status,
            RedirectAttributes redirectAttributes) {
        try {
            if (!status) {
                userService.banCustomerAccount(userId);
                redirectAttributes.addFlashAttribute("message", "This account was banned");
            } else {
                userService.unbanCustomerAccount(userId);
                redirectAttributes.addFlashAttribute("message", "The account was unbanned successfully");
            }
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (EntityNotFoundException e) {
            redirectAttributes.addFlashAttribute("error", "Account not found!");
        }
        return "redirect:/admin/customer";
    }

    // -------------------------------- Customer ---------------------------------
    @GetMapping("/admin/customer")
    public String getAllCustomer(Model model) {
        List<User> customers = this.userService.getUsersRoleId(3);
        model.addAttribute("customers", customers);
        return "admin/customer/show";
    }

    @GetMapping("/admin/customer/create")
    public String getCreateCustomerPage(Model model) {
        model.addAttribute("newCustomer", new User());
        return "admin/customer/create";
    }

    @PostMapping(value = "admin/customer/create")
    public String createCustomerPage(Model model,
            @ModelAttribute("newCustomer") @Valid User customer,
            BindingResult newUserBindingResult,
            @RequestParam(value = "imagesFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "excelFile", required = false) MultipartFile excelFile,
            RedirectAttributes redirectAttributes) {
        if (excelFile == null || excelFile.isEmpty()) {
            boolean hasError = false;

            // Kiểm tra các lỗi từ @Valid
            if (newUserBindingResult.hasErrors()) {
                hasError = true;
            }

            // Kiểm tra email: không được trống, đúng định dạng, bắt đầu bằng chữ và không
            // toàn số
            if (customer.getEmail() == null || customer.getEmail().trim().isEmpty()) {
                model.addAttribute("emailError", "Email must not be empty.");
                hasError = true;
            } else if (!customer.getEmail().matches("^[a-zA-Z][a-zA-Z0-9_.-]*@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$")) {
                model.addAttribute("emailError",
                        "Email must start with a letter and be in a valid format (e.g. example@gmail.com).");
                hasError = true;
            } else if (this.userService.checkEmailExist(customer.getEmail())) {
                model.addAttribute("emailExistError", "Email is already registered.");
                hasError = true;
            }

            // Kiểm tra password: không được trống và phải hợp lệ
            String password = customer.getPassword();
            if (password == null || password.trim().isEmpty()) {
                model.addAttribute("passwordError", "Password must not be empty.");
                hasError = true;
            } else if (!password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")) {
                model.addAttribute("passwordError",
                        "Password must be at least 6 characters and contain letters and numbers.");
                hasError = true;
            }

            // Cho phép chữ cái (có dấu) và khoảng trắng, không cho phép số hoặc ký tự đặc
            // biệt
            if (customer.getFullName() == null || customer.getFullName().trim().isEmpty()) {
                model.addAttribute("fullNameError", "Full name must not be empty.");
                hasError = true;
            } else if (!customer.getFullName().matches("^[\\p{L}\\s]+$")) {
                model.addAttribute("fullNameError",
                        "Full name must contain only letters and spaces.");
                hasError = true;
            }

            // Kiểm tra số điện thoại: không được trống và phải hợp lệ
            String phone = customer.getPhone();
            if (phone == null || phone.trim().isEmpty()) {
                model.addAttribute("phoneError", "Phone number must not be empty.");
                hasError = true;
            } else if (!phone.matches("0\\d{9}")) {
                model.addAttribute("phoneError", "Phone number must start with 0 and have 10 digits.");
                hasError = true;
            } else if (this.userService.checkPhoneExist(phone)) {
                model.addAttribute("phoneError", "Phone number is already registered.");
                hasError = true;
            }

            // Kiểm tra địa chỉ: bắt buộc nhập
            if (customer.getAddress() == null || customer.getAddress().trim().isEmpty()) {
                model.addAttribute("addressError", "Address must not be empty.");
                hasError = true;
            }

            // // Kiểm tra email đã tồn tại
            // if (this.userService.checkEmailExist(customer.getEmail())) {
            // model.addAttribute("emailExistError", "Email is already registered.");
            // hasError = true;
            // }

            if (hasError) {
                return "admin/customer/create";
            }
            // Không có lỗi thì xử lý lưu
            String avatar = (imageFile != null && !imageFile.isEmpty())
                    ? this.uploadService.handleSaveUploadFile(imageFile, "avatar")
                    : null;
            String hashPassword = this.passwordEncoder.encode(customer.getPassword());
            customer.setAvatar(avatar);
            customer.setPassword(hashPassword);
            customer.setStatus(true);
            customer.setRole(this.userService.getRoleByName("CUSTOMER"));
            this.userService.handleSaveUser(customer);

            // Thêm thông báo thành công
            redirectAttributes.addFlashAttribute("successMessage", "Account created successfully.");
        }
        // Trường hợp import từ Excel
        else {
            try {
                List<User> customers = this.userService.importFromExcel(excelFile);
                if (customers.isEmpty()) {
                    model.addAttribute("errorMessage", "No valid customers found in Excel file");
                    return "admin/customer/create";
                }
                for (User user : customers) {
                    if (this.userService.checkEmailExist(user.getEmail())) {
                        continue; // Bỏ qua nếu email đã tồn tại
                    }
                    user.setPassword(this.passwordEncoder.encode(user.getPassword()));
                    this.userService.handleSaveUser(user);
                }
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Error importing Excel file: " + e.getMessage());
                return "admin/customer/create";
            }
        }
        return "redirect:/admin/customer";
    }

    @PostMapping("/admin/customer/import")
    public String importCustomersFromExcel(@RequestParam("excelFile") MultipartFile excelFile,
            RedirectAttributes redirectAttributes) {
        try {
            if (excelFile.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Please select an Excel file to import.");
                return "redirect:/admin/customer";
            }
            List<User> customers = this.userService.importFromExcel(excelFile);
            if (customers.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "No valid customers found in Excel file.");
                return "redirect:/admin/customer";
            }
            int successCount = 0;
            int errorCount = 0;
            StringBuilder errorDetails = new StringBuilder();
            for (User user : customers) {
                StringBuilder userErrors = new StringBuilder();

                // Kiểm tra email đã tồn tại
                if (this.userService.checkEmailExist(user.getEmail())) {
                    userErrors.append("Email already exists; ");
                }

                // Kiểm tra password
                if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
                    userErrors.append("Password is empty; ");
                }

                // Kiểm tra số điện thoại (bắt đầu bằng 0 và đủ 10 số)
                if (user.getPhone() == null || !user.getPhone().matches("^0\\d{9}$")) {
                    userErrors.append("Phone number must start with 0 and have 10 digits; ");
                }

                // Kiểm tra full name (tùy nếu bạn muốn bắt buộc)
                if (user.getFullName() == null || user.getFullName().trim().isEmpty()) {
                    userErrors.append("Full name is empty; ");
                }

                // kiểm tra add rỗng
                if (user.getAddress() == null || user.getAddress().trim().isEmpty()) {
                    userErrors.append("Address is empty");
                }

                // Nếu có lỗi thì ghi lại và bỏ qua bản ghi này
                if (userErrors.length() > 0) {
                    errorCount++;
                    errorDetails.append("User with email ").append(user.getEmail()).append(": ")
                            .append(userErrors.toString()).append(" ");
                    continue;
                }

                // Nếu không có lỗi, thì encode password và lưu
                try {
                    user.setPassword(this.passwordEncoder.encode(user.getPassword()));
                    this.userService.handleSaveUser(user);
                    successCount++;
                } catch (Exception e) {
                    errorCount++;
                    errorDetails.append("User with email ").append(user.getEmail())
                            .append(": ").append(e.getMessage()).append("; ");
                }
            }

            if (successCount > 0) {
                redirectAttributes.addFlashAttribute("message",
                        "Imported " + successCount + " customers successfully.");
            }
            if (errorCount > 0) {
                redirectAttributes.addFlashAttribute("error",
                        "Failed to import " + errorCount + " customers: " + errorDetails.toString());
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error importing Excel file: " + e.getMessage());
        }
        return "redirect:/admin/customer";
    }

    @GetMapping("/admin/customer/delete/{id}")
    public String getDeleteCustomerPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newCustomer", new User());
        return "admin/customer/delete";
    }

    @PostMapping("/admin/customer/delete")
    public String postDeleteCustomer(Model model, @ModelAttribute("newCustomer") User customer) {
        Optional<User> customerOptional = this.userService.getUserById(customer.getId());
        User currentCustomer = customerOptional.orElse(null);
        if (currentCustomer != null) {
            currentCustomer.setStatus(false);
            this.userService.handleSaveUser(currentCustomer);
        }
        return "redirect:/admin/customer";
    }

    @RequestMapping("/admin/customer/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        Optional<User> customerOptional = this.userService.getUserById(id);
        User currentCustomer = customerOptional.orElse(null);
        if (currentCustomer == null || !currentCustomer.isStatus()) {
            return "redirect:/admin/customer";
        }
        model.addAttribute("newCustomer", currentCustomer);
        return "admin/customer/update";
    }

    @PostMapping("/admin/customer/update")
    public String postUpdateUser(Model model, @ModelAttribute("newCustomer") @Valid User customer,
            BindingResult newProductBindingResult,
            @RequestParam("imagesFile") MultipartFile file) {
        Optional<User> customerOptional = this.userService.getUserById(customer.getId());
        User currentCustomer = customerOptional.orElse(null);
        if (currentCustomer != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentCustomer.setAvatar(img);
            }
            currentCustomer.setAddress(customer.getAddress());
            currentCustomer.setFullName(customer.getFullName());
            currentCustomer.setPhone(customer.getPhone());
            this.userService.handleSaveUser(currentCustomer);
        }
        return "redirect:/admin/customer";
    }

    @GetMapping("/admin/customer/{id}")
    public String getCustomerDetailPage(Model model, @PathVariable long id) {
        Optional<User> customerOptional = this.userService.getUserById(id);
        User newCustomer = customerOptional.orElse(null);
        model.addAttribute("newCustomer", newCustomer);
        model.addAttribute("id", id);
        return "admin/customer/detail";
    }

    // -------------------------------- Employee ---------------------------------
    @GetMapping("/admin/employee")
    public String getAllEmployee(Model model) {
        List<User> employees = this.userService.getUsersByRoleId(2L);
        model.addAttribute("employees", employees);
        return "admin/employee/show";
    }

    @GetMapping("/admin/employee/create")
    public String getCreateEmployeePage(Model model) {
        model.addAttribute("newEmployee", new User());
        return "admin/employee/create";
    }

    @PostMapping(value = "/admin/employee/create")
    public String createEmployeePage(Model model,
            @ModelAttribute("newEmployee") @Valid User employee,
            BindingResult newUserBindingResult,
            HttpServletRequest request,
            @RequestParam("imagesFile") MultipartFile file) {
        // Kiểm tra lỗi validation
        if (newUserBindingResult.hasErrors()) {
            return "admin/employee/create";
        }

        try {
            // Xử lý avatar
            String avatar = file != null && !file.isEmpty() ? this.uploadService.handleSaveUploadFile(file, "avatar")
                    : null;
            employee.setAvatar(avatar);

            // Lưu mật khẩu gốc để gửi email
            String rawPassword = employee.getPassword();

            // Mã hóa mật khẩu
            String hashPassword = this.passwordEncoder.encode(rawPassword);
            employee.setPassword(hashPassword);

            // Thiết lập các thuộc tính khác
            employee.setStatus(true);
            employee.setRole(this.userService.getRoleByName("EMPLOYEE"));

            // Lưu employee và gửi email
            this.userService.saveEmployeeWithEmail(employee, rawPassword);

            return "redirect:/admin/employee";
        } catch (Exception e) {
            model.addAttribute("message", "Error creating employee: " + e.getMessage());
            return "admin/employee/create";
        }
    }

    @GetMapping("/admin/employee/resend-email/{id}")
    public String resendEmployeeEmail(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.resendEmployeeEmail(id);
            redirectAttributes.addFlashAttribute("message", "Account email resent successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error resending email: " + e.getMessage());
        }
        return "redirect:/admin/employee";
    }

    @RequestMapping("/admin/employee/update/{id}")
    public String getUpdateEmployeePage(Model model, @PathVariable long id) {
        Optional<User> employeeOptional = this.userService.getUserById(id);
        User currentEmployee = employeeOptional.orElse(null);
        if (currentEmployee == null || !currentEmployee.isStatus()) {
            return "redirect:/admin/employee";
        }
        model.addAttribute("newEmployee", currentEmployee);
        return "admin/employee/update";
    }

    @PostMapping("/admin/employee/update")
    public String postUpdateEmployee(Model model, @ModelAttribute("newEmployee") @Valid User employee,
            BindingResult newProductBindingResult,
            @RequestParam("imagesFile") MultipartFile file) {
        Optional<User> employeeOptional = this.userService.getUserById(employee.getId());
        User currentEmployee = employeeOptional.orElse(null);
        if (currentEmployee != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentEmployee.setAvatar(img);
            }
            currentEmployee.setAddress(employee.getAddress());
            currentEmployee.setFullName(employee.getFullName());
            currentEmployee.setPhone(employee.getPhone());
            this.userService.handleSaveUser(currentEmployee);
        }
        return "redirect:/admin/employee";
    }

    @GetMapping("/admin/employee/delete/{id}")
    public String getDeleteEmployeePage(Model model, @PathVariable long id) {
        Optional<User> userOptional = this.userService.getUserById(id);
        if (userOptional.isPresent()) {
            User employee = userOptional.get();
            model.addAttribute("fullName", employee.getFullName());
            model.addAttribute("email", employee.getEmail());
            model.addAttribute("id", id);
        } else {
            return "redirect:/admin/employee?error=notfound";
        }
        return "admin/employee/delete";
    }

    @PostMapping("/admin/employee/delete")
    public String postDeleteEmployee(Model model, @RequestParam("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            this.userService.deleteEmployee(id);
            redirectAttributes.addFlashAttribute("message", "Employee deleted successfully.");
        } catch (EntityNotFoundException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/employee";
    }

    @GetMapping("/admin/employee/{id}")
    public String getEmployeeDetailPage(Model model, @PathVariable long id) {
        Optional<User> employeeOptional = this.userService.getUserById(id);
        User newEmployee = employeeOptional.orElse(null);
        model.addAttribute("newEmployee", newEmployee);
        model.addAttribute("id", id);
        return "admin/employee/detail";
    }

    // -------------------------------- Employee Ban/Unban
    @PostMapping("/admin/employee/ban/{userId}")
    public String banOrUnbanEmployee(@PathVariable Long userId, @RequestParam boolean status,
            RedirectAttributes redirectAttributes) {
        try {
            if (!status) {
                userService.banEmployeeAccount(userId);
                redirectAttributes.addFlashAttribute("message", "Employee account was banned.");
            } else {
                userService.unbanEmployeeAccount(userId);
                redirectAttributes.addFlashAttribute("message", "Employee account was unbanned successfully.");
            }
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (EntityNotFoundException e) {
            redirectAttributes.addFlashAttribute("error", "Employee account not found!");
        }
        return "redirect:/admin/employee";
    }

}