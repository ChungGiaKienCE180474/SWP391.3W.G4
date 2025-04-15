<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="news" items="${newsList}">
                                <tr>
                                    <td>${news.title}</td>
                                    <td>

                                        <img src="${news.imageUrl}" alt="News Image" style="max-width: 100px; max-height: 60px;">
                                    </td>
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