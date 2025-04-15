package group04.gundamshop.service;

import group04.gundamshop.domain.Contact;
import group04.gundamshop.repository.ContactRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

import java.util.List;


@Service
public class ContactService {

    @Autowired
    private ContactRepository contactRepository;

    public List<Contact> getAllContacts() {
        return contactRepository.findAll();
    }

    public Contact getContactById(Long id) {
        Optional<Contact> contact = contactRepository.findById(id);
        return contact.orElse(null); // Return null if contact not found
    }

    // Phương thức xóa contact theo ID
    public boolean deleteContact(Long id) {
        // Kiểm tra xem contact có tồn tại hay không
        if (contactRepository.existsById(id)) {
            contactRepository.deleteById(id); // Xóa contact
            return true; // Trả về true khi xóa thành công
        }
        return false; // Trả về false nếu không tìm thấy contact
    }


    public void saveContact(Contact contact) {
        // Set status or other properties if needed
        contact.setStatus(true);  // Set the status to true or whatever is appropriate
        contactRepository.save(contact);  // Save contact to the database
    }

}
