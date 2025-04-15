<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!-- Chỉ thị khai báo loại nội dung của trang là HTML và sử dụng mã hóa UTF-8. -->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- Khai báo thư viện taglib JSTL core, cho phép sử dụng các thẻ như c:forEach, c:if. -->
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <!-- Khai báo thư viện taglib Spring Form. (Không thực sự được sử dụng trong trang này). -->
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
                    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                    <!-- Mô tả trang web. -->
                    <meta name="author" content="Hỏi Dân IT" />
                    <!-- Tác giả của trang web. -->
                    <title>Detail Order</title>
                    <!-- Tiêu đề của trang web. -->
                    <link href="/css/styles.css" rel="stylesheet" />
                    <!-- Liên kết đến file CSS chính của trang web. -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Liên kết đến Bootstrap CSS để sử dụng các thành phần giao diện. -->
                    <!-- Bootstrap Icon -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                    <!-- Liên kết đến Bootstrap Icons để sử dụng các biểu tượng của Bootstrap. -->
                    <!-- Custom CSS -->
                    <link rel="stylesheet" href="/css/ewstyle.css">
                    <!-- Liên kết đến CSS tùy chỉnh. -->

                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <!-- Liên kết đến thư viện Font Awesome để sử dụng các biểu tượng. -->
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
                                    <li class="breadcrumb-item active">View detail</li>
                                    <!-- Mục breadcrumb hiện tại là "View detail". -->
                                </ol>
                                <div class="mt-5">
                                    <!-- Tạo một div với margin top là 5. -->
                                    <div class="row">
                                        <!-- Tạo một hàng trong Bootstrap grid system. -->
                                        <div class="col-12 mx-auto">
                                            <!-- Tạo một cột chiếm 12 đơn vị và căn giữa theo chiều ngang. -->
                                            <div class="d-flex justify-content-between">
                                                <!-- Tạo một div với display flex và căn chỉnh nội dung theo chiều ngang. -->
                                                <h3>Order detail with id = ${id}</h3>
                                                <!-- Tiêu đề trang, hiển thị ID của đơn hàng. -->
                                            </div>

                                            <hr />
                                            <!-- Tạo một đường kẻ ngang. -->

                                            <div class="table-responsive">
                                                <!-- Tạo một div với khả năng responsive cho bảng. -->
                                                <table class="table">
                                                    <!-- Tạo một bảng. -->
                                                    <thead>
                                                        <!-- Phần đầu của bảng. -->
                                                        <tr>
                                                            <!-- Hàng tiêu đề. -->
                                                            <th scope="col">Product</th>
                                                            <!-- Tiêu đề cột Product. -->
                                                            <th scope="col">Name</th>
                                                            <!-- Tiêu đề cột Name. -->
                                                            <th scope="col">Price</th>
                                                            <!-- Tiêu đề cột Price. -->
                                                            <th scope="col">Quantity</th>
                                                            <!-- Tiêu đề cột Quantity. -->
                                                            <th scope="col">Total amount</th>
                                                            <!-- Tiêu đề cột Total amount. -->
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <!-- Phần thân của bảng. -->
                                                        <c:if test="${ empty orderDetails}">
                                                            <!-- Kiểm tra nếu danh sách orderDetails rỗng. -->
                                                            <tr>
                                                                <!-- Hàng dữ liệu. -->
                                                                <td colspan="6">
                                                                    <!-- Ô dữ liệu chiếm 6 cột. -->
                                                                    There are no products in the cart
                                                                    <!-- Thông báo nếu không có sản phẩm nào trong giỏ hàng. -->
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                        <c:forEach var="orderDetail" items="${orderDetails}">
                                                            <!-- Lặp qua danh sách các chi tiết đơn hàng. -->

                                                            <tr>
                                                                <!-- Hàng dữ liệu. -->
                                                                <th scope="row">
                                                                    <!-- Ô dữ liệu là tiêu đề hàng. -->
                                                                    <div class="d-flex align-items-center">
                                                                        <!-- Tạo một div với display flex và căn chỉnh nội dung theo chiều dọc. -->
                                                                        <img src="/images/product/${orderDetail.product.image}"
                                                                            class="img-fluid me-5 rounded-circle"
                                                                            style="width: 80px; height: 80px;" alt="">
                                                                        <!-- Hiển thị hình ảnh sản phẩm. -->
                                                                    </div>
                                                                </th>
                                                                <td>
                                                                    <!-- Ô dữ liệu. -->
                                                                    <p class="mb-0 mt-4">
                                                                        <!-- Đoạn văn với margin bottom là 0 và margin top là 4. -->
                                                                        <a href="/product/${orderDetail.product.id}"
                                                                            target="_blank">
                                                                            <!-- Liên kết đến trang chi tiết sản phẩm. -->
                                                                            ${orderDetail.product.name}
                                                                            <!-- Hiển thị tên sản phẩm. -->
                                                                        </a>
                                                                    </p>
                                                                </td>
                                                                <td>
                                                                    <!-- Ô dữ liệu. -->
                                                                    <p class="mb-0 mt-4">
                                                                        <!-- Đoạn văn với margin bottom là 0 và margin top là 4. -->
                                                                        <fmt:formatNumber type="number"
                                                                            value="${orderDetail.price}" /> đ
                                                                        <!-- Hiển thị giá sản phẩm đã được định dạng. -->
                                                                    </p>
                                                                </td>
                                                                <td>
                                                                    <!-- Ô dữ liệu. -->
                                                                    <div class="input-group quantity mt-4"
                                                                        style="width: 100px;">
                                                                        <!-- Tạo một input group với class "quantity" và margin top là 4. -->
                                                                        <input type="text"
                                                                            class="form-control form-control-sm text-center border-0"
                                                                            value="${orderDetail.quantity}">
                                                                        <!-- Ô nhập số lượng sản phẩm, không có viền. -->
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <!-- Ô dữ liệu. -->
                                                                    <p class="mb-0 mt-4"
                                                                        data-cart-detail-id="${orderDetail.id}">
                                                                        <!-- Đoạn văn với margin bottom là 0 và margin top là 4, có attribute data-cart-detail-id. -->
                                                                        <fmt:formatNumber type="number"
                                                                            value="${orderDetail.price * orderDetail.quantity}" />
                                                                        đ
                                                                        <!-- Hiển thị tổng tiền của sản phẩm đã được định dạng. -->
                                                                    </p>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        <!-- Kết thúc vòng lặp forEach. -->

                                                    </tbody>
                                                    <!-- Kết thúc phần thân của bảng. -->
                                                </table>
                                                <!-- Kết thúc bảng. -->
                                                <div class="d-flex justify-content-end">
                                                    <!-- Tạo một div với display flex và căn chỉnh nội dung theo chiều ngang. -->
                                                    <a href="/admin/order" class="btn btn-success mt-3">Back</a>
                                                    <!-- Liên kết để quay lại trang order. -->
                                                </div>
                                            </div>
                                            <!-- Kết thúc div. -->

                                        </div>
                                        <!-- Kết thúc div. -->
                                    </div>
                                    <!-- Kết thúc div. -->
                                    </main>
                                    <!-- Kết thúc tag main. -->



                                    <script
                                        src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                                        crossorigin="anonymous"></script>
                                    <!-- Liên kết đến Bootstrap JavaScript bundle. -->
                                    <script src="/js/scripts.js"></script>
                                    <!-- Liên kết đến file JavaScript tùy chỉnh. -->

                </body>
                <!-- Kết thúc body. -->

                </html>
                <!-- Kết thúc html. -->