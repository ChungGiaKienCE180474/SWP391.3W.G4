package group04.gundamshop.controller.admin;

import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group04.gundamshop.domain.User;
import group04.gundamshop.service.UploadService;
import group04.gundamshop.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProfileController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public ProfileController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/profile/{id}")
    public String getAdminProfile(@PathVariable Long id, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        String email = (String) session.getAttribute("username");
        System.out.println("GET - Session email: " + email);
        Optional<User> optionalUser = userService.getUserByEmail(email);
        if (optionalUser.isEmpty() || optionalUser.get().getId() != id) {
            return "redirect:/login";
        }
        User userFromDb = optionalUser.get();
        System.out.println("GET - User from DB: ID=" + userFromDb.getId() + ", FullName=" + userFromDb.getFullName());
        model.addAttribute("newUser", userFromDb);
        return "admin/profile/profile";
    }

    @PostMapping("/admin/profile/update")
    public String updateAdminProfile(@ModelAttribute("newUser") User user,
            @RequestParam("imagesFile") MultipartFile file,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes,
            Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            redirectAttributes.addFlashAttribute("error", "User not authenticated.");
            return "redirect:/login";
        }

        String email = (String) session.getAttribute("username");
        Optional<User> sessionUserOptional = userService.getUserByEmail(email);
        if (sessionUserOptional.isEmpty() || sessionUserOptional.get().getId() != user.getId()) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized action.");
            return "redirect:/admin/profile/" + user.getId();
        }
        Optional<User> optionalUser = userService.getUserById(user.getId());
        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();

            // Kiểm tra số điện thoại trùng lặp
            if (user.getPhone() != null && !currentUser.getPhone().equals(user.getPhone()) &&
                    userService.checkPhoneExist(user.getPhone())) {
                redirectAttributes.addFlashAttribute("error", "Phone number is already in use by another user.");
                return "redirect:/admin/profile/" + user.getId();
            }

            if (!file.isEmpty()) {
                String img = uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(img);
            }

            currentUser.setAddress(user.getAddress());
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());

            try {
                userService.handleSaveUser(currentUser);
                redirectAttributes.addFlashAttribute("message", "Profile updated successfully.");
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Error updating profile");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "User not found.");
        }

        return "redirect:/admin/profile/" + user.getId();
    }

    @GetMapping("/employee/profile/{id}")
    public String getEmployeeProfile(@PathVariable Long id, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        String email = (String) session.getAttribute("username");
        System.out.println("GET - Session email: " + email);
        Optional<User> optionalUser = userService.getUserByEmail(email);
        if (optionalUser.isEmpty() || optionalUser.get().getId() != id) {
            return "redirect:/login";
        }
        User userFromDb = optionalUser.get();
        System.out.println("GET - User from DB: ID=" + userFromDb.getId() + ", FullName=" + userFromDb.getFullName());
        model.addAttribute("newUser", userFromDb);
        return "employee/profile/profile";
    }

    @PostMapping("/employee/profile/update")
    public String updateEmployeeProfile(@ModelAttribute("newUser") User user,
            @RequestParam("imagesFile") MultipartFile file,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes,
            Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            redirectAttributes.addFlashAttribute("error", "User not authenticated.");
            return "redirect:/login";
        }

        String email = (String) session.getAttribute("username");
        Optional<User> sessionUserOptional = userService.getUserByEmail(email);
        if (sessionUserOptional.isEmpty() || sessionUserOptional.get().getId() != user.getId()) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized action.");
            return "redirect:/employee/profile/" + user.getId();
        }
        Optional<User> optionalUser = userService.getUserById(user.getId());
        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();

            // Kiểm tra số điện thoại trùng lặp
            if (user.getPhone() != null && !currentUser.getPhone().equals(user.getPhone()) &&
                    userService.checkPhoneExist(user.getPhone())) {
                redirectAttributes.addFlashAttribute("error", "Phone number is already in use by another user.");
                return "redirect:/employee/profile/" + user.getId();
            }

            if (!file.isEmpty()) {
                String img = uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(img);
            }

            currentUser.setAddress(user.getAddress());
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());

            try {
                userService.handleSaveUser(currentUser);
                redirectAttributes.addFlashAttribute("message", "Profile updated successfully.");
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Error updating profile");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "User not found.");
        }

        return "redirect:/employee/profile/" + user.getId();
    }

    @GetMapping("/customer/profile/{id}")
    public String getCustomerProfile(@PathVariable Long id, Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        String email = (String) session.getAttribute("username");
        System.out.println("GET - Session email: " + email);
        Optional<User> optionalUser = userService.getUserByEmail(email);
        if (optionalUser.isEmpty() || optionalUser.get().getId() != id) {
            return "redirect:/login";
        }
        User userFromDb = optionalUser.get();
        System.out.println("GET - User from DB: ID=" + userFromDb.getId() + ", FullName=" + userFromDb.getFullName());
        model.addAttribute("newUser", userFromDb);
        return "customer/profile/profile";
    }

    @PostMapping("/customer/profile/update")
    public String updateCustomerProfile(@ModelAttribute("newUser") User user,
            @RequestParam("imagesFile") MultipartFile file,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes,
            Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            redirectAttributes.addFlashAttribute("error", "User not authenticated.");
            return "redirect:/login";
        }

        String email = (String) session.getAttribute("username");
        Optional<User> sessionUserOptional = userService.getUserByEmail(email);
        if (sessionUserOptional.isEmpty() || sessionUserOptional.get().getId() != user.getId()) {
            redirectAttributes.addFlashAttribute("error", "Unauthorized action.");
            return "redirect:/customer/profile/" + user.getId();
        }

        Optional<User> optionalUser = userService.getUserById(user.getId());
        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();

            // Kiểm tra số điện thoại trùng lặp
            if (user.getPhone() != null && !currentUser.getPhone().equals(user.getPhone()) &&
                    userService.checkPhoneExist(user.getPhone())) {
                redirectAttributes.addFlashAttribute("error", "Phone number is already in use by another user.");
                return "redirect:/customer/profile/" + user.getId();
            }

            if (!file.isEmpty()) {
                String img = uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(img);
            }

            currentUser.setAddress(user.getAddress());
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());

            try {
                userService.handleSaveUser(currentUser);
                redirectAttributes.addFlashAttribute("message", "Profile updated successfully.");
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Error updating profile: " + e.getMessage());
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "User not found.");
        }

        return "redirect:/customer/profile/" + user.getId();
    }
}