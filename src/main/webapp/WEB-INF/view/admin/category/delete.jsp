<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
    <meta name="author" content="Hỏi Dân IT" />
    <title>Delete Category</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icon -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="/css/ewstyle.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body>
    <div class="container-fluid d-flex p-0">
        <!-- Sidebar -->
        <jsp:include page="../layout/navbar.jsp" />

        <!-- Main Content -->
        <div class="main-content p-0">
            <div class="p-4">
                <!-- Breadcrumb -->
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Home Page</a></li>
                    <li class="breadcrumb-item"><a href="/admin/category">Category</a></li>
                    <li class="breadcrumb-item active">Delete</li>
                </ol>

                <div class="container-fluid px-4">
                    <div class="mt-5">
                        <div class="row">
                            <div class="col-12 mx-auto">
                                <div class="d-flex justify-content-between">
                                    <h3>Delete Category name = ${name}</h3>
                                </div>
                                <hr />

                                <c:if test="${not empty flash.successMessage}">
                                    <div class="alert alert-success" role="alert">${flash.successMessage}</div>
                                </c:if>

                                <c:choose>
                                    <c:when test="${assigned}">
                                        <div class="alert alert-warning" role="alert">
                                            This category cannot be deleted because it has assigned products.
                                        </div>
                                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary mt-3">Back to Category List</a>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-danger">
                                            Are you sure you want to delete this Category?
                                        </div>
                                        <form:form method="post" action="/admin/category/delete" modelAttribute="newCategory">
                                            <div class="mb-3" style="display: none;">
                                                <label class="form-label">Id:</label>
                                                <form:input value="${id}" type="text" class="form-control" path="id" />
                                            </div>
                                            <button class="btn btn-danger">Confirm</button>
                                            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary ms-3">Cancel</a>
                                        </form:form>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS and custom scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
</body>

</html>
