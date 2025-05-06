<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Track Shipping - Legoshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet">
    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
    <style>
        .cancel-disabled-btn {
            background-color: #6c757d !important;
            color: white !important;
            pointer-events: none;
            opacity: 0.7;
            cursor: not-allowed;
            border: none;
            padding: 8px 20px;
            border-radius: 10px;
            display: inline-block;
            text-align: center;
            font-weight: bold;
        }
        .alert {
            margin-bottom: 20px;
            padding: 15px;
            border-radius: 5px;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .no-orders {
            text-align: center;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />

    <!-- Order Tracking Start -->
    <div class="container-fluid py-5 mt-5">
        <div class="container py-5">
            <jsp:include page="../layout/nav.jsp" />
            <h2 class="mb-4">Track Shipping</h2>

            <!-- Display error message if present -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <c:out value="${error}" />
                </div>
            </c:if>

            <c:if test="${empty error}">
                <c:if test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="table table-bordered text-center">
                            <thead class="table-light">
                                <tr>
                                    <th>Product</th>
                                    <th>Order Date</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>
                                            <div class="d-flex flex-column align-items-start">
                                                <c:forEach var="orderDetail" items="${order.orderDetails}">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <img src="/images/product/${orderDetail.product.image}"
                                                            class="img-fluid me-2"
                                                            alt="${orderDetail.product.name}"
                                                            style="width: 120px; height: auto;">
                                                        <span>${orderDetail.product.name}</span>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </td>
                                        <td>
                                            ${order.convertedOrderDate}
                                        </td>
                                        <td>
                                            <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                                        </td>
                                        <td>${order.status}</td>
                                        <td>
                                            <c:if test="${order.status == 'PENDING'}">
                                                <a href="/customer/order-delete/${order.id}"
                                                   class="btn btn-danger">Cancel Order</a>
                                            </c:if>
                                            <c:if test="${order.status == 'CONFIRM'}">
                                                <a class="btn btn-secondary disabled cancel-disabled-btn" 
                                                   tabindex="-1" 
                                                   aria-disabled="true">Cancel Order</a>
                                            </c:if>
                                            <c:if test="${order.status == 'SHIPPING'}">
                                                <a class="btn btn-secondary disabled cancel-disabled-btn" 
                                                   tabindex="-1" 
                                                   aria-disabled="true">Cancel Order</a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>

                <c:if test="${empty orders}">
                    <div class="no-orders">
                        <h4>You don't have any orders being tracked.</h4>
                        <p>Once you place an order, you can track its status here.</p>
                    </div>
                </c:if>
            </c:if>
        </div>
    </div>
    <!-- Order Tracking End -->

    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
            class="fa fa-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
</body>

</html>