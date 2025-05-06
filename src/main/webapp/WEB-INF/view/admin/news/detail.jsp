<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Group 4 - Dự án Legoshop" />
    <meta name="author" content="Group 4" />
    <title>News Details</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border: none;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .profile-photo {
            border: 2px dashed #007bff;
            height: 200px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 24px;
            color: #007bff;
            margin-bottom: 20px;
        }
    </style>
</head>

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">News Detail</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="/admin/news">News Management</a></li>
                    <li class="breadcrumb-item active">View Detail</li>
                </ol>

                <div class="row justify-content-center">
                    <div class="row">
                        <div class="card mb-4">


                            <div class="row">
                                <div class="card p-4">
                                    <h3>New Images</h3>
                                    <img class="card-img-top" src="${news.imageUrl}"
                                         alt="${news.title}'s image" />

                                </div>
                            </div>
                            <div class="card-header">
                                News Information
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">News Title: ${news.title}</li>
                                <li class="list-group-item">Content: ${news.content}</li>
                                <c:if test="${not empty news.referenceLinks}">
                                    <li class="list-group-item">
                                        Reference Links:
                                        <ul>
                                            <c:forEach var="link" items="${news.referenceLinks}">
                                                <li>
                                                    <a href="${link}" target="_blank">
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
                                    </li>
                                </c:if>
                            </ul>
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
                            <div class="list-group-item">Created At: <%= createdAtFormatted %></div>
                            <c:if test="${not empty news.updatedAt}">
                                <div class="list-group-item">Updated At: <%= updatedAtFormatted %></div>
                            </c:if>
                            <a href="/admin/news"
                               class="btn btn-success mt-3 justify-content-center col-4">Back to News Management</a>
                        </div>

                    </div>


                </div>
            </div>
        </main>
       
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>

</html>