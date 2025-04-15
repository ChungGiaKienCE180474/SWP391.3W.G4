package group04.gundamshop.domain.dto;

import java.io.Serializable;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.AssertTrue;

public class RegisterDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @Size(min = 3, message = "FirstName must at least 3 digit")
    private String firstName;

    @Size(min = 3, message = "LastName must at least 3 digit")
    private String lastName;

    @Email(message = "Not valid emailemail", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @Size(min = 6, message = "Password must have 6 digit")
    private String password;

    private String confirmPassword;

    @Size(min = 10, message = "Phone must at least 10 numbers")
    private String phone;

    @NotNull(message = "Address is an optional")
    private String address;

    @AssertTrue(message = "Password and ConfirmPassword must match")
    public boolean isPasswordMatching() {
        return password != null && password.equals(confirmPassword);
    }

    public String getFullName() {
        return firstName + " " + lastName; // Tạo fullName từ firstName và lastName
    }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}
