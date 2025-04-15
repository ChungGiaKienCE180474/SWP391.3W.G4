<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Gruop 7 - Dự án gundamshop" />
                <meta name="author" content="Gruop 7" />
                <title>Create Product</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#productFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#productPreview").attr("src", imgURL);
                            $("#productPreview").css({ "display": "block" });
                        });
                    });
                </script>
            </head>

            <body class="sb-nav-fixed">
                <div id="layoutSidenav">
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Dashboard</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/employee/product">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/employee/product">Products</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Create a Product</h3>
                                            <hr />
                                            <!-- Hiển thị thông báo lỗi chung nếu có -->
                                            <c:if test="${not empty error}">
                                                <div class="alert alert-danger">${error}</div>
                                            </c:if>
                                            <form:form method="post" action="/admin/product/create" class="row"
                                                enctype="multipart/form-data" modelAttribute="newProduct">
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Name:</label>
                                                    <form:input type="text" class="form-control" path="name"
                                                        required="true" minlength="4"
                                                        oninvalid="this.setCustomValidity('Product name must be at least 4 characters')"
                                                        oninput="this.setCustomValidity('')" />
                                                    <form:errors path="name" cssClass="text-danger" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Price:</label>
                                                    <form:input type="number" class="form-control" path="price"
                                                        required="true" min="1001"
                                                        oninvalid="this.setCustomValidity('Price must be greater than 1000 VND')"
                                                        oninput="this.setCustomValidity('')" />
                                                    <form:errors path="price" cssClass="text-danger" />
                                                </div>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Detail description:</label>
                                                    <form:textarea class="form-control" path="detailDesc" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Short description:</label>
                                                    <form:input type="text" class="form-control" path="shortDesc" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Quantity:</label>
                                                    <form:input type="number" class="form-control" path="quantity" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Factory:</label>
                                                    <form:select class="form-select" path="factory">
                                                        <form:option value="BANDAINAMCO">BANDAINAMCO</form:option>
                                                        <form:option value="MR-HOBBY">MR HOBBY</form:option>
                                                        <form:option value="None">None</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Category:</label>
                                                    <form:select class="form-select" path="category.name">
                                                        <c:forEach var="category" items="${categories}">
                                                            <form:option value="${category.name}">${category.name}
                                                            </form:option>
                                                        </c:forEach>
                                                    </form:select>
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Target:</label>
                                                    <form:select class="form-select" path="target">
                                                        <form:option value="Gundam">Gundam</form:option>
                                                        <form:option value="Accessories - Brackets">Accessories -
                                                            Brackets</form:option>
                                                        <form:option value="liquid and paint">Liquid and paint
                                                        </form:option>
                                                        <form:option value="Static model">Static model</form:option>
                                                        <form:option value="Tools">Tools</form:option>
                                                        <form:option value="Other products">Other products</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="productFile" class="form-label">Image:</label>
                                                    <input class="form-control" type="file" id="productFile"
                                                        accept=".png, .jpg, .jpeg" name="productFile" />
                                                </div>
                                                <div class="col-12 mb-3">
                                                    <img style="max-height: 250px; display: none;" alt="product preview"
                                                        id="productPreview" />
                                                </div>
                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Create</button>
                                                </div>
                                            </form:form>
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