package group04.gundamshop.controller.admin;

import group04.gundamshop.domain.Contact;
import group04.gundamshop.service.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ADContactController {

    @Autowired
    private ContactService contactService;

    @GetMapping("/admin/contact")
    public String showContactList(Model model) {
        model.addAttribute("contactList", contactService.getAllContacts());
        return "admin/contact/show";
    }

    @GetMapping("/admin/contact/view/{id}")
    public String viewContactDetail(@PathVariable("id") Long id, Model model) {
        Contact contact = contactService.getContactById(id);
        if (contact == null) {
            model.addAttribute("errorMessage", "Contact not found.");
            return "admin/contact/show";
        }
        model.addAttribute("contact", contact);
        return "admin/contact/view";
    }

/*
    @GetMapping("/admin/contact/confirm-delete/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String confirmDeleteContact(@PathVariable("id") Long id, Model model) {
        Contact contact = contactService.getContactById(id);
        if (contact == null) {
            model.addAttribute("errorMessage", "Contact not found.");
            return "redirect:/admin/contact";
        }
        model.addAttribute("contact", contact);
        return "admin/contact/delete";
    }

    @PostMapping("/admin/contact/delete")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String deleteContact(@RequestParam("id") Long id, Model model) {
        boolean isDeleted = contactService.deleteContact(id);
        if (!isDeleted) {
            model.addAttribute("errorMessage", "Failed to delete contact.");
            return "redirect:/admin/contact";
        }
        return "redirect:/admin/contact";
    }
*/

    // New: Show reply form
    @GetMapping("/admin/contact/reply/{id}")
    public String showReplyForm(@PathVariable("id") Long id, Model model) {
        Contact contact = contactService.getContactById(id);
        if (contact == null) {
            model.addAttribute("errorMessage", "Contact not found.");
            return "redirect:/admin/contact";
        }
        model.addAttribute("contact", contact);
        return "admin/contact/reply";
    }

    // New: Handle reply submission
    @PostMapping("/admin/contact/reply")
    public String submitReply(@RequestParam("id") Long id, @RequestParam("replyMessage") String replyMessage, Model model) {
        Contact contact = contactService.getContactById(id);
        if (contact == null) {
            model.addAttribute("errorMessage", "Contact not found.");
            return "redirect:/admin/contact";
        }
        contact.setReplyMessage(replyMessage);
        contactService.saveContact(contact);
        // Add notification logic: update replyUpdatedAt and reset notificationReadAt
        contactService.updateReplyNotification(contact);
        return "redirect:/admin/contact";
    }

    @PostMapping("/admin/contact/toggle-status")
    public String toggleStatus(@RequestParam("id") Long id) {
        Contact contact = contactService.getContactById(id);
        if (contact != null) {
            contact.setStatus(!contact.isStatus());
            contactService.saveContact(contact);
        }
        return "redirect:/admin/contact";
    }
}
