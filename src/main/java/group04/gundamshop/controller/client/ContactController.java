package group04.gundamshop.controller.client;

import group04.gundamshop.domain.Contact;
import group04.gundamshop.service.ContactService;
import group04.gundamshop.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ContactController {

    @Autowired
    private ContactService contactService;

    // Display the contact form
    @GetMapping("/contact/new")
    public String showContactForm(Model model) {
        // Ensure the contact object is available in the model with the name "contact"
        model.addAttribute("contact", new Contact());
        return "customer/contact/contact"; // Display the contact form view
    }

    // Handle form submission
    @PostMapping("/contact/contact-success")
    public String sendContact(@Valid @ModelAttribute("contact") Contact contact, BindingResult result, Model model,
                              HttpSession session) {
        if (result.hasErrors()) {
            // If validation errors occur, add them to the model and redisplay the form
            model.addAttribute("error", "Invalid contact information.");
            return "customer/contact/contact"; // Redisplay form with errors
        }

        // Get the userId from the session and set it in the contact object
        Long userId = (Long) session.getAttribute("id"); // Assuming session holds "id" for user
        if (userId != null) {
            // Set the userId to contact and associate the User object (optional, for lazy
            // loading)
            User user = new User(); // Create a user object if needed
            user.setId(userId);
            contact.setUser(user); // This will set the userId automatically via @ManyToOne mapping
        } else {
            model.addAttribute("error", "User not logged in.");
            return "customer/contact/contact"; // Return to form with error message
        }

        // Save the contact information (with userId included)
        contactService.saveContact(contact);

        model.addAttribute("message", "Contact sent successfully!");
        return "customer/contact/contact-success"; // Redirect to a success page
    }
}
