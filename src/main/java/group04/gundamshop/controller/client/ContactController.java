
package group04.gundamshop.controller.client;

import group04.gundamshop.domain.Contact;
import group04.gundamshop.service.ContactService;
import group04.gundamshop.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import java.util.List;

@Controller
public class ContactController {

    @Autowired
    private ContactService contactService;

    @GetMapping("/contact/new")
    public String showContactForm(Model model) {
        model.addAttribute("contact", new Contact());
        return "customer/contact/contact";
    }

    @PostMapping("/contact/contact-success")
    public String sendContact(@Valid @ModelAttribute("contact") Contact contact, BindingResult result, Model model,
                              HttpSession session) {
        if (result.hasErrors()) {
            model.addAttribute("error", "Invalid contact information.");
            return "customer/contact/contact";
        }

        Long userId = (Long) session.getAttribute("id");
        if (userId != null) {
            User user = new User();
            user.setId(userId);
            contact.setUser(user);
        } else {
            model.addAttribute("error", "User not logged in.");
            return "customer/contact/contact";
        }

        contactService.saveContact(contact);

        model.addAttribute("message", "Contact sent successfully!");
        return "customer/contact/contact-success";
    }

    // List contacts for logged-in user with admin replies
    @GetMapping("/contact/list")
    public String listUserContacts(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        if (userId == null) {
            model.addAttribute("error", "User not logged in.");
            return "redirect:/login";
        }
        List<Contact> userContacts = contactService.getContactsByUserId(userId);
        // Add highlight flag to each contact
        java.util.Map<Long, Boolean> highlightMap = new java.util.HashMap<>();
        for (Contact contact : userContacts) {
            boolean highlight = false;
            if (contact.getReplyUpdatedAt() != null) {
                if (contact.getNotificationReadAt() == null || contact.getReplyUpdatedAt().isAfter(contact.getNotificationReadAt())) {
                    highlight = true;
                }
            }
            highlightMap.put(contact.getId(), highlight);
        }
        // Sort contacts: highlighted first, then by replyUpdatedAt descending
        userContacts.sort((c1, c2) -> {
            boolean h1 = highlightMap.getOrDefault(c1.getId(), false);
            boolean h2 = highlightMap.getOrDefault(c2.getId(), false);
            if (h1 && !h2) return -1;
            if (!h1 && h2) return 1;
            java.time.LocalDateTime r1 = c1.getReplyUpdatedAt();
            java.time.LocalDateTime r2 = c2.getReplyUpdatedAt();
            if (r1 == null && r2 == null) {
                // fallback to id descending for stable order
                return Long.compare(c2.getId(), c1.getId());
            }
            if (r1 == null) return 1;
            if (r2 == null) return -1;
            int cmp = r2.compareTo(r1);
            if (cmp != 0) return cmp;
            // fallback to id descending for stable order
            return Long.compare(c2.getId(), c1.getId());
        });
        model.addAttribute("contacts", userContacts);
        model.addAttribute("highlightMap", highlightMap);
        // Add anyHighlight flag
        boolean anyHighlight = highlightMap.values().stream().anyMatch(b -> b);
        model.addAttribute("anyHighlight", anyHighlight);
        // Clear notifications when user visits the list page
        contactService.clearReplyNotificationsByUserId(userId);
        return "customer/contact/list";
    }

    // Provide notification count for contacts with replies
    @ModelAttribute("replyNotificationCount")
    public int getReplyNotificationCount(HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        if (userId == null) {
            return 0;
        }
        return contactService.countContactsWithRepliesByUserId(userId);
    }

    // New endpoint to mark notifications as read
    @PostMapping("/contact/mark-as-read")
    public ResponseEntity<Void> markNotificationsAsRead(HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        if (userId != null) {
            contactService.clearReplyNotificationsByUserId(userId);
            return new ResponseEntity<>(HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
    }
}
