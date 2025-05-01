package group04.gundamshop.controller.client;

import java.util.Properties;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import group04.gundamshop.domain.OTPForm;
import group04.gundamshop.domain.User;
import group04.gundamshop.domain.dto.RegisterDTO;
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
import jakarta.validation.Valid;

@Controller
public class RegisterController {
    private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final ObjectMapper objectMapper;

    public RegisterController(UserService userService, PasswordEncoder passwordEncoder, ObjectMapper objectMapper) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        logger.info("Accessing register page");
        model.addAttribute("registerUser", new RegisterDTO());
        // Clear any existing messages to prevent displaying stale errors
        model.addAttribute("message", null);
        return "authentication/register";
    }

    @PostMapping("/register")
    public String registerUser(Model model, @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult, HttpServletRequest request) {
        logger.info("Processing registration for email: {}", registerDTO.getEmail());
        logger.debug("Password: [{}]", registerDTO.getPassword());
        logger.debug("ConfirmPassword: [{}]", registerDTO.getConfirmPassword());

        // Check if passwords match
        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            logger.warn("Passwords do not match for email: {}", registerDTO.getEmail());
            model.addAttribute("passwordMismatch", true);
            model.addAttribute("registerUser", registerDTO);
            return "authentication/register";
        }

        if (bindingResult.hasErrors()) {
            logger.error("Validation errors occurred:");
            bindingResult.getAllErrors()
                    .forEach(error -> logger.error("Validation error: {}", error.getDefaultMessage()));
            model.addAttribute("registerUser", registerDTO);
            return "authentication/register";
        }

        if (userService.checkEmailExist(registerDTO.getEmail())) {
            logger.warn("Email {} is already registered", registerDTO.getEmail());
            model.addAttribute("message", "Email is already registered. Try logging in.");
            model.addAttribute("registerUser", registerDTO);
            return "authentication/register";
        }

        if (userService.checkPhoneExist(registerDTO.getPhone())) {
            logger.warn("Phone number {} is already registered", registerDTO.getPhone());
            model.addAttribute("message", "Phone number is already registered. Please use a different phone number.");
            model.addAttribute("registerUser", registerDTO);
            return "authentication/register";
        }

        HttpSession mySession = request.getSession();
        int otpValue = new Random().nextInt(999999);
        String email = registerDTO.getEmail();

        try {
            String registerDTOJson = objectMapper.writeValueAsString(registerDTO);
            mySession.setAttribute("registerDTO", registerDTOJson);
            logger.info("Stored RegisterDTO in session for email: {}", email);
        } catch (JsonProcessingException e) {
            logger.error("Failed to serialize RegisterDTO for email: {}", email, e);
            model.addAttribute("message", "Error processing registration. Please try again.");
            model.addAttribute("registerUser", registerDTO);
            return "authentication/register";
        }

        mySession.setAttribute("otp", otpValue);
        mySession.setAttribute("email", email);
        logger.debug("Generated OTP: {} for email: {}", otpValue, email);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("kienchung2107@gmail.com", "npre smsx qgfm zhbu");
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("kienchung2107@gmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("GUNDAM SHOP - One-Time Password (OTP) Verification");
            message.setText("Dear Customer,\n\nYour One-Time Password (OTP) for registration is: " + otpValue +
                    "\n\nPlease enter this code to complete your registration. For security reasons, do not share this code with anyone.\n\n"
                    +
                    "Thank you for choosing GUNDAM SHOP!\n\n" +
                    "Best regards,\nGUNDAM SHOP Team");

            Transport.send(message);
            logger.info("OTP email sent successfully to: {}", email);

        } catch (MessagingException e) {
            logger.error("Failed to send OTP email to: {}", email, e);
            model.addAttribute("message", "Failed to send OTP. Please try again.");
            model.addAttribute("registerUser", registerDTO);
            return "authentication/register";
        }

        return "redirect:/authentication/enterRegisterOTP";
    }

    @GetMapping("/authentication/enterRegisterOTP")
    public String getOTPPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String registerDTOJson = (String) session.getAttribute("registerDTO");

        if (registerDTOJson == null) {
            logger.warn("Session expired or no RegisterDTO found");
            model.addAttribute("message", "Session expired. Please register again.");
            return "redirect:/register";
        }

        logger.info("Accessing OTP entry page");
        model.addAttribute("newOtpForm", new OTPForm());
        return "authentication/enterRegisterOTP";
    }

    @PostMapping("/authentication/enterRegisterOTP")
    public String validateOtp(HttpServletRequest request, @RequestParam("otp") int otp, Model model) {
        HttpSession session = request.getSession();
        Integer generatedOtp = (Integer) session.getAttribute("otp");
        String registerDTOJson = (String) session.getAttribute("registerDTO");
        String email = (String) session.getAttribute("email");

        logger.info("Validating OTP for email: {}, entered OTP: {}", email, otp);
        logger.debug("Stored OTP: {}", generatedOtp);

        if (registerDTOJson == null) {
            logger.error("No RegisterDTO found in session for email: {}", email);
            model.addAttribute("message", "Session error. Please try again.");
            return "authentication/register";
        }

        RegisterDTO registerDTO = null;
        try {
            registerDTO = objectMapper.readValue(registerDTOJson, RegisterDTO.class);
            logger.debug("Deserialized RegisterDTO: {}", registerDTO);
        } catch (JsonProcessingException e) {
            logger.error("Failed to deserialize RegisterDTO for email: {}", email, e);
            model.addAttribute("message", "Session error. Please try again.");
            return "authentication/register";
        }

        if (generatedOtp != null && generatedOtp.equals(otp) && registerDTO != null) {
            logger.info("OTP validated successfully for email: {}", email);
            try {
                User user = this.userService.registerDTOtoUser(registerDTO);
                String hashPassword = this.passwordEncoder.encode(registerDTO.getPassword());
                user.setPassword(hashPassword);
                user.setRole(this.userService.getRoleByName("CUSTOMER"));
                user.setStatus(true);

                logger.debug("User object before saving: {}", user);
                this.userService.handleSaveUser(user);
                logger.info("User successfully saved for email: {}", email);

                session.invalidate();
                return "redirect:/login?registersuccess";
            } catch (Exception e) {
                logger.error("Failed to save user for email: {}", email, e);
                model.addAttribute("message", "Failed to create user. Please try again.");
                return "authentication/enterRegisterOTP";
            }
        } else {
            logger.warn("Invalid OTP for email: {}. Entered: {}, Expected: {}", email, otp, generatedOtp);
            model.addAttribute("message", "Invalid OTP. Please try again.");
            return "authentication/enterRegisterOTP";
        }
    }
}