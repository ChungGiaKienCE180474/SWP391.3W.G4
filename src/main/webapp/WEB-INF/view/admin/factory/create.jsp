<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Factory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="profile-title">Create Factory</h1>
        <form:form action="${pageContext.request.contextPath}/admin/factory/create" method="post" modelAttribute="newFactory" cssClass="mt-4">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <div class="mb-3">
                <form:label path="name" cssClass="form-label">Name:</form:label>
                <form:input path="name" cssClass="form-control" />
                <form:errors path="name" cssClass="text-danger" />
            </div>
            <button type="submit" class="btn btn-save">Create</button>
            <a href="${pageContext.request.contextPath}/admin/factory" class="btn btn-secondary ms-3">Back to Factory List</a>
        </form:form>
    </div>
</body>
</html>
