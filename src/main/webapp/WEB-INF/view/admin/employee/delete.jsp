<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <title>Xóa Nhân Viên</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
            <link rel="stylesheet" href="/css/ewstyle.css">
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
                                <h1 class="mt-4">Xóa Nhân Viên</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/employee">Nhân Viên</a></li>
                                    <li class="breadcrumb-item active">Xóa</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="d-flex justify-content-between">
                                                <h3>Xóa nhân viên với email: ${email}</h3>
                                            </div>
                                            <hr />
                                            <div class="alert alert-danger">
                                                Bạn có chắc chắn muốn xóa nhân viên này không?
                                            </div>
                                            <form method="post" action="/admin/employee/delete">
                                                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                <input type="hidden" name="id" value="${id}" />
                                                <button type="submit" class="btn btn-danger">Xác nhận</button>
                                                <a href="/admin/employee" class="btn btn-secondary">Hủy</a>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>
        ```