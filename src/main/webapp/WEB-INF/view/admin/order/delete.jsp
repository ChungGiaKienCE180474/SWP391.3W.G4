<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!-- Chỉ thị khai báo loại nội dung của trang là HTML và sử dụng mã hóa UTF-8. -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Khai báo thư viện taglib JSTL core, cho phép sử dụng các thẻ như c:forEach, c:if. -->
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                <title>Delete Orders</title>
                <!-- Tiêu đề của trang web. -->
                <link href="/css/styles.css" rel="stylesheet" />
                <!-- Liên kết đến file CSS chính của trang web. -->

                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <!-- Liên kết đến thư viện Font Awesome để sử dụng các biểu tượng. -->
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <!-- Liên kết đến Bootstrap Icons để sử dụng các biểu tượng của Bootstrap. -->
                <!-- Custom CSS -->
                <link rel="stylesheet" href="/css/ewstyle.css">
                <!-- Liên kết đến CSS tùy chỉnh. -->

            </head>

            <body>
                <div class="container-fluid d-flex p-0">
                    <!-- Tạo một container fluid với display flex và padding bằng 0. -->
                    <jsp:include page="../layout/navbar.jsp" />
                    <!-- Nhúng trang navbar.jsp vào trang hiện tại. -->

                    <!-- Main Content -->
                    <div class="main-content p-0">
                        <!-- Tạo một div chứa nội dung chính với padding bằng 0. -->
                        <jsp:include page="../layout/header.jsp" />
                        <!-- Nhúng trang header.jsp vào trang hiện tại. -->

                        <div class="p-4">
                            <!-- Tạo một div với padding bằng 4. -->
                            <h1 class="mt-4">Orders</h1>
                            <!-- Tiêu đề trang. -->
                            <ol class="breadcrumb mb-4">
                                <!-- Tạo một breadcrumb với margin bottom là 4. -->
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <!-- Mục breadcrumb liên kết đến trang dashboard. -->
                                <li class="breadcrumb-item"><a href="/admin/order">Order</a></li>
                                <!-- Mục breadcrumb liên kết đến trang order. -->
                                <li class="breadcrumb-item active">Delete</li>
                                <!-- Mục breadcrumb hiện tại là "Delete". -->
                            </ol>
                            <div class=" mt-5">
                                <!-- Tạo một div với margin top là 5. -->
                                <div class="row">
                                    <!-- Tạo một hàng trong Bootstrap grid system. -->
                                    <div class="col-12 mx-auto">
                                        <!-- Tạo một cột chiếm 12 đơn vị và căn giữa theo chiều ngang. -->
                                        <div class="d-flex justify-content-between">
                                            <!-- Tạo một div với display flex và căn chỉnh nội dung theo chiều ngang. -->
                                            <h3>Delete the order with id = ${id}</h3>
                                            <!-- Tiêu đề trang, hiển thị ID của đơn hàng. -->
                                        </div>

                                        <hr />
                                        <!-- Tạo một đường kẻ ngang. -->
                                        <div class="alert alert-danger">
                                            <!-- Tạo một thông báo màu đỏ. -->
                                            Are you sure to delete this order ?
                                            <!-- Câu hỏi xác nhận xóa đơn hàng. -->
                                        </div>
                                        <form:form method="post" action="/admin/order/delete" modelAttribute="newOrder">
                                            <!-- Tạo một form Spring với phương thức POST, action là /admin/order/delete và liên kết đến model attribute "newOrder". -->
                                            <div class="mb-3" style="display: none;">
                                                <!-- Tạo một div với margin bottom là 3 và ẩn đi. -->
                                                <label class="form-label">Id:</label>
                                                <!-- Nhãn cho trường ID. -->
                                                <form:input value="${id}" type="text" class="form-control" path="id" />
                                                <!-- Trường input để nhập ID, liên kết đến thuộc tính "id" của model, giá trị mặc định là ID của đơn hàng. -->
                                            </div>
                                            <button class="btn btn-danger">Confirm</button>
                                            <!-- Nút submit để xác nhận xóa đơn hàng. -->
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
                        <!-- Kết thúc tag main. -->

                    </div>
                    <!-- Kết thúc div. -->
                </div>
                <!-- Kết thúc div. -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <!-- Liên kết đến Bootstrap JavaScript bundle. -->
                <script src="/js/scripts.js"></script>
                <!-- Liên kết đến file JavaScript tùy chỉnh. -->

            </body>
            <!-- Kết thúc body. -->

            </html>
            <!-- Kết thúc html. -->