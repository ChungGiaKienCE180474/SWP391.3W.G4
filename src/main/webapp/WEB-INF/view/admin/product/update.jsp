<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Gruop 4 - Dự án Legoshop" />
    <meta name="author" content="Gruop 4" />
    <title>Update Product</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#productFile");
            const orgImage = "${newProduct.image}";
            console.log("Original Image: ", orgImage);
            if (orgImage) {
                const urlImage = "/images/product/" + orgImage;
                $("#productPreview").attr("src", urlImage);
                $("#productPreview").css({ "display": "block" });
            }
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#productPreview").attr("src", imgURL);
                $("#productPreview").css({ "display": "block" });
            });
        });
    
        function isValidText(text) {
            const trimmed = text.trim();
    
            // Phải có ít nhất 1 chữ cái
            if (!/[a-zA-Z]/.test(trimmed)) return false;
    
            // Không được có 2 dấu cách liên tiếp
            if (/[\s]{2,}/.test(text)) return false;
    
            // Không được có 2 ký tự đặc biệt liên tiếp
            if (/[^a-zA-Z0-9\s]{2,}/.test(text)) return false;
    
            return true;
        }
    
        function validateForm() {
            const name = document.querySelector('[name="name"]').value.trim();
            const detailDesc = document.querySelector('[name="detailDesc"]').value.trim();
            const shortDesc = document.querySelector('[name="shortDesc"]').value.trim();
            const quantity = document.querySelector('[name="quantity"]').value;
            const price = document.querySelector('[name="price"]').value;
            const image = document.querySelector('#productFile').files.length;
            const orgImage = "${newProduct.image}"; // Hình ảnh gốc
    
            let errors = [];
    
            // Kiểm tra tên sản phẩm
            if (!isValidText(name)) {
                errors.push("Product name must contain at least one letter, and cannot have two consecutive spaces or special characters.");
            }
    
            // Kiểm tra mô tả chi tiết
            if (detailDesc.length < 10) {
                errors.push("Detail description must be at least 10 characters.");
            }
    
    
            // Kiểm tra số lượng
            if (!quantity || quantity < 0) {
                errors.push("Quantity must be greater than or equal to 0.");
            }
    
            // Kiểm tra giá
            if (!price || price <= 1000) {
                errors.push("Price must be greater than 1000 VND.");
            }
    
            // Kiểm tra hình ảnh (chỉ nếu người dùng chọn ảnh mới)
            if (image > 0) {
                const file = document.querySelector('#productFile').files[0];
                const validImageTypes = ['image/png', 'image/jpeg', 'image/jpg'];
                if (!validImageTypes.includes(file.type)) {
                    errors.push("Image must be in PNG, JPG, or JPEG format.");
                }
            }
    
            if (errors.length > 0) {
                alert(errors.join("\n"));
                return false;
            }
    
            return true;
        }
    
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelector("form").onsubmit = validateForm;
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
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/product">Products</a></li>
                        <li class="breadcrumb-item active">Update</li>
                    </ol>
                    <div class="mt-5">
                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h3>Update a Product</h3>
                                <hr />
                                <!-- Hiển thị thông báo lỗi chung nếu có -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>
                                <form:form method="post" action="/admin/product/update" class="row" 
                                           enctype="multipart/form-data" modelAttribute="newProduct">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <form:input type="hidden" class="form-control" path="id" />
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
                                        <form:input type="number" min="0" class="form-control" path="quantity" />
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Factory:</label>
                                        <form:select class="form-select" path="factory.id">
                                            <c:forEach var="factory" items="${factories}">
                                                <form:option value="${factory.id}">${factory.name}</form:option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Category:</label>
                                        <form:select class="form-select" path="category.name">
                                            <c:forEach var="category" items="${categories}">
                                                <form:option value="${category.name}">${category.name}</form:option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Target:</label>
                                        <form:select class="form-select" path="target.id">
                                            <c:forEach var="target" items="${targets}">
                                                <form:option value="${target.id}">${target.name}</form:option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Scale:</label>
                                        <form:input type="text" class="form-control" path="scale" />
                                        <form:errors path="scale" cssClass="text-danger" />
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Material:</label>
                                        <form:input type="text" class="form-control" path="material" />
                                        <form:errors path="material" cssClass="text-danger" />
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Dimensions:</label>
                                        <form:input type="number" class="form-control" path="dimensions" min="0" step="any" />
                                        <form:errors path="dimensions" cssClass="text-danger" />
                                    </div>
                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Weight:</label>
                                        <form:input type="number" class="form-control" path="weight" min="0" step="any" />
                                        <form:errors path="weight" cssClass="text-danger" />
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
                                        <button type="submit" class="btn btn-primary">Update</button>
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