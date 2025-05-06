<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Unrated Orders - Legoshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
          rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
</head>
<body>
<!-- Spinner Start -->
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<!-- Spinner End -->

<!-- Header -->
<jsp:include page="../layout/header.jsp"/>

<!-- Unrated Orders Start -->
<div class="container-fluid py-5 mt-5">
    <div class="container py-5">
        <div class="mb-3">
            <jsp:include page="../layout/nav.jsp"/>
            <h2>Unrated Orders</h2>
        </div>

        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">Product</th>
                    <th scope="col">Name</th>
                    <th scope="col">Price</th>
                    <th scope="col">Quantity</th>
                    <th scope="col">Total Amount</th>
                    <th scope="col">Status</th>
                    <th scope="col">Complete Date</th>
                    <th scope="col">Review Status</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="8" class="text-center">No unrated orders found</ screams>
                    </tr>
                </c:if>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td colspan="2" style="background-color: #f2f2f2;">ORDER NO. ${order.id}</td>
                        <td colspan="1" style="background-color: #f2f2f2;">
                            <fmt:formatNumber type="number" value="${order.totalPrice}"/> đ
                        </td>
                        <td colspan="2" style="background-color: #f2f2f2;"></td>
                        <td colspan="1" style="background-color: #f2f2f2;">
                            ${order.status}
                        </td>
                        <td colspan="1" style="background-color: #f2f2f2;">
                            ${order.convertedCompleteDate}
                        </td>
                        <td style="background-color: #f2f2f2;"></td>
                    </tr>
                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                        <c:if test="${orderDetail.productReview == null}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="/images/product/${orderDetail.product.image}"
                                             class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px;"
                                             alt="${orderDetail.product.name}">
                                    </div>
                                </td>
                                <td>
                                    <a href="/product/${orderDetail.product.id}" target="_blank">
                                        ${orderDetail.product.name}
                                    </a>
                                </td>
                                <td>
                                    <fmt:formatNumber type="number" value="${orderDetail.price}"/> đ
                                </td>
                                <td>
                                    <input type="text" class="form-control form-control-sm text-center border-0"
                                           value="${orderDetail.quantity}" readonly>
                                </td>
                                <td>
                                    <fmt:formatNumber type="number"
                                                      value="${orderDetail.price * orderDetail.quantity}"/> đ
                                </td>
                                <td>${order.status}</td>
                                <td>${order.convertedCompleteDate}</td>
                                <td>
                                    <a href="/customer/product-review/${orderDetail.id}"
                                       class="btn btn-primary">Product Reviews</a>
                                    <p>Status: <span style="color: red;">Not rated yet</span></p>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Unrated Orders End -->

<!-- Footer -->
<jsp:include page="../layout/footer.jsp"/>

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