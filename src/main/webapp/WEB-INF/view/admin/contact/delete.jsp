<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Delete Contact</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <!-- Custom CSS -->



            </head>

            <body class="sb-nav-fixed">
                <!-- Main Wrapper: Sidebar and Content -->
                <div class="d-flex">
                    <!-- Sidebar Section -->
                    <div class="sidebar bg-light" style="width: 250px;">
                        <jsp:include page="../layout/navbar.jsp" />
                    </div>

                    <!-- Content Section -->
                    <div class="flex-grow-1" id="layoutSidenav_content">
                        <jsp:include page="../layout/header.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Delete Contact</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/contact">Contacts</a></li>
                                        <li class="breadcrumb-item active">Delete</li>
                                    </ol>
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <h3>Delete Contact with ID = ${contact.id}</h3>
                                                <hr />
                                                <div class="alert alert-danger">
                                                    Are you sure you want to delete this contact?
                                                </div>
                                                <!-- Form confirm delete -->
                                                <form action="/admin/contact/delete" method="post"
                                                    onsubmit="return confirm('Are you sure you want to delete this contact?');">
                                                    <!-- CSRF token (if using Spring Security) -->
                                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                                    <input type="hidden" name="id" value="${contact.id}" />
                                                    <button type="submit" class="btn btn-danger">Confirm</button>
                                                    <a href="/admin/contact" class="btn btn-secondary">Cancel</a>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </main>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>