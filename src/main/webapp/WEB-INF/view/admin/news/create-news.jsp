<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create News</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1 class="mt-4">Create News</h1>
    <form action="/admin/news/create" method="post" enctype="multipart/form-data">
        <!-- Thêm CSRF token -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${news.title}" required>
            <c:if test="${not empty titleError}">
                <div class="text-danger">${titleError}</div>
            </c:if>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">Content</label>
            <textarea class="form-control" id="content" name="content" rows="4" required>${news.content}</textarea>
            <c:if test="${not empty contentError}">
                <div class="text-danger">${contentError}</div>
            </c:if>
        </div>
        <div class="mb-3">
            <label for="image" class="form-label">Image</label>
            <input type="file" class="form-control" id="image" name="image_url" accept="image/*">
        </div>
        <div class="mb-3">
            <label>Nguồn tham khảo:</label>
            <div id="referenceLinks" class="reference-links">
                <div class="input-group mb-2">
                    <input type="url" name="referenceLinks" class="form-control" placeholder="Nhập URL tham khảo" />
                    <button type="button" class="btn btn-outline-danger" onclick="removeReferenceLink(this)">Xóa</button>
                </div>
            </div>
            <span class="add-link-btn" style="cursor:pointer; color:#0d6efd; font-size:1.5rem; user-select:none;" onclick="addReferenceLink()">&#43; Thêm link</span>
        </div>
        <button type="submit" class="btn btn-primary">Create</button>
        <a href="/admin/news" class="btn btn-secondary">Cancel</a>
</form>
</div>

<script>
    function addReferenceLink() {
        const container = document.getElementById('referenceLinks');
        const div = document.createElement('div');
        div.className = 'input-group mb-2';
        const input = document.createElement('input');
        input.type = 'url';
        input.name = 'referenceLinks';
        input.className = 'form-control';
        input.placeholder = 'Nhập URL tham khảo';
        const button = document.createElement('button');
        button.type = 'button';
        button.className = 'btn btn-outline-danger';
        button.textContent = 'Xóa';
        button.onclick = function() {
            container.removeChild(div);
        };
        div.appendChild(input);
        div.appendChild(button);
        container.appendChild(div);
    }

    function removeReferenceLink(button) {
        const div = button.parentNode;
        div.parentNode.removeChild(div);
    }
</script>
</body>
</html>
