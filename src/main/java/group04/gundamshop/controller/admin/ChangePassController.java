package group04.gundamshop.controller.admin;

import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import group04.gundamshop.domain.PasswordChangeForm;
import group04.gundamshop.domain.User;
import group04.gundamshop.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ChangePassController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public ChangePassController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    // --- Admin Password Change ---
    @GetMapping("/admin/changepass")
    public String showChangePassForm(Model model) {
        model.addAttribute("passwordChangeForm", new PasswordChangeForm());
        return "admin/changepass/pass"; // Path to pass.jsp
    }

    @PostMapping("/admin/changepass")
    public String changePassword(
            @Valid PasswordChangeForm passwordChangeForm,
            BindingResult bindingResult,
            Model model,
            HttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errorMessage", "Please correct the errors below.");
            return "admin/changepass/pass";
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || email.isEmpty()) {
            model.addAttribute("errorMessage", "Session has expired or user is not logged in.");
            return "admin/changepass/pass";
        }

        String newPassword = passwordChangeForm.getNewPassword();
        String confirmPassword = passwordChangeForm.getConfirmPassword();

        if (newPassword.length() < 6 || confirmPassword.length() < 6) {
            model.addAttribute("errorMessage", "Password must contain at least 6 characters.");
            return "admin/changepass/pass";
        }

        // ❗️Kiểm tra khoảng trắng liên tiếp hoặc toàn khoảng trắng
        if (newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty() || newPassword.contains(" ")
                || confirmPassword.contains(" ") ||
                newPassword.matches(".*\\s{6,}.*") || confirmPassword.matches(".*\\s{6,}.*")) {
            model.addAttribute("errorMessage", "Password cannot contain only spaces or 6+ consecutive spaces.");
            return "admin/changepass/pass";
        }

        Optional<User> user = userService.getUserByEmail(email);
        if (user.isEmpty()) {
            model.addAttribute("errorMessage", "User not found.");
            return "admin/changepass/pass";
        }

        if (!passwordEncoder.matches(passwordChangeForm.getCurrentPassword(), user.get().getPassword())) {
            bindingResult.rejectValue("currentPassword", "error.passwordChangeForm", "Current password is incorrect.");
            return "admin/changepass/pass";
        }

        if (!passwordChangeForm.getNewPassword().equals(passwordChangeForm.getConfirmPassword())) {
            bindingResult.rejectValue("confirmPassword", "error.passwordChangeForm",
                    "New password and confirmation password do not match.");
            return "admin/changepass/pass";
        }
        if (passwordChangeForm.getNewPassword().length() < 6) {
            model.addAttribute("errorMessage", "New password must contain 6 letters.");
            return "admin/changepass/pass";
        }

        if (passwordChangeForm.getConfirmPassword().length() < 6) {
            model.addAttribute("errorMessage", "Confirmm password must contain 6 letters.");
            return "admin/changepass/pass";
        }

        // Lưu mật khẩu mới
        String hashedNewPassword = passwordEncoder.encode(passwordChangeForm.getNewPassword());
        userService.updatePassword(user.get().getEmail(), hashedNewPassword);

        model.addAttribute("successMessage", "Password has been successfully changed.");
        return "admin/changepass/pass";
    }

    // --- Employee Password Change ---
    @GetMapping("/employee/changepass")
    public String showChangePassFormEmployee(Model model) {
        model.addAttribute("passwordChangeForm", new PasswordChangeForm());
        return "employee/changepass/pass"; // Path to pass.jsp
    }

    @PostMapping("/employee/changepass")
    public String changePasswordEmployee(
            @Valid PasswordChangeForm passwordChangeForm,
            BindingResult bindingResult,
            Model model,
            HttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errorMessage", "Please correct the errors below.");
            return "employee/changepass/pass";
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || email.isEmpty()) {
            model.addAttribute("errorMessage", "Session has expired or user is not logged in.");
            return "employee/changepass/pass";
        }

        String newPassword = passwordChangeForm.getNewPassword();
        String confirmPassword = passwordChangeForm.getConfirmPassword();

        if (newPassword.length() < 6 || confirmPassword.length() < 6) {
            model.addAttribute("errorMessage", "Password must contain at least 6 characters.");
            return "employee/changepass/pass";
        }

        // ❗️Kiểm tra khoảng trắng liên tiếp hoặc toàn khoảng trắng
        if (newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty() || newPassword.contains(" ")
                || confirmPassword.contains(" ") ||
                newPassword.matches(".*\\s{6,}.*") || confirmPassword.matches(".*\\s{6,}.*")) {
            model.addAttribute("errorMessage", "Password cannot contain only spaces or 6+ consecutive spaces.");
            return "employee/changepass/pass";
        }

        Optional<User> user = userService.getUserByEmail(email);
        if (user.isEmpty()) {
            model.addAttribute("errorMessage", "User not found.");
            return "employee/changepass/pass";
        }

        if (!passwordEncoder.matches(passwordChangeForm.getCurrentPassword(), user.get().getPassword())) {
            model.addAttribute("errorMessage", "Current password is incorrect.");
            return "employee/changepass/pass";
        }

        if (!passwordChangeForm.getNewPassword().equals(passwordChangeForm.getConfirmPassword())) {
            model.addAttribute("errorMessage", "New password and confirmation password do not match.");
            return "employee/changepass/pass";
        }
        if (passwordChangeForm.getNewPassword().length() < 6) {
            model.addAttribute("errorMessage", "New password must contain 6 letters.");
            return "employee/changepass/pass";
        }

        if (passwordChangeForm.getConfirmPassword().length() < 6) {
            model.addAttribute("errorMessage", "Confirmm password must contain 6 letters.");
            return "employee/changepass/pass";
        }

        // Băm mật khẩu mới trước khi lưu
        String hashedNewPassword = passwordEncoder.encode(passwordChangeForm.getNewPassword());
        userService.updatePassword(user.get().getEmail(), hashedNewPassword);

        model.addAttribute("successMessage", "Password has been successfully changed.");
        return "employee/changepass/pass";
    }

    // --- Customer Password Change ---
    @GetMapping("/customer/changepass")
    public String showChangePassFormCustomer(Model model) {
        model.addAttribute("passwordChangeForm", new PasswordChangeForm());
        return "customer/changepass/pass"; // Path to pass.jsp
    }

    @PostMapping("/customer/changepass")
    public String changePasswordCustomer(
            @Valid PasswordChangeForm passwordChangeForm,
            BindingResult bindingResult,
            Model model,
            HttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errorMessage", "Please correct the errors below.");
            return "customer/changepass/pass";
        }

        String newPassword = passwordChangeForm.getNewPassword();
        String confirmPassword = passwordChangeForm.getConfirmPassword();

        if (newPassword.length() < 6 || confirmPassword.length() < 6) {
            model.addAttribute("errorMessage", "Password must contain at least 6 characters.");
            return "customer/changepass/pass";
        }

        // ❗️Kiểm tra khoảng trắng liên tiếp hoặc toàn khoảng trắng
        if (newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty() || newPassword.contains(" ")
                || confirmPassword.contains(" ") ||
                newPassword.matches(".*\\s{6,}.*") || confirmPassword.matches(".*\\s{6,}.*")) {
            model.addAttribute("errorMessage", "Password cannot contain only spaces or 6+ consecutive spaces.");
            return "customer/changepass/pass";
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || email.isEmpty()) {
            model.addAttribute("errorMessage", "Session has expired or user is no0t logged in.");
            return "customer/changepass/pass";
        }

        Optional<User> user = userService.getUserByEmail(email);
        if (user.isEmpty()) {
            model.addAttribute("errorMessage", "User not found.");
            return "customer/changepass/pass";
        }

        if (!passwordEncoder.matches(passwordChangeForm.getCurrentPassword(), user.get().getPassword())) {
            model.addAttribute("errorMessage", "Current password is incorrect.");
            return "customer/changepass/pass";
        }

        if (!passwordChangeForm.getNewPassword().equals(passwordChangeForm.getConfirmPassword())) {
            model.addAttribute("errorMessage", "New password and confirmation password do not match.");
            return "customer/changepass/pass";
        }

        if (passwordChangeForm.getNewPassword().length() < 6) {
            model.addAttribute("errorMessage", "New password must contain 6 letters.");
            return "customer/changepass/pass";
        }

        if (passwordChangeForm.getConfirmPassword().length() < 6) {
            model.addAttribute("errorMessage", "Confirmm password must contain 6 letters.");
            return "customer/changepass/pass";
        }
        // Băm mật khẩu mới trước khi lưu
        String hashedNewPassword = passwordEncoder.encode(passwordChangeForm.getNewPassword());
        userService.updatePassword(user.get().getEmail(), hashedNewPassword);

        model.addAttribute("successMessage", "Password has been successfully changed.");
        return "customer/changepass/pass";
    }
}