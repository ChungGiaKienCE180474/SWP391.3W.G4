<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Group 7 - Dự án gundamshop" />
                <meta name="author" content="Group 7" />
                <title>Category Detail</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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

            <body>
                <div class="container-fluid d-flex p-0">
                    <jsp:include page="../layout/navbar.jsp" />
                    <div class="main-content p-0">
                        <jsp:include page="../layout/header.jsp" />
                        <div class="p-4">
                            <h1 class="mt-4">Category Details</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Home Page</a></li>
                                <li class="breadcrumb-item"><a href="/admin/category">Category</a></li>
                                <li class="breadcrumb-item active">View Details</li>
                            </ol>

                            <div class="row justify-content-center">
                                <div class="col-md-8 col-lg-6">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            Category Information
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item">ID: ${newCategory.id}</li>
                                            <li class="list-group-item">Name: ${newCategory.name}</li>
                                        </ul>
                                    </div>
                                    <a href="/admin/category" class="btn btn-success mt-3">Back</a>
                                </div>

                                <div class="col-md-4">
                                    <div class="card p-4">
                                        <h3>Category Image</h3>
                                        <img class="category-image w-100" src="/images/category/${newCategory.image}"
                                            alt="${newCategory.name}'s image" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <footer>
                            <div class="footer-content">
                                <jsp:include page="../layout/footer.jsp" />
                            </div>
                        </footer>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>