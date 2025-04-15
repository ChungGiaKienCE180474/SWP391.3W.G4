<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${news.title}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            max-width: 800px;
            margin: auto;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .container {
            background: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            color: #333;
            font-size: 28px;
        }
        .meta {
            color: gray;
            font-size: 14px;
        }
        .news-image {
            width: 100%;
            height: auto;
            border-radius: 5px;
            margin: 10px 0;
        }
        .content {
            text-align: justify;
            font-size: 18px;
            margin: 10px 0;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${news.title}</h1>
    <c:choose>
        <c:when test="${not empty news.imageUrl}">
            <!-- Sử dụng đường dẫn ảnh từ imageUrl -->
            <img src="${pageContext.request.contextPath}${news.imageUrl}" alt="News Image" class="news-image">
        </c:when>
        <c:otherwise>
            <p>No image available</p>
        </c:otherwise>
    </c:choose>
    <p class="content">${news.content}</p>
    <a href="/news" class="back-link">&#8592; Return news list</a>
</div>
</body>
</html>