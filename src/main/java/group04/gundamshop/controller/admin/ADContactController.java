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

    /**
     * Hiển thị danh sách liên hệ của khách hàng.
     * @param model Đối tượng Model để truyền dữ liệu sang view.
     * @return Giao diện danh sách liên hệ (admin/contact/show).
     */
    @GetMapping("/admin/contact")
    public String showContactList(Model model) {
        // Lấy danh sách tất cả các liên hệ từ service và gán vào model
        model.addAttribute("contactList", contactService.getAllContacts());
        return "admin/contact/show"; // Trả về giao diện hiển thị danh sách liên hệ
    }

    /**
     * Xem chi tiết một liên hệ cụ thể.
     * @param id ID của liên hệ cần xem.
     * @param model Đối tượng Model để truyền dữ liệu sang view.
     * @return Giao diện chi tiết liên hệ (admin/contact/view).
     */
    @GetMapping("/admin/contact/view/{id}")
    public String viewContactDetail(@PathVariable("id") Long id, Model model) {
        // Truy xuất liên hệ theo ID từ service
        Contact contact = contactService.getContactById(id);

        // Kiểm tra nếu liên hệ không tồn tại
        if (contact == null) {
            model.addAttribute("errorMessage", "Contact not found.");
            return "admin/contact/show"; // Chuyển hướng về danh sách liên hệ
        }

        // Nếu liên hệ tồn tại, truyền nó vào model để hiển thị trên giao diện
        model.addAttribute("contact", contact);
        return "admin/contact/view"; // Trả về giao diện chi tiết liên hệ
    }

    /**
     * Hiển thị trang xác nhận xóa liên hệ.
     * @param id ID của liên hệ cần xóa.
     * @param model Đối tượng Model để truyền dữ liệu sang view.
     * @return Giao diện xác nhận xóa (admin/contact/delete).
     */
    @GetMapping("/admin/contact/confirm-delete/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String confirmDeleteContact(@PathVariable("id") Long id, Model model) {
        // Truy xuất liên hệ theo ID từ service
        Contact contact = contactService.getContactById(id);

        // Kiểm tra nếu liên hệ không tồn tại
        if (contact == null) {
            model.addAttribute("errorMessage", "Contact not found.");
            return "redirect:/admin/contact"; // Chuyển hướng về danh sách liên hệ nếu không tìm thấy
        }

        // Truyền liên hệ vào model để hiển thị trên giao diện xác nhận xóa
        model.addAttribute("contact", contact);
        return "admin/contact/delete"; // Trả về giao diện xác nhận xóa
    }

    /**
     * Xóa một liên hệ khỏi hệ thống.
     * @param id ID của liên hệ cần xóa.
     * @param model Đối tượng Model để truyền dữ liệu sang view.
     * @return Chuyển hướng về danh sách liên hệ sau khi xóa.
     */
    @PostMapping("/admin/contact/delete")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String deleteContact(@RequestParam("id") Long id, Model model) {
        // Gọi service để thực hiện xóa liên hệ theo ID
        boolean isDeleted = contactService.deleteContact(id);

        // Kiểm tra nếu xóa không thành công
        if (!isDeleted) {
            model.addAttribute("errorMessage", "Failed to delete contact.");
            return "redirect:/admin/contact"; // Chuyển hướng về danh sách liên hệ nếu xóa thất bại
        }

        return "redirect:/admin/contact"; // Chuyển hướng về danh sách liên hệ sau khi xóa thành công
    }
}