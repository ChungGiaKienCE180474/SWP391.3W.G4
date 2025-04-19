<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Contact</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <!-- Custom CSS -->
                <link rel="stylesheet" href="/css/ewstyle.css">
            </head>

            <body class="sb-nav-fixed">
                <!-- Main Wrapper: Sidebar and Content -->
                <div class="d-flex">
                    <!-- Sidebar Section -->
                    <div class="sidebar bg-light" style="width: 250px;">
                        <jsp:include page="../layout/navbar.jsp" />
                    </div>

                    <!-- Content Section -->
                    <div class="flex-grow-1" id="layoutSidenav_content">
                        <jsp:include page="../layout/header.jsp" />
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">View Contact</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin/user">Dashboard</a></li>
                                    <li class="breadcrumb-item active">View Contact</li>
                                </ol>

                                <!-- Contact List Table -->
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12">
                                            <h3>List Contact</h3>
                                            <hr />
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">Email</th>
                                                        <th scope="col">Phone Number</th>
                                                        <th scope="col">Subject Name</th>
                                                        <th scope="col">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Populate Contact List -->
                                                    <c:forEach var="contact" items="${contactList}">
                                                        <tr>
                                                            <td>${contact.id}</td>
                                                            <td>${contact.user.email}</td>
                                                            <td>${contact.phoneNumber}</td>
                                                            <td>${contact.subjectName}</td>
                                                            <td>
                                                                <a href="/admin/contact/view/${contact.id}"
                                                                    class="btn btn-info btn-sm">
                                                                    Details
                                                                </a>
                                                                <a href="/admin/contact/confirm-delete/${contact.id}"
                                                                    class="btn btn-danger btn-sm">
                                                                    Delete
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                    <!-- Display if contactList is empty -->
                                                    <c:if test="${empty contactList}">
                                                        <tr>
                                                            <td colspan="5" class="text-center">No contact list found
                                                                here</td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>

                                            <!-- Success and Error Messages -->
                                            <c:if test="${not empty successMessage}">
                                                <div class="alert alert-success" role="alert">
                                                    ${successMessage}
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty errorMessage}">
                                                <div class="alert alert-danger" role="alert">
                                                    ${errorMessage}
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>