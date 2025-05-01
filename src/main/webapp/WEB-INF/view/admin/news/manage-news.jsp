<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage News</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/ewstyle.css">

    <style>
        /* Sliding toggle switch CSS */
        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }
        .timestamp {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }
    </style>
</head>

<body>
<div class="container-fluid d-flex p-0">
    <!-- Sidebar -->
    <jsp:include page="../layout/navbar.jsp" />

    <!-- Main Content -->
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />

        <div class="p-4">
            <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Manage News</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Home Page</a></li>
                <li class="breadcrumb-item active">News</li>
            </ol>
            <div class="mt-5">
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between">
                            <h3>Manage News</h3>
                            <a href="/admin/news/create" class="btn btn-primary">Create News</a>
                        </div>
                        <hr />
                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead>
                            <tr>
                                <th>Title</th>
                                <th>Image</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th>Updated At</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty message}">
                                <tr>
                                    <td colspan="6">
                                        <div class="alert alert-success" role="alert">
                                            ${message}
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="news" items="${newsList}">
                                <tr>
                                    <td>${news.title}</td>
                                    <td>
                                        <img src="${news.imageUrl}" alt="News Image" style="max-width: 100px; max-height: 60px;">
                                    </td>
                                    <td>
                                        <form action="/admin/news/toggle-status/${news.id}" method="get" style="display:inline;">
                                            <label class="switch">
                                                <input type="checkbox" name="status" onchange="this.form.submit()" <c:if test="${news.status}">checked</c:if> />
                                                <span class="slider"></span>
                                            </label>
                                        </form>
                                    </td>
                                    <td><span class="timestamp">${news.createdAtFormatted}</span></td>
                                    <td><span class="timestamp"><c:if test="${not empty news.updatedAtFormatted}">${news.updatedAtFormatted}</c:if></span></td>
                                    <td>
                                        <a href="/admin/news/detail/${news.id}" class="btn btn-success">View</a>
                                        <a href="/admin/news/update/${news.id}" class="btn btn-warning mx-2">Update</a>
                                        <a href="/admin/news/confirm-delete/${news.id}" class="btn btn-danger">Delete</a>
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
