package group04.gundamshop.service;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;

import java.util.Properties;

@Service
public class EmailService {

    public void sendRegistrationEmail(String to, String username, String email, String password)
            throws MessagingException {
        // Cấu hình SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Thông tin xác thực
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("kienchung2107@gmail.com", "npre smsx qgfm zhbu"); // Thay bằng App
                                                                                                     // Password của bạn
            }
        });

        // Tạo và gửi email
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress("kienchung2107@gmail.com"));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("LEGO SHOP - Your Employee Account Details");
        message.setText("Dear " + username + ",\n\n" +
                "Your employee account has been successfully created. Below are your registration details:\n\n" +
                "Username: " + username + "\n" +
                "Email: " + email + "\n" +
                "Password: " + password + "\n\n" +
                "Please keep this information secure and do not share it with others.\n\n" +
                "Thank you for joining LEGO SHOP!\n\n" +
                "Best regards,\nLEGO SHOP Team");

        Transport.send(message);
    }
}