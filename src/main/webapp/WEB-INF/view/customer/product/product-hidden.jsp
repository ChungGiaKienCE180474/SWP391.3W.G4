<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Notification</title>

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">

                    <style>
                        /* Scoped CSS for Main Content */
                        .custom-main-content {
                            display: flex;
                            flex-direction: column;
                            justify-content: center;
                            align-items: center;
                            text-align: center;
                            min-height: calc(100vh - 150px);
                            padding: 20px;
                        }

                        .custom-main-content h1 {
                            font-family: 'Raleway', sans-serif;
                            font-weight: 800;
                            color: #ff5722;
                            margin: 20px auto;
                        }

                        .custom-main-content p {
                            font-family: 'Open Sans', sans-serif;
                            font-size: 16px;
                            color: #666;
                            margin-bottom: 20px;
                        }

                        .custom-main-content a {
                            display: inline-block;
                            padding: 10px 20px;
                            color: white;
                            background-color: #007bff;
                            border-radius: 5px;
                            text-decoration: none;
                            transition: background-color 0.3s ease;
                        }

                        .custom-main-content a:hover {
                            background-color: #0056b3;
                        }

                        /* Scoped CSS for Back to Top Button */
                        .custom-back-to-top {
                            position: fixed;
                            bottom: 20px;
                            right: 20px;
                            width: 50px;
                            height: 50px;
                            background-color: #007bff;
                            border: 2px solid #0056b3;
                            color: white;
                            border-radius: 50%;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            transition: background-color 0.3s ease, transform 0.3s ease;
                        }

                        .custom-back-to-top:hover {
                            background-color: #0056b3;
                            transform: scale(1.1);
                        }
                    </style>
                </head>

                <body>
                    <!-- Header -->
                    <jsp:include page="../layout/header.jsp" />

                    <!-- Main Content -->
                    <div class="custom-main-content">
                        <h1>This product is no longer available</h1>
                        <p>The product you are looking for has been hidden or is no longer available for sale</p>
                        <a href="/products">Back to product list</a>
                    </div>

                    <!-- Footer -->
                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Back to Top Button -->
                    <a href="#" class="custom-back-to-top"><i class="fa fa-arrow-up"></i></a>

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                </body>

                </html>