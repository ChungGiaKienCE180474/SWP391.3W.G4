package group04.gundamshop.repository;

import group04.gundamshop.domain.Contact;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContactRepository extends JpaRepository<Contact, Long> {

    List<Contact> findByUserId(Long userId);

    int countByUserIdAndReplyMessageIsNotNullAndNotificationReadFalse(Long userId);

    int countByUserIdAndReplyMessageIsNotNull(Long userId);

    List<Contact> findAllByOrderByIdDesc();
}
