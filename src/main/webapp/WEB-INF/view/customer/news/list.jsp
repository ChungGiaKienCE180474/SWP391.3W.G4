<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                .news-container {
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 20px;
                    padding-top: 100px;
                }

                .news-item {
                    display: flex;
                    align-items: center;
                    background-color: white;
                    border-radius: 8px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    margin-bottom: 20px;
                    padding: 15px;
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                    gap: 15px;
                }

                .news-item:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
                }

                .news-item img {
                    width: 120px;
                    height: 120px;
                    border-radius: 8px;
                    object-fit: cover;
                }

                .news-content {
                    display: flex;
                    flex-direction: column;
                    justify-content: center;
                }

                .news-content h2 {
                    font-size: 1.4em;
                    margin: 0;
                }

                .news-content h2 a {
                    text-decoration: none;
                    color: #007bff;
                }

                .news-content .date {
                    font-size: 0.9em;
                    color: #888;
                }

                #chat-icon {
                    position: fixed;
                    bottom: 100px;
                    right: 30px;
                    background-color: #007bff;
                    color: white;
                    width: 50px;
                    height: 50px;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    border-radius: 50%;
                    cursor: pointer;
                    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                    font-size: 24px;
                }
            </style>
        </head>
        <jsp:include page="../layout/header.jsp" />

        <body style="display: flex; flex-direction: column; min-height: 100vh;">
            <div class="news-container" style="flex: 1;">
                <c:forEach var="news" items="${newsList}">
                    <div class="news-item">
                        <img src="${news.imageUrl}" alt="News Image">
                        <div class="news-content">
                            <h2><a href="/news/${news.id}">${news.title}</a></h2>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div id="chat-icon" onclick="redirectToCareService()">
                <i class="fas fa-comment-alt"></i>
            </div>
            <script>
                function redirectToCareService() {
                    window.location.href = "/careservice";
                }
            </script>
        </body>
        <jsp:include page="../layout/footer.jsp" />


        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/client/lib/easing/easing.min.js"></script>
        <script src="/client/lib/waypoints/waypoints.min.js"></script>
        <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
        <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

        <script src="/client/js/main.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>


        <script src="/client/js/main.js"></script>
        <script>
            document.querySelectorAll('.product-desc').forEach(function (desc) {
                const words = desc.textContent.trim().split(/\s+/);
                if (words.length > 4) {
                    desc.textContent = words.slice(0, 4).join(' ') + '...';
                }
            });
        </script>

        </html>