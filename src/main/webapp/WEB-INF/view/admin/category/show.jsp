<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Category</title>
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
                        <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Manage Category</h1>
                        <c:if test="${not empty flash.successMessage}">
                            <div class="alert alert-success" role="alert">${flash.successMessage}</div>
                        </c:if>
                        <c:if test="${not empty flash.errorMessage}">
                            <div class="alert alert-danger" role="alert">${flash.errorMessage}</div>
                        </c:if>
                        <c:if test="${not empty param.successMessage}">
                            <div class="alert alert-success" role="alert">${param.successMessage}</div>
                        </c:if>
                        <c:if test="${not empty param.errorMessage}">
                            <div class="alert alert-danger" role="alert">${param.errorMessage}</div>
                        </c:if>
                        <table class="table table-bordered table-hover align-middle text-center">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Home Page</a></li>
                                <li class="breadcrumb-item active">Category</li>
                            </ol>
                            <div class="mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Manage Category</h3>
                                            <a href="/admin/category/create" class="btn btn-primary">Create Category</a>
                                        </div>

                                        <hr />
                                        <table class=" table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Name</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="category" items="${categories}">

                                                    <tr>
                                                        <td>${category.name}</td>
                                                        <td>
                                                            <a href="/admin/category/${category.id}"
                                                                class="btn btn-success">View</a>
                                                            <a href="/admin/category/update/${category.id}"
                                                                class="btn btn-warning  mx-2">Edit</a>
                                                            <a href="/admin/category/delete/${category.id}"
                                                                class="btn btn-danger">Delete</a>
                                                        </td>
                                                    </tr>

                                                </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>

                                </div>

                            </div>
                        </table>
                    </div>
                </div>
            </div>



            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        </body>

        </html>