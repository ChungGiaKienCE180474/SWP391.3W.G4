<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>

<body>
    <div class="container-fluid d-flex p-0">
        <jsp:include page="../layout/navbar.jsp" />
        <div class="main-content p-0">
            <jsp:include page="../layout/header.jsp" />
            <div class="p-4">
                <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Product Management</h1>
            <div class="search-bar mb-4">
                <form method="GET" action="/employee/product/search" class="d-flex align-items-center">
                    <input type="text" name="keyword" placeholder="Search by name or category" class="form-control me-2" value="${keyword}">
                    <button type="submit" class="btn btn-primary">Search</button>
                    <c:if test="${not empty keyword}">
                        <a href="/employee/product" class="btn btn-secondary btn-sm ms-2">Back to List</a>
                    </c:if>
                </form>
            </div>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <table class="table table-bordered table-hover align-middle text-center">
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/employee">Dashboard</a></li>
                    <li class="breadcrumb-item active">Products</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Table Product</h3>
                                <a href="/employee/product/create" class="btn btn-primary">Create a Product</a>
                            </div>
                            <hr />
                            <c:choose>
                                <c:when test="${productPage.totalElements == 0}">
                                    <div class="alert alert-warning text-center" role="alert">
                                        No products found.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Price</th>
                                                <th>Brand</th>
                                                <th>Classify</th>
                                                <th>Category</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${productPage.content}">
                                                <tr>
                                                    <td>${product.name}</td>
                                                    <td><fmt:formatNumber type="number" value="${product.price}" />đ</td>
                                                    <td>${product.factory.name}</td>
                                                    <td>${product.target.name}</td>
                                                    <td>${product.category.name}</td>
                                                    <td>
                                                        <div class="btn-group" role="group" aria-label="Action Buttons">
                                                            <a href="/employee/product/${product.id}" class="btn btn-success btn-sm">View</a>
                                                            <a href="/employee/product/update/${product.id}" class="btn btn-warning btn-sm mx-1">Update</a>
                                                            <a href="/employee/product/delete/${product.id}" class="btn btn-danger btn-sm">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        </table>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${productPage.totalElements > 0}">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination justify-content-center">
                                            <c:if test="${currentPage > 0}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?keyword=${keyword}&page=${currentPage - 1}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                            <c:forEach var="i" begin="0" end="${totalPages - 1}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="?keyword=${keyword}&page=${i}">${i + 1}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${currentPage < totalPages - 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="?keyword=${keyword}&page=${currentPage + 1}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </c:if>
                        </div>
                    </div>
                </div>
            </table>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
