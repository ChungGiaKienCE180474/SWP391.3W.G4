<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!-- Chỉ thị khai báo loại nội dung của trang là HTML và sử dụng mã hóa UTF-8. -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- Khai báo thư viện taglib JSTL core, cho phép sử dụng các thẻ như c:forEach, c:if. -->
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!-- Khai báo thư viện taglib Spring Form, cho phép sử dụng các thẻ để tạo form. -->
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!-- Khai báo thư viện taglib JSTL fmt, cho phép định dạng dữ liệu như số, ngày tháng. -->

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
                    <title>Update Order </title>
                    <!-- Tiêu đề của trang web. -->
                    <link href="/css/styles.css" rel="stylesheet" />
                    <!-- Liên kết đến file CSS chính của trang web. -->

                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <!-- Liên kết đến thư viện Font Awesome để sử dụng các biểu tượng. -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <!-- Liên kết đến thư viện jQuery. -->
                    <!-- Bootstrap Icon -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                    <!-- Liên kết đến Bootstrap Icons để sử dụng các biểu tượng của Bootstrap. -->
                    <!-- Custom CSS -->
                    <link rel="stylesheet" href="/css/ewstyle.css">
                    <!-- Liên kết đến CSS tùy chỉnh. -->
                    <style>
                        .form-box {
                            width: 60%;
                            margin: 30px auto;
                            padding: 20px;
                            border: 1px solid #ccc;
                            border-radius: 10px;
                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                            background-color: #fff;
                        }

                        .form-box .mb-3 {
                            margin-bottom: 15px;
                        }

                        .form-box label {
                            font-weight: bold;
                            display: block;
                            margin-bottom: 5px;
                        }

                        .form-box .form-label {
                            margin-top: 10px;
                        }

                        .form-box input.form-control {
                            width: 100%;
                            padding: 8px;
                            border: 1px solid #bbb;
                            border-radius: 5px;
                        }
                    </style>
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
                                    <li class="breadcrumb-item active">Update</li>
                                    <!-- Mục breadcrumb hiện tại là "Update". -->
                                </ol>
                                <div class=" mt-5">
                                    <!-- Tạo một div với margin top là 5. -->
                                    <div class="row">
                                        <!-- Tạo một hàng trong Bootstrap grid system. -->
                                        <div class="col-md-6 col-12 mx-auto">
                                            <!-- Tạo một cột chiếm 6 đơn vị (md) hoặc 12 đơn vị (xs) và căn giữa theo chiều ngang. -->
                                            <h3>Update a order</h3>
                                            <!-- Tiêu đề form. -->
                                            <hr />
                                            <!-- Tạo một đường kẻ ngang. -->
                                            <form:form method="post" action="/admin/order/update" class="row"
                                                modelAttribute="newOrder">
                                                <!-- Tạo một form Spring với phương thức POST, action là /admin/order/update và liên kết đến model attribute "newOrder". -->


                                                <div class="form-box">
                                                    <div class="mb-3" style="display: none;">
                                                        <!-- Tạo một div với margin bottom là 3 và ẩn đi. -->
                                                        <label class="form-label">Id:</label>
                                                        <!-- Nhãn cho trường ID. -->
                                                        <form:input type="text" class="form-control" path="id" />
                                                        <!-- Trường input để nhập ID, liên kết đến thuộc tính "id" của model. -->
                                                    </div>
                                                    <div class="mb-3">
                                                        <!-- Tạo một div với margin bottom là 3. -->
                                                        <label>Order id = ${newOrder.id} </label>
                                                        <!-- Hiển thị ID của đơn hàng. -->

                                                        <label class="form-label">Price:
                                                            <!-- Nhãn cho trường Price. -->
                                                            <fmt:formatNumber type="number"
                                                                value="${newOrder.totalPrice}" /> đ
                                                        </label>
                                                        <!-- Hiển thị giá của đơn hàng đã được định dạng. -->
                                                    </div>
                                                    <div class="mb-3 col-12 col-md-6">
                                                        <!-- Tạo một div với margin bottom là 3 và chiếm 6 đơn vị (md) hoặc 12 đơn vị (xs). -->
                                                        <label class="form-label">User:</label>
                                                        <!-- Nhãn cho trường User. -->
                                                        <form:input type="text" class="form-control" disabled="true"
                                                            path="user.fullName" />
                                                        <!-- Trường input để hiển thị tên người dùng, bị vô hiệu hóa và liên kết đến thuộc tính "user.fullName" của model. -->
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <!-- Tạo một div với margin bottom là 3 và chiếm 6 đơn vị (md) hoặc 12 đơn vị (xs). -->
                                                        <label class="form-label">Status:</label>
                                                        <!-- Nhãn cho trường Status. -->
                                                        <form:select class="form-select" path="status">
                                                            <!-- Select box để chọn trạng thái đơn hàng, liên kết đến thuộc tính "status" của model. -->
                                                            <form:option value="PENDING">PENDING</form:option>
                                                            <!-- Option "PENDING". -->
                                                            <form:option value="CONFIRM">CONFIRM</form:option>
                                                            <!-- Option "CONFIRM". -->
                                                            <form:option value="SHIPPING">SHIPPING</form:option>
                                                            <!-- Option "SHIPPING". -->
                                                            <form:option value="COMPLETE">COMPLETE</form:option>
                                                            <!-- Option "COMPLETE". -->
                                                            <form:option value="CANCEL">CANCEL</form:option>
                                                            <!-- Option "CANCEL". -->
                                                            <form:option value="BANKING">BANKING</form:option>
                                                            <!-- Option "BANKING". -->
                                                        </form:select>
                                                        <!-- Kết thúc select box. -->
                                                    </div>
                                                    <div class="col-12 mb-5">
                                                        <!-- Tạo một div với margin bottom là 5 và chiếm 12 đơn vị. -->
                                                        <button type="submit" class="btn btn-warning">Update</button>
                                                        <!-- Nút submit để cập nhật đơn hàng. -->
                                                    </div>
                                                    <!-- Kết thúc div. -->
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