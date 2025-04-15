<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delete confirm form</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <jsp:include page="../layout/header.jsp" />
        <div class="container">
            <h1 class="mt-4 text-danger">Confirm to delete news</h1>
            <p>Are you sure to delete this news ?</p>
            <h3>${news.title}</h3>
            <img src="${news.imageUrl}" alt="News Image" style="max-width: 200px;">

            <!-- Form xác nhận xóa -->
            <form action="/admin/news/delete/${news.id}" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <button type="submit" class="btn btn-danger mt-3">Confirm</button>
                <a href="/admin/news" class="btn btn-secondary mt-3">Cancel</a>
            </form>
        </div>

    </body>

    </html>