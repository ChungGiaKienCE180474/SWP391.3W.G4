<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Voucher</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

            <div class="container mt-5">
                <h2 class="text-center mt-5 mb-4" style="padding-top: 20px;">Voucher List</h2>

                <!-- Hiển thị thông báo nếu không có voucher nào -->
                <c:if test="${empty vouchers}">
                    <p class="text-center text-danger fw-bold">There are currently no vouchers available!</p>
                </c:if>

                <div class="row">
                    <c:forEach var="voucher" items="${vouchers}">
                        <div class="col-md-4 d-flex align-items-sm-stretch">
                            <div class="card p-3 mb-3 w-100">
                                <h5 class="text-primary">${voucher.code} - ${voucher.title}</h5>
                                <p>${voucher.description}</p>
                                <p><strong>Discount: </strong>${voucher.discount}%</p>
                                <p><strong>Quantity: </strong>${voucher.quantity}</p>
                                <!-- Chuyển hướng đến checkout kèm theo mã giảm giá -->
                                <a href="/checkout?voucherCode=${voucher.code}"
                                    class="btn btn-primary collect-btn mt-auto">
                                    Use Now
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <a href="/" class="btn btn-primary mt-3">Home Page</a>
            </div>

        </body>

        </html>