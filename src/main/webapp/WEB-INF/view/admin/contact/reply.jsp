<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Reply to Contact</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container mt-5">
        <h2>Reply to Contact</h2>
        <form:form method="POST" action="/admin/contact/reply">
            <input type="hidden" name="id" value="${contact.id}" />
            <div class="mb-3">
                <label for="subjectName" class="form-label">Subject</label>
                <input type="text" id="subjectName" class="form-control" value="${contact.subjectName}" readonly />
            </div>
            <div class="mb-3">
                <label for="note" class="form-label">Note</label>
                <textarea id="note" class="form-control" rows="4" readonly>${contact.note}</textarea>
            </div>
            <div class="mb-3">
                <label for="replyMessage" class="form-label">Your Reply</label>
                <textarea id="replyMessage" name="replyMessage" class="form-control" rows="5" required>${contact.replyMessage}</textarea>
            </div>
            <button type="submit" class="btn btn-primary">Send Reply</button>
            <a href="/admin/contact" class="btn btn-secondary ms-2">Cancel</a>
        </form:form>
    </div>
</body>

</html>
