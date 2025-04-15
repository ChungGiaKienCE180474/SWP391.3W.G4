<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Manage Feedback</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                            <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Manage Feedback for User ID:
                                ${userId}</h1>
                            <div class="p-4">
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/customer">Customers</a></li>
                                    <li class="breadcrumb-item active"></a>Feedback</li>
                                </ol>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Product ID</th>
                                            <th>Product Name</th>
                                            <th>Rating</th>
                                            <th>Feedback Content</th>
                                            <th>Visible</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="feedback" items="${feedbackList}">
                                            <tr>
                                                <td>${feedback.product.id}</td>
                                                <td>${feedback.product.name}</td>
                                                <td>${feedback.rating}</td>
                                                <td>${feedback.reviewContent}</td>
                                                <td>${feedback.visible}</td>
                                                <td>
                                                    <form:form action="/admin/customer/feedback/${feedback.id}"
                                                        method="post">
                                                        <input type="hidden" name="visible"
                                                            value="${feedback.visible == 'Yes' ? 'No' : 'Yes'}" />
                                                        <button type="submit"
                                                            class="btn ${feedback.visible == 'Yes' ? 'btn-danger' : 'btn-success'}">
                                                            ${feedback.visible == 'Yes' ? 'Hide' : 'Show'}
                                                        </button>
                                                    </form:form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="d-flex justify-content-end mb-3">
                                    <a href="/admin/customer" class="btn btn-success">Back</a>
                                </div>

                                <!-- Status Message -->
                                <c:if test="${not empty message}">
                                    <div class="alert alert-info">${message}</div>
                                </c:if>
                            </div>

                            <!-- Bootstrap JS -->
                            <script
                                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>