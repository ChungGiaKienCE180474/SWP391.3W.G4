<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tin Tức</title>
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

    <meta name="_csrf" content="${_csrf.token}" />
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
        rel="stylesheet">
    <style>
        body {
            padding-top: 100px; /* Điều chỉnh nếu header cao hơn */
        }
        .content-container {
            max-width: 600px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .table {
            text-align: left;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp"/>
    
    <div class="container py-5">
        <div class="content-container">
            <h1 class="my-3 text-succes" style="color :rgb(63, 225, 63);">Payment Successfully</h1>
            <h2 class="my-2 text-center">Order Details</h2>
            <table class="table table-bordered">
                <tbody>
                    <tr>
                        <td><strong>Order Information:</strong></td>
                        <td><c:out value="${orderInfo}" default="[Không có thông tin]"/></td>
                    </tr>
                    <tr>
                        <td><strong>Payment Amount:</strong></td>
                        <td><fmt:formatNumber type="number" value="${amount}" groupingUsed="true"/> VND</td>
                    </tr>
                    <tr>
                        <td><strong>Payment Time:</strong></td>
                        <td><c:out value="${paymentTime}" default="[Không có thời gian]"/></td>
                    </tr>
                    <tr>
                        <td><strong>Transaction Code:</strong></td>
                        <td><c:out value="${transactionId}" default="[Không có mã]"/></td>
                    </tr>
                </tbody>
            </table>
            <a href="/" class="btn btn-primary btn-block">Back Home Page</a>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp"/>
    
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var headerHeight = document.querySelector("header").offsetHeight;
            document.body.style.paddingTop = headerHeight + "px";
        });
    </script>
    
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"></script>
</body>
</html>