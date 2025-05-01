<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>${news.title} - Legoshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

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
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
        rel="stylesheet">
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <div class="container-fluid py-5 mt-5">
        <div class="container py-5">
            <div class="row g-4 mb-5">
                <div>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">News Details</li>
                        </ol>
                    </nav>
                </div>
                <div class="col-lg-8 col-xl-9">
                    <div class="row g-4">
                        <div class="col-lg-12">
                            <h4 class="fw-bold mb-3">${news.title}</h4>
                            <c:if test="${not empty news.imageUrl}">
                                <img src="${pageContext.request.contextPath}${news.imageUrl}" alt="News Image"
                                    class="img-fluid rounded mb-3" />
                            </c:if>
<div class="news-content mb-3" style="white-space: pre-wrap; word-break: break-word; overflow-wrap: break-word; text-align: justify; font-size: 1.125rem; color: black; text-indent: 0;">
    ${news.content}
</div>
                            <c:if test="${not empty news.referenceLinks}">
                                <div class="mb-3">
                                    <label>Reference Links:</label>
                                    <ul>
                                        <c:forEach var="link" items="${news.referenceLinks}">
                                            <li>
                                                <a href="${link}" target="_blank" rel="noopener noreferrer">
                                                    <c:choose>
                                                        <c:when test="${fn:length(link) > 30}">
                                                            ${fn:substring(link, 0, 30)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${link}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:if>
                            <div class="meta-info text-muted mb-3" style="font-size: 0.875rem;">
                                <%
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd 'at' HH:mm");
                                    LocalDateTime createdAt = (LocalDateTime) pageContext.findAttribute("news").getClass().getMethod("getCreatedAt").invoke(pageContext.findAttribute("news"));
                                    String createdAtFormatted = createdAt.format(formatter);
                                    Object updatedAtObj = pageContext.findAttribute("news").getClass().getMethod("getUpdatedAt").invoke(pageContext.findAttribute("news"));
                                    String updatedAtFormatted = null;
                                    if (updatedAtObj != null) {
                                        updatedAtFormatted = ((LocalDateTime) updatedAtObj).format(formatter);
                                    }
                                %>
                                <div>Created At: <%= createdAtFormatted %></div>
                                <c:if test="${not empty news.updatedAt}">
                                    <div>Updated At: <%= updatedAtFormatted %></div>
                                </c:if>
                            </div>
<a href="${pageContext.request.contextPath}/news" class="btn btn-primary border border-secondary rounded-pill px-4 py-2 mb-4" style="color: black; text-indent: 0;">← Return to News List</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
        <i class="fa fa-arrow-up"></i>
    </a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
</body>

</html>
