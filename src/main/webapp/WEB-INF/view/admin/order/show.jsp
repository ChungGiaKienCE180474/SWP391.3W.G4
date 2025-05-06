<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án Legoshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Manager Order</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <link rel="stylesheet" href="/css/ewstyle.css">
            </head>

            <body>

                <div class="container-fluid d-flex p-0">
                    <jsp:include page="../layout/navbar.jsp" />

                    <div class="main-content p-0">
                        <jsp:include page="../layout/header.jsp" />

                        <div class="p-4">
                            <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Order Management</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Order</li>
                            </ol>

                            <div class="filter-bar mb-4">
                                <form method="GET" action="/admin/order" class="d-inline">
                                    <select name="status" style="margin-right: 10px;">
                                        <option value="" <c:if test="${empty param.status}">selected</c:if>>All</option>
                                        <option value="COMPLETE" <c:if test="${param.status == 'COMPLETE'}">selected
                                            </c:if>>Complete</option>
                                        <option value="CONFIRM" <c:if test="${param.status == 'CONFIRM'}">selected
                                            </c:if>>Confirm</option>
                                        <option value="PENDING" <c:if test="${param.status == 'PENDING'}">selected
                                            </c:if>>Pending</option>
                                        <option value="SHIPPING" <c:if test="${param.status == 'SHIPPING'}">selected
                                            </c:if>>Shipping</option>
                                        <option value="CANCEL" <c:if test="${param.status == 'CANCEL'}">selected</c:if>
                                            >Cancel</option>
                                        <option value="BANKING" <c:if test="${param.status == 'BANKING'}">selected
                                            </c:if>>Banking</option>
                                    </select>

                                    <button type="submit" class="btn btn-primary">Filter</button>
                                </form>
                                <a href="/admin/order" class="btn btn-secondary ms-2">All Orders</a>
                            </div>

                            <div class="mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex">
                                            <h3>Table Orders</h3>
                                        </div>

                                        <hr />
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>User</th>
                                                    <th>Date</th>
                                                    <th>Total Price</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <c:if test="${empty param.status || order.status == param.status}">
                                                        <tr>
                                                            <th>${order.id}</th>
                                                            <td>${order.user.fullName}</td>
                                                            <td>${order.convertedOrderDate}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${order.totalPrice}" /> đ
                                                            </td>
                                                            <td>${order.status}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${order.status == 'COMPLETE'}">
                                                                        <a href="/admin/order/${order.id}"
                                                                            class="btn btn-success">View</a>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'CONFIRM'}">
                                                                        <a href="/admin/order/${order.id}"
                                                                            class="btn btn-success">View</a>
                                                                        <a href="/admin/order/update/${order.id}"
                                                                            class="btn btn-warning mx-2">Update</a>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'BANKING'}">
                                                                        <a href="/admin/order/${order.id}"
                                                                            class="btn btn-success">View</a>
                                                                        <a href="/admin/order/update/${order.id}"
                                                                            class="btn btn-warning mx-2">Update</a>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'SHIPPING'}">
                                                                        <a href="/admin/order/${order.id}"
                                                                            class="btn btn-success">View</a>
                                                                        <a href="/admin/order/update/${order.id}"
                                                                            class="btn btn-warning mx-2">Update</a>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'PENDING'}">
                                                                        <a href="/admin/order/${order.id}"
                                                                            class="btn btn-success">View</a>
                                                                        <a href="/admin/order/update/${order.id}"
                                                                            class="btn btn-warning mx-2">Update</a>
                                                                    </c:when>
                                                                    <c:when test="${order.status == 'CANCEL'}">
                                                                        <a href="/admin/order/${order.id}"
                                                                            class="btn btn-success">View</a>
                                                                    </c:when>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

            </body>

            </html>