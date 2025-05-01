<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <title>Order Detail</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <link rel="stylesheet" href="/css/ewstyle.css">
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body>
                <div class="container-fluid d-flex p-0">
                    <jsp:include page="../layout/navbar.jsp" />
                    <div class="main-content p-0">
                        <jsp:include page="../layout/header.jsp" />

                        <div class="p-4">
                            <h1 class="mt-4">Order Detail</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="/admin/order">Order</a></li>
                                <li class="breadcrumb-item active">View detail</li>
                            </ol>
                            <div class="mb-5">
                                <h4>Customer Information</h4>
                                <table class="table table-bordered">
                                    <tr>
                                        <th>Full Name</th>
                                        <td>${order.user.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>Email</th>
                                        <td>${order.user.email}</td>
                                    </tr>
                                    <tr>
                                        <th>Phone Number</th>
                                        <td>${order.receiverPhone}</td>
                                    </tr>
                                    <tr>
                                        <th>Address</th>
                                        <td>${order.receiverAddress}</td>
                                    </tr>
                                    <tr>
                                        <th>Note</th>
                                        <td>${order.note}</td>
                                    </tr>
                                    <tr>
                                        <th>Status</th>
                                        <td>${order.status}</td>
                                    </tr>
                                    <tr>
                                        <th>Payment Method</th>
                                        <td>${order.paymentMethod}</td>
                                    </tr>
                                    <tr>
                                        <th>Order Date</th>
                                        <td>${formattedOrderDate}</td>
                                    </tr>
                                </table>
                            </div>
                            <div class="table-responsive">
                                <h4>Order Items</h4>
                                <table class="table table-bordered table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Product</th>
                                            <th>Name</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty order.orderDetails}">
                                            <tr>
                                                <td colspan="5">There are no products in this order.</td>
                                            </tr>
                                        </c:if>

                                        <c:forEach var="od" items="${order.orderDetails}">
                                            <tr>
                                                <td>
                                                    <img src="/images/product/${od.product.image}"
                                                        class="img-fluid rounded-circle"
                                                        style="width: 80px; height: 80px;" alt="">
                                                </td>
                                                <td>
                                                    <a href="/product/${od.product.id}"
                                                        target="_blank">${od.product.name}</a>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${od.price}" type="number" /> đ
                                                </td>
                                                <td>${od.quantity}</td>
                                                <td>
                                                    <fmt:formatNumber value="${od.price * od.quantity}" type="number" />
                                                    đ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex justify-content-end">
                                <a href="/admin/order" class="btn btn-success mt-3">Back</a>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>