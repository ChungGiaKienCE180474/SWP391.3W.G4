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
    <title>Create Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
            });
        });
    </script>
    <style>
        .text-danger {
            font-size: 0.875em;
            color: #dc3545; /* Màu đỏ của Bootstrap */
        }
        input:invalid:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
    </style>
</head>

<body>
    <div class="container-fluid d-flex p-0">
        <jsp:include page="../layout/navbar.jsp" />
        <div class="main-content p-0">
            <jsp:include page="../layout/header.jsp" />
            <div class="p-4">
                <div id="layoutSidenav">
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Dashboard</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/customer">Customers</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Create a customer</h3>
                                            <hr />
                                            <!-- Hiển thị thông báo lỗi chung nếu có -->
                                            <c:if test="${not empty errorMessage}">
                                                <div class="alert alert-danger">${errorMessage}</div>
                                            </c:if>
                                            <form:form method="post" action="/admin/customer/create" 
                                                       modelAttribute="newCustomer" class="row" 
                                                       enctype="multipart/form-data">
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Email:</label>
                                                    <form:input type="email" class="form-control" path="email" 
                                                                required="true" pattern="[a-zA-Z0-9._%+-]+@gmail\.com" 
                                                                oninvalid="this.setCustomValidity('Email must be a valid Gmail address (e.g., example@gmail.com)')" 
                                                                oninput="this.setCustomValidity('')" />
                                                    <form:errors path="email" cssClass="text-danger" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Password:</label>
                                                    <form:input type="password" class="form-control" path="password" 
                                                                required="true" minlength="6" 
                                                                oninvalid="this.setCustomValidity('Password must be at least 6 characters')" 
                                                                oninput="this.setCustomValidity('')" />
                                                    <form:errors path="password" cssClass="text-danger" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Phone number:</label>
                                                    <form:input type="tel" class="form-control" path="phone" 
                                                                required="true" pattern="0[0-9]{9}" 
                                                                oninvalid="this.setCustomValidity('Phone number must start with 0 and have 10 digits')" 
                                                                oninput="this.setCustomValidity('')" />
                                                    <form:errors path="phone" cssClass="text-danger" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Full Name:</label>
                                                    <form:input type="text" class="form-control" path="fullName" 
                                                                required="true" minlength="3" 
                                                                oninvalid="this.setCustomValidity('Full name must be at least 3 characters')" 
                                                                oninput="this.setCustomValidity('')" />
                                                    <form:errors path="fullName" cssClass="text-danger" />
                                                </div>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Address:</label>
                                                    <form:input type="text" class="form-control" path="address" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="avatarFile" class="form-label">Avatar:</label>
                                                    <input class="form-control" type="file" id="avatarFile" 
                                                           accept=".png, .jpg, .jpeg" name="imagesFile" />
                                                </div>
                                                <div class="col-12 mb-3">
                                                    <img style="max-height: 250px; display: none;" 
                                                         alt="avatar preview" id="avatarPreview" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="excelFile" class="form-label">Import Excel:</label>
                                                    <input class="form-control" type="file" id="excelFile" 
                                                           accept=".xls, .xlsx" name="excelFile" />
                                                </div>
                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Create</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" 
            crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>