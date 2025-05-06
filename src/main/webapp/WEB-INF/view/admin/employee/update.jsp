<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Group 4 - Dự án Legoshop" />
                <meta name="author" content="Group 4" />
                <title>Update Employee</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <!-- Custom CSS -->
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        const orgImage = "${newEmployee.avatar}";
                        console.log("Original Image: ", orgImage);
                        if (orgImage) {
                            const urlImage = "/images/avatar/" + orgImage;
                            $("#avatarPreview").attr("src", urlImage);
                            $("#avatarPreview").css({ "display": "block" });
                        }

                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>

            </head>

            <body class="sb-nav-fixed">
                <div id="layoutSidenav">
                    <div class="d-flex">
                        <!-- Sidebar Section -->
                        <div class="sidebar bg-light" style="min-height:100vh; display: flex;">
                            <jsp:include page="../layout/navbar.jsp" />
                        </div>

                        <div id="layoutSidenav">
                            <div class="main-content p-0">
                                <jsp:include page="../layout/header.jsp" />
                                <div id="layoutSidenav_content">
                                    <main>
                                        <div class="container-fluid px-4">
                                            <h1 class="mt-4">Dashboard</h1>
                                            <ol class="breadcrumb mb-4">
                                                <li class="breadcrumb-item "><a href="/admin">Dashboard</a></li>
                                                <li class="breadcrumb-item"><a href="/admin/employee">Employees</a></li>
                                                <li class="breadcrumb-item active">Update</li>
                                            </ol>
                                            <div class="mt-5">
                                                <div class="row">
                                                    <div class="col-md-6 col-12 mx-auto">
                                                        <h3>Update a Employee</h3>
                                                        <hr />
                                                        <form:form method="post" action="/admin/employee/update"
                                                            modelAttribute="newEmployee" class="row"
                                                            enctype="multipart/form-data">
                                                            <div class="mb-3" style="display: none;">
                                                                <label class="form-label">Id:</label>
                                                                <form:input type="text" class="form-control"
                                                                    path="id" />
                                                            </div>
                                                            <div class="mb-3 col-12 col-md-6">
                                                                <c:set var="errorEmail">
                                                                    <form:errors path="email"
                                                                        cssClass="invalid-feedback" />
                                                                </c:set>

                                                                <label class="form-label">Email:</label>
                                                                <form:input type="email"
                                                                    class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                                    path="email" disabled="true" />
                                                                ${errorEmail}
                                                            </div>

                                                            <div class="mb-3 col-12 col-md-6">
                                                                <label class="form-label">Phone number:</label>
                                                                <form:input type="text" class="form-control"
                                                                    path="phone" pattern="^0\d{9}$"
                                                                    title="Phone number must start with 0 and have 10 numbers"
                                                                    required="true" />
                                                            </div>
                                                            <div class="mb-3 col-12 col-md-6">
                                                                <c:set var="errorFullName">
                                                                    <form:errors path="fullName"
                                                                        cssClass="invalid-feedback" />
                                                                </c:set>
                                                                <label class="form-label">Full Name:</label>
                                                                <form:input type="text"
                                                                    class="form-control ${not empty errorFullName? 'is-invalid':''}"
                                                                    path="fullName" minlength="4"
                                                                    title="Full name must be at least 4 characters"
                                                                    required="true" />
                                                                ${errorFullName}
                                                            </div>
                                                            <div class="mb-3 col-12">
                                                                <label class="form-label">Address:</label>
                                                                <form:input type="text" class="form-control"
                                                                    path="address" />
                                                            </div>

                                                            <div class="mb-3 col-12 col-md-6">
                                                                <label for="avatarFile"
                                                                    class="form-label">Avatar:</label>
                                                                <input class="form-control" type="file" id="avatarFile"
                                                                    accept=".png, .jpg, .jpeg" name="imagesFile" />
                                                            </div>
                                                            <div class="col-12 mb-3">
                                                                <img style="max-height: 250px; display: none;"
                                                                    alt="avatar preview" id="avatarPreview" />
                                                            </div>
                                                            <div class="col-12 mb-5">
                                                                <button type="submit"
                                                                    class="btn btn-primary">Save</button>
                                                            </div>

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