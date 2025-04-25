<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Factory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>

<body>
    <div class="container-fluid d-flex p-0">
        <jsp:include page="../layout/navbar.jsp" />
        <div class="main-content p-0">
            <jsp:include page="../layout/header.jsp" />
            <div class="p-4">
                <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Factory Management</h1>
            <div class="d-flex justify-content-between mb-3">
                <a href="/admin/factory/create" class="btn btn-primary">Create New Factory</a>
            </div>
            <c:if test="${not empty message}">
                <div class="alert alert-success" role="alert">${message}</div>
            </c:if>
            <table class="table table-bordered table-hover align-middle text-center">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="factory" items="${factories}">
                        <tr>
                            <td>${factory.id}</td>
                            <td>${factory.name}</td>
                            <td>
                                <a href="/admin/factory/update/${factory.id}" class="btn btn-warning">Edit</a>
                                <a href="/admin/factory/delete/${factory.id}" class="btn btn-danger ms-2">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
