<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Group 4 - Dự án gundamshop" />
                <meta name="author" content="Group 4" />
                <title>Update Categories</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <!-- Custom CSS -->
                <link rel="stylesheet" href="/css/ewstyle.css">
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#imageFile");
                        const orgImage = "${newCategory.image}";
                        console.log("Original Image: ", orgImage);
                        if (orgImage) {
                            const urlImage = "/images/category/" + orgImage;
                            $("#imagePreview").attr("src", urlImage);
                            $("#imagePreview").css({ "display": "block" });
                        }

                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#imagePreview").attr("src", imgURL);
                            $("#imagePreview").css({ "display": "block" });
                        });
                    });
                </script>
            </head>

            <body>
                <div class="container-fluid d-flex p-0">
                    <!-- Sidebar -->
                    <jsp:include page="../layout/navbar.jsp" />

                    <!-- Main Content -->
                    <div class="main-content p-0">
                        <div class="p-4">


                            <!-- Breadcrumb -->
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Home Page</a></li>
                                <li class="breadcrumb-item"><a href="/admin/category">Category</a></li>
                                <li class="breadcrumb-item active">Edit</li>
                            </ol>

                            <div class="container-fluid px-4">
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Edit Category</h3>
                                            <hr />
                                            <c:if test="${not empty flash.successMessage}">
                                                <div class="alert alert-success" role="alert">${flash.successMessage}</div>
                                            </c:if>
                                            <c:if test="${not empty flash.errorMessage}">
                                                <div class="alert alert-danger" role="alert">${flash.errorMessage}</div>
                                            </c:if>
                                            <form:form method="post" action="/admin/category/update"
                                                modelAttribute="newCategory" class="row" enctype="multipart/form-data">
                                                <form:input type="hidden" class="form-control" path="id" />
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Category Name:</label>
                                                    <form:input type="text" class="form-control" path="name" />
                                                    <form:errors path="name" cssClass="text-danger" />
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="imageFile" class="form-label">Image:</label>
                                                    <input class="form-control" type="file" id="imageFile"
                                                        accept=".png, .jpg, .jpeg" name="imageFile" />
                                                    <form:errors path="image" cssClass="text-danger" />
                                                </div>

                                                <div class="col-12 mb-3">
                                                    <img style="max-height: 250px; display: none;" alt="image preview"
                                                        id="imagePreview" />
                                                </div>

                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Edit</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS and custom scripts -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
            </body>

            </html>