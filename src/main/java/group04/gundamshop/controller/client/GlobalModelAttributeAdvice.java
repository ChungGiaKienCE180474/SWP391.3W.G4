package group04.gundamshop.controller.client;

import group04.gundamshop.service.ContactService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalModelAttributeAdvice {

    @Autowired
    private ContactService contactService;

    @ModelAttribute("replyNotificationCount")
    public int getReplyNotificationCount(HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        if (userId == null) {
            return 0;
        }
        return contactService.countContactsWithRepliesByUserId(userId);
    }
}
