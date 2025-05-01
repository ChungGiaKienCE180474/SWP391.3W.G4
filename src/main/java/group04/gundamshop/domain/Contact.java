package group04.gundamshop.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

@Entity
@Table(name = "contact")
public class Contact {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank(message = "Subject Name is required")
    @Pattern(regexp = "^\\p{L}.*", message = "Subject Name must start with a letter")
    private String subjectName;

    @NotBlank(message = "Note is required")
    @Pattern(regexp = "^\\p{L}.*", message = "Note must start with a letter")
    private String note;

    @Column(name = "reply_message")
    private String replyMessage;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "user_id", insertable = false, updatable = false)  // This will be used to map the column
    private Long userId;

    private boolean status;

    @Column(name = "notification_read", nullable = false)
    private boolean notificationRead = false;

    @Column(name = "reply_updated_at")
    private java.time.LocalDateTime replyUpdatedAt;

    @Column(name = "notification_read_at")
    private java.time.LocalDateTime notificationReadAt;

    // Getters and setters for all fields
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getReplyMessage() {
        return replyMessage;
    }

    public void setReplyMessage(String replyMessage) {
        this.replyMessage = replyMessage;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
        this.userId = (user != null) ? user.getId() : null;  // Update the userId when setting the User
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public boolean isNotificationRead() {
        return notificationRead;
    }

    public void setNotificationRead(boolean notificationRead) {
        this.notificationRead = notificationRead;
    }

    public java.time.LocalDateTime getReplyUpdatedAt() {
        return replyUpdatedAt;
    }

    public void setReplyUpdatedAt(java.time.LocalDateTime replyUpdatedAt) {
        this.replyUpdatedAt = replyUpdatedAt;
    }

    public java.time.LocalDateTime getNotificationReadAt() {
        return notificationReadAt;
    }

    public void setNotificationReadAt(java.time.LocalDateTime notificationReadAt) {
        this.notificationReadAt = notificationReadAt;
    }

    @Override
    public String toString() {
        return "Contact [id=" + id
                + ", subjectName=" + subjectName + ", note=" + note + ", replyMessage=" + replyMessage + ", user=" + user + ", status=" + status + ", notificationRead=" + notificationRead + "]";
    }
}
