<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Admin Profile</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <style>
                    body {
                        margin: 0;
                        padding: 0;
                        display: flex;
                    }

                    .sidebar {
                        width: 250px;
                        min-height: 100vh;
                        background-color: #1a3865;
                    }

                    .main-content {
                        flex: 1;
                        background-color: #f5f5f5;
                        min-height: 100vh;
                        display: flex;
                        flex-direction: column;
                    }

                    .header {
                        background-color: #222;
                        color: white;
                        padding: 10px 10px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .content {
                        padding: 30px 60px;
                        flex-grow: 1;
                    }

                    #avatarPreview {
                        max-height: 250px;
                        display: none;
                        border-radius: 10px;
                    }
                </style>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        const orgImage = "${newUser.avatar}";
                        if (orgImage) {
                            const urlImage = "/images/avatar/" + orgImage;
                            $("#avatarPreview").attr("src", urlImage).show();
                        }

                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL).show();
                        });
                    });
                </script>
            </head>

            <body>
                <!-- Sidebar -->
                <div class="sidebar">
                    <jsp:include page="../layout/navbar.jsp" />
                </div>

                <!-- Main Content -->
                <div class="main-content">
                    <div class="header">
                        <div><strong>Lego Shop</strong></div>
                        <div>Hi, ${newUser.email}</div>
                    </div>
                    <div class="content">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3>Admin Profile</h3>
                            <a href="/admin/changepass" class="btn btn-primary">Change Password</a>
                        </div>

                        <form:form method="post" action="/admin/profile/update" modelAttribute="newUser"
                            enctype="multipart/form-data" class="w-100 d-flex flex-column align-items-center">
                            <div class="mb-3 text-center">
                                <img id="avatarPreview" alt="Avatar Preview"
                                    style="max-height: 250px; display: none; border-radius: 10px;" />
                            </div>
                            <form:input path="id" type="hidden" />
                            <div class="mb-3 w-50">
                                <label class="form-label">Email</label>
                                <form:input path="email" class="form-control" disabled="true" />
                            </div>
                            <div class="mb-3 w-50">
                                <label class="form-label">Phone number</label>
                                <form:input path="phone" type="text" class="form-control" pattern="^0\d{9}$"
                                    title="Phone must start with 0 and have 10 digits" required="true" />
                            </div>
                            <div class="mb-3 w-50">
                                <label class="form-label">Full Name</label>
                                <form:input path="fullName" class="form-control" pattern=".{3,}"
                                    title="At least 3 characters" required="true" />
                            </div>
                            <div class="mb-3 w-50">
                                <label class="form-label">Address</label>
                                <form:input path="address" class="form-control" />
                            </div>
                            <div class="mb-3 w-50">
                                <label class="form-label">Avatar</label>
                                <input type="file" id="avatarFile" class="form-control" name="imagesFile"
                                    accept=".png, .jpg, .jpeg" />
                            </div>
                            <div class="mb-3 w-50 d-grid">
                                <button type="submit" class="btn btn-primary">Save</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </body>

            </html>