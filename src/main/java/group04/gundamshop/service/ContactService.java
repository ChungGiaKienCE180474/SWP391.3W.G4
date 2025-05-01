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
        return contactRepository.findAllByOrderByIdDesc();
    }

    public Contact getContactById(Long id) {
        Optional<Contact> contact = contactRepository.findById(id);
        return contact.orElse(null);
    }

    public boolean deleteContact(Long id) {
        if (contactRepository.existsById(id)) {
            contactRepository.deleteById(id);
            return true;
        }
        return false;
    }

    public void saveContact(Contact contact) {
        contact.setStatus(true);
        contactRepository.save(contact);
    }

    public List<Contact> getContactsByUserId(Long userId) {
        return contactRepository.findByUserId(userId);
    }

    // Count contacts where replyUpdatedAt is after notificationReadAt or notificationReadAt is null
    public int countContactsWithRepliesByUserId(Long userId) {
        List<Contact> contacts = contactRepository.findByUserId(userId);
        int count = 0;
        for (Contact contact : contacts) {
            if (contact.getReplyMessage() != null) {
                if (contact.getNotificationReadAt() == null || 
                    (contact.getReplyUpdatedAt() != null && contact.getReplyUpdatedAt().isAfter(contact.getNotificationReadAt()))) {
                    count++;
                }
            }
        }
        return count;
    }

    // Mark notifications as read by setting notificationReadAt to now
    public void clearReplyNotificationsByUserId(Long userId) {
        List<Contact> contacts = contactRepository.findByUserId(userId);
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        for (Contact contact : contacts) {
            if (contact.getReplyMessage() != null) {
                contact.setNotificationReadAt(now);
                contactRepository.save(contact);
            }
        }
    }

    // Update replyUpdatedAt and reset notificationReadAt when admin replies or edits
    public void updateReplyNotification(Contact contact) {
        contact.setReplyUpdatedAt(java.time.LocalDateTime.now());
        contact.setNotificationReadAt(null);
        contactRepository.save(contact);
    }
}
