<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!-- Chỉ thị khai báo loại nội dung của trang là HTML và sử dụng mã hóa UTF-8. -->

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- Khai báo thư viện taglib JSTL core, cho phép sử dụng các thẻ như c:forEach, c:if. -->

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
                <title>Manager Order</title>
                <!-- Tiêu đề của trang web. -->
                <link href="/css/styles.css" rel="stylesheet" />
                <!-- Liên kết đến file CSS chính của trang web. -->
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <!-- Liên kết đến thư viện Font Awesome để sử dụng các biểu tượng. -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Liên kết đến Bootstrap CSS để sử dụng các thành phần giao diện. -->
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
                            <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Order Management</h1>
                            <!-- Tiêu đề trang với margin bottom và top là 4, căn giữa và in đậm. -->
                            <ol class="breadcrumb mb-4">
                                <!-- Tạo một breadcrumb với margin bottom là 4. -->
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <!-- Mục breadcrumb liên kết đến trang dashboard. -->
                                <li class="breadcrumb-item active">Order</li>
                                <!-- Mục breadcrumb hiện tại là "Order". -->
                            </ol>
                            <!-- Filter Bar -->
                            <div class="filter-bar mb-4">
                                <!-- Tạo một div chứa thanh lọc với margin bottom là 4. -->
                                <form method="GET" action="/admin/order" class="d-inline">
                                    <!-- Tạo một form gửi yêu cầu GET đến /admin/order và hiển thị inline. -->
                                    <select name="status" style="margin-right: 10px;">
                                        <!-- Tạo một select box với tên là "status" và margin phải là 10px. -->
                                        <option value="" <c:if test="${empty param.status}">selected</c:if>>All</option>
                                        <!-- Option "All" được chọn nếu không có tham số "status". -->
                                        <option value="COMPLETE" <c:if test="${param.status == 'COMPLETE'}">selected
                                            </c:if>>Complete</option>
                                        <!-- Option "Complete" được chọn nếu tham số "status" là "COMPLETE". -->
                                        <option value="CONFIRM" <c:if test="${param.status == 'CONFIRM'}">selected
                                            </c:if>>Confirm</option>
                                        <!-- Option "Confirm" được chọn nếu tham số "status" là "CONFIRM". -->
                                        <option value="PENDING" <c:if test="${param.status == 'PENDING'}">selected
                                            </c:if>>Pending</option>
                                        <!-- Option "Pending" được chọn nếu tham số "status" là "PENDING". -->
                                        <option value="SHIPPING" <c:if test="${param.status == 'SHIPPING'}">selected
                                            </c:if>>Shipping</option>
                                        <!-- Option "Shipping" được chọn nếu tham số "status" là "SHIPPING". -->
                                        <option value="CANCEL" <c:if test="${param.status == 'CANCEL'}">selected</c:if>
                                            >Cancel</option>
                                        <!-- Option "Cancel" được chọn nếu tham số "status" là "CANCEL". -->
                                    </select>

                                    <button type="submit" class="btn btn-primary">Filter</button>
                                    <!-- Nút submit để lọc dữ liệu. -->
                                </form>
                                <a href="/admin/order" class="btn btn-secondary ms-2">All Orders</a>
                                <!-- Liên kết để hiển thị tất cả các đơn hàng. -->
                            </div>
                            <div class="mt-5">
                                <!-- Tạo một div với margin top là 5. -->
                                <div class="row">
                                    <!-- Tạo một hàng trong Bootstrap grid system. -->
                                    <div class="col-12 mx-auto">
                                        <!-- Tạo một cột chiếm 12 đơn vị và căn giữa theo chiều ngang. -->
                                        <div class="d-flex">
                                            <!-- Tạo một div với display flex. -->
                                            <h3>Table Orders</h3>
                                            <!-- Tiêu đề bảng. -->
                                        </div>

                                        <hr />
                                        <!-- Tạo một đường kẻ ngang. -->
                                        <table class=" table table-bordered table-hover">
                                            <!-- Tạo một bảng với viền và hiệu ứng hover. -->
                                            <thead>
                                                <!-- Phần đầu của bảng. -->
                                                <tr>
                                                    <!-- Hàng tiêu đề. -->
                                                    <th>ID</th>
                                                    <!-- Tiêu đề cột ID. -->
                                                    <th>User</th>
                                                    <!-- Tiêu đề cột User. -->
                                                    <th>Date</th>
                                                    <!-- Tiêu đề cột Date. -->
                                                    <th>Total Price</th>
                                                    <!-- Tiêu đề cột Total Price. -->
                                                    <th>Status</th>
                                                    <!-- Tiêu đề cột Status. -->
                                                    <th>Action</th>
                                                    <!-- Tiêu đề cột Action. -->
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Phần thân của bảng. -->
                                                <c:forEach var="order" items="${orders}">
                                                    <!-- Lặp qua danh sách các đơn hàng. -->
                                                    <c:if test="${empty param.status || order.status == param.status}">
                                                        <!-- Kiểm tra nếu không có tham số "status" hoặc trạng thái đơn hàng trùng với tham số "status". -->
                                                        <tr>
                                                            <!-- Hàng dữ liệu. -->
                                                            <th>${order.id}</th>
                                                            <!-- Hiển thị ID đơn hàng. -->
                                                            <td>${order.user.fullName}</td>
                                                            <!-- Hiển thị tên người dùng. -->
                                                            <td>
                                                                ${order.convertedOrderDate}
                                                            </td>
                                                            <!-- Hiển thị ngày tạo đơn hàng đã được định dạng. -->
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${order.totalPrice}" /> đ
                                                            </td>
                                                            <!-- Hiển thị tổng giá đơn hàng đã được định dạng. -->
                                                            <td>${order.status}</td>
                                                            <!-- Hiển thị trạng thái đơn hàng. -->
                                                            <td>
                                                                <!-- Các hành động có thể thực hiện với đơn hàng tùy thuộc vào trạng thái của nó. -->
                                                                <c:if test="${order.status == 'COMPLETE'}">
                                                                    <!-- Nếu trạng thái là COMPLETE. -->
                                                                    <a href="/admin/order/${order.id}"
                                                                        class="btn btn-success">View</a>
                                                                    <!-- Liên kết để xem chi tiết đơn hàng. -->
                                                                </c:if>
                                                                <c:if test="${order.status == 'CONFIRM'}">
                                                                    <!-- Nếu trạng thái là CONFIRM. -->
                                                                    <a href="/admin/order/${order.id}"
                                                                        class="btn btn-success">View</a>
                                                                    <!-- Liên kết để xem chi tiết đơn hàng. -->
                                                                    <a href="/admin/order/update/${order.id}"
                                                                        class="btn btn-warning  mx-2">Update</a>
                                                                    <!-- Liên kết để cập nhật đơn hàng. -->
                                                                </c:if>
                                                                <c:if test="${order.status == 'SHIPPING'}">
                                                                    <!-- Nếu trạng thái là SHIPPING. -->
                                                                    <a href="/admin/order/${order.id}"
                                                                        class="btn btn-success">View</a>
                                                                    <!-- Liên kết để xem chi tiết đơn hàng. -->
                                                                    <a href="/admin/order/update/${order.id}"
                                                                        class="btn btn-warning  mx-2">Update</a>
                                                                    <!-- Liên kết để cập nhật đơn hàng. -->
                                                                </c:if>
                                                                <c:if test="${order.status == 'PENDING'}">
                                                                    <!-- Nếu trạng thái là PENDING. -->
                                                                    <a href="/admin/order/${order.id}"
                                                                        class="btn btn-success">View</a>
                                                                    <!-- Liên kết để xem chi tiết đơn hàng. -->
                                                                    <a href="/admin/order/update/${order.id}"
                                                                        class="btn btn-warning  mx-2">Update</a>
                                                                    <!-- Liên kết để cập nhật đơn hàng. -->
                                                                </c:if>
                                                                <c:if test="${order.status == 'CANCEL'}">
                                                                    <!-- Nếu trạng thái là CANCEL. -->
                                                                    <a href="/admin/order/${order.id}"
                                                                        class="btn btn-success">View</a>

                                                                    <!-- Liên kết để xem chi tiết đơn hàng. -->

                                                                </c:if>

                                                            </td>
                                                            <!-- Kết thúc cột hành động. -->
                                                        </tr>
                                                        <!-- Kết thúc hàng dữ liệu. -->
                                                    </c:if>
                                                    <!-- Kết thúc điều kiện if. -->
                                                </c:forEach>
                                                <!-- Kết thúc vòng lặp forEach. -->

                                            </tbody>
                                            <!-- Kết thúc phần thân của bảng. -->
                                        </table>
                                        <!-- Kết thúc bảng. -->
                                    </div>
                                    <!-- Kết thúc cột. -->

                                </div>
                                <!-- Kết thúc hàng. -->



                            </div>
                            <!-- Kết thúc div mt-5. -->
                        </div>
                        <!-- Kết thúc div p-4. -->
                    </div>
                    <!-- Kết thúc div main-content. -->
                </div>
                <!-- Kết thúc div container-fluid. -->

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <!-- Liên kết đến Bootstrap JavaScript bundle. -->
                <script src="/js/scripts.js"></script>
                <!-- Liên kết đến file JavaScript tùy chỉnh. -->

            </body>
            <!-- Kết thúc phần thân của trang web. -->

            </html>
            <!-- Kết thúc trang web. -->