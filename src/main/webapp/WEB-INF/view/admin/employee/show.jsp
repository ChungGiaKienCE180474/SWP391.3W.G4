<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Quản Lý Nhân Viên</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icon -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
            <!-- Custom CSS -->
            <link rel="stylesheet" href="/css/ewstyle.css">
        </head>

        <body>
            <div class="container-fluid d-flex p-0">
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Main Content -->
                <div class="main-content p-0">
                    <jsp:include page="../layout/header.jsp" />

                    <div class="p-4">
                        <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Employee Management</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                            <li class="breadcrumb-item active">Employee Management</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between">
                                        <h3>Table Employee</h3>
                                        <a href="/admin/employee/create" class="btn btn-primary">Create an Employee</a>
                                    </div>
                                    <hr />
                                    <!-- Hiển thị thông báo thành công hoặc lỗi -->
                                    <c:if test="${not empty message}">
                                        <div class="alert alert-success" role="alert">
                                            ${message}
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger" role="alert">
                                            ${error}
                                        </div>
                                    </c:if>
                                    <table class="table table-bordered table-hover align-middle text-center">
                                        <thead>
                                            <tr>
                                                <th>Email</th>
                                                <th>Full Name</th>
                                                <th>Role</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="employee" items="${employees}">
                                                <tr>
                                                    <td>${employee.email}</td>
                                                    <td>${employee.fullName}</td>
                                                    <td>${employee.role.name}</td>
                                                    <td>
                                                        <span
                                                            class="${employee.status ? 'text-success' : 'text-danger'}">
                                                            ${employee.status ? 'Active' : 'Banned'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <a href="/admin/employee/${employee.id}"
                                                            class="btn btn-success">View</a>
                                                        <a href="/admin/employee/update/${employee.id}"
                                                            class="btn btn-warning mx-2">Update</a>
                                                        <a href="/admin/employee/resend-email/${employee.id}"
                                                            class="btn btn-info" title="Resend Account Email">
                                                            <i class="bi bi-envelope"></i>
                                                        </a>
                                                        <a href="/admin/employee/delete/${employee.id}"
                                                            class="btn btn-danger mx-2">Delete</a>
                                                        <!-- Ban / Unban Form -->
                                                        <form action="/admin/employee/ban/${employee.id}" method="post"
                                                            class="d-inline">
                                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                            <input type="hidden" name="status"
                                                                value="${employee.status ? 'false' : 'true'}" />
                                                            <button type="submit"
                                                                class="btn ${employee.status ? 'btn-danger' : 'btn-warning'} mx-2">
                                                                ${employee.status ? 'Ban' : 'Unban'}
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>