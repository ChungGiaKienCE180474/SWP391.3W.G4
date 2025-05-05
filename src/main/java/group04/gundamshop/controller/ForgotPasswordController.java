package group04.gundamshop.controller;

import java.util.Properties;
import java.util.Random;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import group04.gundamshop.domain.OTPForm;
import group04.gundamshop.domain.ResetPasswordForm;
import group04.gundamshop.domain.User;
import group04.gundamshop.service.UserService;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ForgotPasswordController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public ForgotPasswordController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/forgotpassword")
    public String getForgotPassword(Model model) {
        model.addAttribute("newUser", new User());
        return "authentication/forgotpassword";
    }

    @PostMapping("/authentication/forgotpassword")
    public String recoverPassword(Model model, @ModelAttribute("newUser") User user, HttpServletRequest request) {
        boolean checkEmail = this.userService.checkEmailExist(user.getEmail());
        if (checkEmail) {
            HttpSession mySession = request.getSession();

            // Generate OTP
            int otpvalue = new Random().nextInt(999999);
            String email = user.getEmail();

            // Set properties for mail session
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            // Use app-specific password (fetch from environment variable)

            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("kienchung2107@gmail.com", "npre smsx qgfm zhbu");
                }
            });

            try {
                // Compose the message
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("kienchung2107@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("Password Recovery OTP");
                message.setText("Dear Customer,\n" +
                        "\n" +
                        "Thank you for using LEGO Shop! Your One-Time Password (OTP) is: " + otpvalue + "\n"
                        + "Please enter this code to complete your verification.\n"
                        + "If you did not request this, please ignore this message.\n" +
                        "Best regards,\n" +
                        "LEGO Shop Team");

                // Send the message
                Transport.send(message);
                System.out.println("Message sent successfully");

            } catch (MessagingException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }

            // Store OTP and email in session
            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("email", email);
            request.setAttribute("message", "OTP is sent to your email ID");
            return "redirect:/authentication/enterOTP"; // Change to redirect
        } else {
            request.setAttribute("message", "Invalid email address!");
            return "redirect:/forgotpassword?invalidemail";
        }
    }

    @GetMapping("/authentication/enterOTP")
    public String getOTP(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Integer generatedOtp = (Integer) session.getAttribute("otp");

        // Check if the email and OTP are present in the session
        if (email == null || generatedOtp == null) {
            request.setAttribute("message",
                    "Session expired or unauthorized access. Please go through the forgot password process again.");
            return "redirect:/forgotpassword";
        }
        model.addAttribute("newOtpForm", new OTPForm());
        return "authentication/enterOTP";
    }

    @PostMapping("/authentication/enterOTP")
    public String validateOtp(HttpServletRequest request, @RequestParam("otp") int otp, Model model,
            @ModelAttribute("newOtpForm") OTPForm newOtpForm) {
        HttpSession session = request.getSession();
        Integer generatedOtp = (Integer) session.getAttribute("otp");
        Integer currentOTP = newOtpForm.getOtp();

        if (generatedOtp != null && currentOTP != null && currentOTP.equals(generatedOtp)) {
            return "redirect:/authentication/resetPassword";
        } else {
            request.setAttribute("message", "Invalid OTP. Please try again.");
            return "redirect:/authentication/enterOTP?error";
        }
    }

    @GetMapping("/authentication/resetPassword")
    public String getResetPassword(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Integer generatedOtp = (Integer) session.getAttribute("otp");

        // Check if the email and OTP are present in the session
        if (email == null || generatedOtp == null) {
            request.setAttribute("message",
                    "Session expired or unauthorized access. Please go through the forgot password process again.");
            return "redirect:/forgotpassword";
        }

        model.addAttribute("resetPasswordForm", new ResetPasswordForm());
        return "authentication/resetPassword";
    }

    @PostMapping("/authentication/resetPassword")
    public String resetPassword(HttpServletRequest request,
            @RequestParam("password") String password,
            @RequestParam("confPassword") String confPassword,
            Model model) {

        // Remove leading/trailing spaces
        String trimmedPassword = password.trim();
        String trimmedConfPassword = confPassword.trim();

        // Check for password match
        if (!trimmedPassword.equals(trimmedConfPassword)) {
            return "redirect:/authentication/resetPassword?invalidpassword";
        }

        // Check for length
        if (trimmedPassword.length() < 6) {
            return "redirect:/authentication/resetPassword?shortpassword";
        }

        // Disallow passwords with only spaces or multiple spaces
        if (trimmedPassword.matches(".*\\s{2,}.*") || trimmedPassword.replaceAll(" ", "").isEmpty()
                || trimmedPassword.contains(" ")) {
            return "redirect:/authentication/resetPassword?invalidspace";
        }

        if (trimmedConfPassword.matches(".*\\s{2,}.*") || trimmedConfPassword.replaceAll(" ", "").isEmpty()
                || trimmedConfPassword.contains(" ")) {
            return "redirect:/authentication/resetPassword?invalidspace";
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email != null) {
            String newPassword = this.passwordEncoder.encode(trimmedPassword);
            this.userService.updatePassword(email, newPassword);
            session.invalidate();
            return "redirect:/login?resetsuccess";
        } else {
            return "redirect:/forgotpassword?sessionexpired";
        }
    }

}
