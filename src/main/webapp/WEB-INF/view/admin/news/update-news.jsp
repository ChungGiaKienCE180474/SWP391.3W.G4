<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Update News</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .timestamp {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }
        .reference-links .form-control {
            margin-bottom: 0.5rem;
        }
        .add-link-btn {
            cursor: pointer;
            font-size: 1.5rem;
            color: #0d6efd;
            user-select: none;
        }
    </style>
</head>
<body>
<div class="container my-4">
    <h1 class="mb-3">Update News</h1>
    <form id="newsForm" action="${pageContext.request.contextPath}/admin/news/update/${news.id}" method="post" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${news.title}" required />
            <c:if test="${not empty titleError}">
                <div class="text-danger">${titleError}</div>
            </c:if>
        </div>
        <div class="mb-3">
            <label for="content" class="form-label">Content</label>
            <textarea class="form-control" id="content" name="content" rows="6" required>${news.content}</textarea>
            <c:if test="${not empty contentError}">
                <div class="text-danger">${contentError}</div>
            </c:if>
        </div>
        <div class="mb-3">
            <label for="image" class="form-label">Current Image</label>
            <c:if test="${not empty news.imageUrl}">
                <div>
                    <img src="${pageContext.request.contextPath}${news.imageUrl}" alt="News Image" class="img-thumbnail" style="max-width: 300px;" />
                </div>
            </c:if>
            <label for="image" class="form-label mt-2">Upload New Image (Optional)</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*" />
        </div>
        <div class="mb-3">
            <label>Created At:</label>
            <p class="timestamp">${news.createdAt}</p>
        </div>
        <c:if test="${not empty news.updatedAt}">
            <div class="mb-3">
                <label>Updated At:</label>
                <p class="timestamp">${news.updatedAt}</p>
            </div>
        </c:if>
        <div class="mb-3">
            <label>Nguồn tham khảo:</label>
            <div id="referenceLinks" class="reference-links">
                <c:forEach var="link" items="${news.referenceLinks}">
                    <div class="input-group mb-2">
                        <input type="url" name="referenceLinks" class="form-control" value="${link}" placeholder="Nhập URL tham khảo" required />
                        <button type="button" class="btn btn-outline-danger" onclick="removeReferenceLink(this)">Xóa</button>
                    </div>
                </c:forEach>
            </div>
            <!-- Removed requirement to keep at least one reference link -->
            <small class="form-text text-muted">Bạn có thể thêm hoặc xóa nguồn tham khảo tùy ý.</small>
            <span class="add-link-btn" style="cursor:pointer; color:#0d6efd; font-size:1.5rem; user-select:none;" onclick="addReferenceLink()">&#43; Thêm link</span>
        </div>
        <div class="mb-3">
            <button type="submit" class="btn btn-warning">Update</button>
            <a href="${pageContext.request.contextPath}/admin/news" class="btn btn-secondary ms-2">Cancel</a>
        </div>
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
            input.required = false;
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
            const container = document.getElementById('referenceLinks');
            const div = button.parentNode;
            div.parentNode.removeChild(div);
        }
</script>
</body>
</html>
