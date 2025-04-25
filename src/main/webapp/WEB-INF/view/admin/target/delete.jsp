<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Target</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="profile-title">Delete Target</h1>
        <c:choose>
            <c:when test="${assigned}">
                <div class="alert alert-warning" role="alert">
                    This Target cannot be deleted because it is assigned.
                </div>
                <a href="${pageContext.request.contextPath}/admin/target" class="btn btn-secondary mt-3">Back to Target List</a>
            </c:when>
            <c:otherwise>
                <p>Do you want to delete this Target?</p>
                <form action="${pageContext.request.contextPath}/admin/target/delete" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="id" value="${id}" />
                    <button type="submit" class="btn btn-danger">Delete</button>
                    <a href="${pageContext.request.contextPath}/admin/target" class="btn btn-secondary ms-3">Cancel</a>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
