<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!-- Chỉ thị khai báo loại nội dung của trang là HTML và sử dụng mã hóa UTF-8. -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- Khai báo thư viện taglib JSTL core, cho phép sử dụng các thẻ như c:forEach, c:if. -->
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!-- Khai báo thư viện taglib Spring Form, cho phép sử dụng các thẻ để tạo form. -->

            <!DOCTYPE html>
            <!-- Khai báo kiểu tài liệu là HTML5. -->
            <html lang="en">
            <!-- Khai báo thẻ html với ngôn ngữ là tiếng Anh. -->

            <head>
                <meta charset="utf-8" />
                <!-- Khai báo bộ mã ký tự là UTF-8. -->
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <!-- Khai báo chế độ tương thích với IE Edge. -->
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <!-- Thiết lập viewport cho responsive layout. -->
                <meta name="description" content="Hỏi Dân IT - Dự án Legoshop" />
                <!-- Mô tả trang web. -->
                <meta name="author" content="Hỏi Dân IT" />
                <!-- Tác giả của trang web. -->
                <title>Delete Product</title>
                <!-- Tiêu đề của trang web. -->
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <!-- Liên kết đến Simple Datatables CSS (Không chắc chắn được sử dụng ở trang này). -->
                <link href="/css/styles.css" rel="stylesheet" />
                <!-- Liên kết đến file CSS chính của trang web. -->
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <!-- Liên kết đến thư viện Font Awesome để sử dụng các biểu tượng. -->
            </head>

            <body class="sb-nav-fixed">
                <!-- Thiết lập class cho body để sử dụng layout có sidebar cố định (có thể từ một framework CSS nào đó). -->


                <div id="layoutSidenav">
                    <!-- Tạo một div với id là "layoutSidenav" (có thể từ một framework CSS nào đó). -->

                    <div id="layoutSidenav_content">
                        <!-- Tạo một div với id là "layoutSidenav_content" (có thể từ một framework CSS nào đó). -->
                        <main>
                            <!-- Bắt đầu phần nội dung chính của trang. -->
                            <div class="container-fluid px-4">
                                <!-- Tạo một container fluid với padding theo chiều ngang là 4. -->
                                <h1 class="mt-4">Delete Product</h1>
                                <!-- Tiêu đề trang. -->
                                <ol class="breadcrumb mb-4">
                                    <!-- Tạo một breadcrumb với margin bottom là 4. -->
                                    <li class="breadcrumb-item "><a href="/admin">Dashboard</a></li>
                                    <!-- Mục breadcrumb liên kết đến trang dashboard. -->
                                    <li class="breadcrumb-item"><a href="/admin/product">Products</a></li>
                                    <!-- Mục breadcrumb liên kết đến trang product. -->
                                    <li class="breadcrumb-item active">Delete</li>
                                    <!-- Mục breadcrumb hiện tại là "Delete". -->
                                </ol>
                                <div class="mt-5">
                                    <!-- Tạo một div với margin top là 5. -->
                                    <div class="row">
                                        <!-- Tạo một hàng trong Bootstrap grid system. -->
                                        <div class="col-12 mx-auto">
                                            <!-- Tạo một cột chiếm 12 đơn vị và căn giữa theo chiều ngang. -->
                                            <div class="d-flex justify-content-between">
                                                <!-- Tạo một div với display flex và căn chỉnh nội dung theo chiều ngang. -->
                                                <h3>Delete the product with name = ${productName}</h3>
                                                <!-- Tiêu đề trang, hiển thị ID của sản phẩm. -->
                                            </div>

                                            <hr />
                                            <!-- Tạo một đường kẻ ngang. -->
                                            <div class="alert alert-danger">
                                                <!-- Tạo một thông báo màu đỏ. -->
                                                Are you sure to delete this product ?
                                                <!-- Câu hỏi xác nhận xóa sản phẩm. -->
                                            </div>
                                            <form:form method="post" action="/admin/product/delete"
                                                modelAttribute="Product">
                                                <!-- Tạo một form Spring với phương thức POST, action là /admin/product/delete và liên kết đến model attribute "Product". -->
                                                <div class="mb-3" style="display: none;">
                                                    <!-- Tạo một div với margin bottom là 3 và ẩn đi. -->
                                                    <label class="form-label">Id:</label>
                                                    <!-- Nhãn cho trường ID. -->
                                                    <form:input value="${id}" type="text" class="form-control"
                                                        path="id" />
                                                    <!-- Trường input để nhập ID, liên kết đến thuộc tính "id" của model, giá trị mặc định là ID của sản phẩm. -->
                                                </div>
                                                <button class="btn btn-danger">Confirm</button>
                                                <!-- Nút submit để xác nhận xóa sản phẩm. -->
                                            </form:form>
                                            <!-- Kết thúc form. -->

                                        </div>
                                        <!-- Kết thúc div. -->

                                    </div>
                                    <!-- Kết thúc div. -->

                                </div>
                                <!-- Kết thúc div. -->
                            </div>
                            <!-- Kết thúc div. -->
                        </main>
                        <!-- Kết thúc phần nội dung chính của trang. -->

                    </div>
                    <!-- Kết thúc div. -->
                </div>
                <!-- Kết thúc div. -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <!-- Liên kết đến Bootstrap JavaScript bundle. -->
                <script src="js/scripts.js"></script>
                <!-- Liên kết đến file JavaScript tùy chỉnh. -->
            </body>
            <!-- Kết thúc body. -->

            </html>
            <!-- Kết thúc html. -->