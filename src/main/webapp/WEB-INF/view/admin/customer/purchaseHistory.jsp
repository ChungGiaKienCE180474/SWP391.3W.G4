<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Purchase History</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                            <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Purchase History for
                                ${customer.present ? customer.get().fullName : 'Customer'}</h1>
                            <div class="p-4">
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/customer">Customers</a></li>
                                    <li class="breadcrumb-item active"><a>Purchase History</a></li>
                                </ol>
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Date</th>
                                            <th>Total Amount</th>
                                            <th>Status</th>
                                            <th>Products</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orders}">
                                            <tr>
                                                <td>${order.id}</td>
                                                <td>${order.convertedOrderDate}</td>
                                                <td>
                                                    <fmt:formatNumber value="${order.totalPrice}" type="number"
                                                        maxFractionDigits="2" />
                                                </td>
                                                <td>${order.status}</td>
                                                <td>
                                                    <ul>
                                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                                            <li>
                                                                ${orderDetail.product.name} -
                                                                <fmt:formatNumber value="${orderDetail.product.price}"
                                                                    type="number" maxFractionDigits="2" /> -
                                                                x${orderDetail.quantity}
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="d-flex justify-content-end mb-3">
                                    <a href="/admin/customer" class="btn btn-success">Back</a>
                                </div>
                            </div>

                            <!-- Bootstrap JS -->
                            <script
                                src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                        </div>
            </body>


            </html>