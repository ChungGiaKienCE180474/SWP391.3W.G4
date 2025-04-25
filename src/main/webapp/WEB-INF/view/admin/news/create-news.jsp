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
        <button type="submit" class="btn btn-primary">Create</button>
        <a href="/admin/news" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
