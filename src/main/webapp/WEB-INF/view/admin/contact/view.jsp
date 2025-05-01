<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Contact</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icon -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/ewstyle.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border: none;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .profile-photo {
            border: 2px dashed #007bff;
            height: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: #007bff;
            margin-bottom: 20px;
        }
    </style>
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
            <div class="container mt-5">

                <h1 class="mb-4">Details Contact</h1>

                <!-- Contact Information Table -->
                <table class="table table-bordered">
                    <tr>
                        <th>ID</th>
                        <td>${contact.id}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${contact.user.email}</td>
                    </tr>
                    <tr>
                        <th>Full Name</th>
                        <td>${contact.user.fullName}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${contact.user.address}</td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td>${contact.user.phone}</td>
                    </tr>
                    <tr>
                        <th>Subject Name</th>
                        <td>${contact.subjectName}</td>
                    </tr>
                    <tr>
                        <th>Note</th>
                        <td>${contact.note}</td>
                    </tr>
                </table>

                <!-- Back to Contact List -->
                <a href="/admin/contact" class="btn btn-secondary mt-3">Back to list</a>
            </div>
        </div>
    </div>
</body>

</html>
