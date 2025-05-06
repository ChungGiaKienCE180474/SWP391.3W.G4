<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Checkout Wishlist - Legoshop</title>
                <link rel="stylesheet" href="/client/css/bootstrap.min.css">
                <link rel="stylesheet" href="/client/css/style.css">
            </head>

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
            </head>

            <body>

                <jsp:include page="../layout/header.jsp" />

                <div class="container py-5">
                    <h2 class="mb-4">Checkout Wishlist</h2>

                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Product</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty wishlist}">
                                        <tr>
                                            <td colspan="5" class="text-center">Your wishlist is empty.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="totalPrice" value="0" />
                                        <c:forEach var="product" items="${wishlist}">
                                            <c:set var="itemTotal" value="${product.price * 1}" />
                                            <c:set var="totalPrice" value="${totalPrice + itemTotal}" />
                                            <tr>
                                                <td>
                                                    <img src="/images/product/${product.image}"
                                                        class="img-fluid rounded" style="width: 80px; height: 80px;"
                                                        alt="Product Image">
                                                </td>
                                                <td>${product.name}</td>
                                                <td>
                                                    <fmt:formatNumber type="number" value="${product.price}" /> đ
                                                </td>
                                                <td>1</td>
                                                <td>
                                                    <fmt:formatNumber type="number" value="${itemTotal}" /> đ
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${not empty wishlist}">
                        <div class="bg-light rounded p-4">
                            <h4 class="mb-4">Order Summary</h4>
                            <div class="d-flex justify-content-between mb-3">
                                <h5>Subtotal:</h5>
                                <p>
                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                </p>
                            </div>
                            <div class="border-top py-3 d-flex justify-content-between">
                                <h5>Total:</h5>
                                <p>
                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                </p>
                            </div>

                            <form action="/wishlist/checkout" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <c:forEach var="product" items="${wishlist}">
                                    <input type="hidden" name="productIds" value="${product.id}" />
                                    <input type="hidden" name="quantities" value="1" />
                                </c:forEach>
                                <button type="submit" class="btn btn-primary w-100">Proceed to Checkout</button>
                            </form>
                        </div>
                    </c:if>
                </div>
                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <!-- <jsp:include page="../layout/footer.jsp" /> -->

                <script src="/client/js/main.js"></script>
            </body>

            </html>