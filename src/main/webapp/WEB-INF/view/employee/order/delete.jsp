<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án Legoshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Delete Orders</title>
                <link href="/css/styles.css" rel="stylesheet" />

                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
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
                            <h1 class="mt-4">Orders</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/employee">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="/employee/order">Order</a></li>
                                <li class="breadcrumb-item active">Delete</li>
                            </ol>
                            <div class=" mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Delete the order with id = ${id}</h3>
                                        </div>

                                        <hr />
                                        <div class="alert alert-danger">
                                            Are you sure to delete this order ?
                                        </div>
                                        <form:form method="post" action="/employee/order/delete"
                                            modelAttribute="newOrder">
                                            <div class="mb-3" style="display: none;">
                                                <label class="form-label">Id:</label>
                                                <form:input value="${id}" type="text" class="form-control" path="id" />
                                            </div>
                                            <button class="btn btn-danger">Confirm</button>
                                        </form:form>

                                    </div>

                                </div>

                            </div>
                        </div>
                        </main>

                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

            </body>

            </html>