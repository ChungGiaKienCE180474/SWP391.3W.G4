<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <!-- Custom CSS -->
                <link rel="stylesheet" href="/css/ewstyle.css">
                <title>Delete Employee</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />


            </head>

            <body class="sb-nav-fixed">
                <div class="d-flex">
                    <!-- Sidebar Section -->
                    <div class="sidebar bg-light" style="width: 236px;">
                        <jsp:include page="../layout/navbar.jsp" />
                    </div>


                    <div class="container-fluid">
                        <jsp:include page="../layout/header.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Delete Employee</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item "><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/employee">Employees</a></li>
                                        <li class="breadcrumb-item active">Delete</li>

                                    </ol>
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <div class="d-flex justify-content-between">
                                                    <h3>Delete a Employee with name is = ${fullName}</h3>
                                                </div>

                                                <hr />
                                                <div class="alert alert-danger">
                                                    Are you sure to delete this Employee?
                                                </div>
                                                <form:form method="post" action="/admin/employee/delete"
                                                    modelAttribute="newEmployee">
                                                    <div class="mb-3" style="display: none;">
                                                        <label class="form-label">Id:</label>
                                                        <form:input value="${id}" type="text" class="form-control"
                                                            path="id" />
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
                    <script src="js/scripts.js"></script>
            </body>

            </html>