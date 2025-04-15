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
                <meta charset="UTF-8">
                <!-- Khai báo bộ mã ký tự là UTF-8. -->
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <!-- Thiết lập viewport cho responsive layout. -->
                <title>Manage Product</title>
                <!-- Tiêu đề của trang web. -->
                <!-- Bootstrap CSS -->
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
                            <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Product Management</h1>
                            <!-- Tiêu đề trang với margin bottom và top là 4, căn giữa và in đậm. -->

                            <!-- Search Bar -->
                            <div class="search-bar mb-4">
                                <!-- Tạo một div chứa thanh tìm kiếm với margin bottom là 4. -->
                                <form method="GET" action="/admin/product/search" class="d-flex align-items-center">
                                    <!-- Tạo một form gửi yêu cầu GET đến /admin/product/search và hiển thị flex. -->
                                    <input type="text" name="keyword" placeholder="Search by name or category"
                                        class="form-control me-2">
                                    <!-- Ô nhập từ khóa tìm kiếm. -->
                                    <button type="submit" class="btn btn-primary">Search</button>
                                    <!-- Nút submit để tìm kiếm. -->
                                </form>
                                <!-- Kết thúc form. -->
                            </div>

                            <table class="table table-bordered table-hover align-middle text-center">
                                <!-- Tạo một bảng với viền, hiệu ứng hover, căn giữa theo chiều dọc và căn giữa chữ. -->
                                <ol class="breadcrumb mb-4">
                                    <!-- Tạo một breadcrumb với margin bottom là 4. -->
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <!-- Mục breadcrumb liên kết đến trang dashboard. -->
                                    <li class="breadcrumb-item active">Products</li>
                                    <!-- Mục breadcrumb hiện tại là "Products". -->
                                </ol>
                                <div class="mt-5">
                                    <!-- Tạo một div với margin top là 5. -->
                                    <div class="row">
                                        <!-- Tạo một hàng trong Bootstrap grid system. -->
                                        <div class="col-12 mx-auto">
                                            <!-- Tạo một cột chiếm 12 đơn vị và căn giữa theo chiều ngang. -->
                                            <div class="d-flex justify-content-between">
                                                <!-- Tạo một div với display flex và căn chỉnh nội dung theo chiều ngang. -->
                                                <h3>Table Product</h3>
                                                <!-- Tiêu đề bảng. -->
                                                <a href="/admin/product/create" class="btn btn-primary">Create a
                                                    Product</a>
                                                <!-- Liên kết để tạo sản phẩm mới. -->
                                            </div>

                                            <hr />
                                            <!-- Tạo một đường kẻ ngang. -->
                                            <table class=" table table-bordered table-hover">
                                                <!-- Tạo một bảng với viền và hiệu ứng hover. -->
                                                <thead>
                                                    <!-- Phần đầu của bảng. -->
                                                    <tr>
                                                        <!-- Hàng tiêu đề. -->
                                                        <th>Name</th>
                                                        <!-- Tiêu đề cột Name. -->
                                                        <th>Price</th>
                                                        <!-- Tiêu đề cột Price. -->
                                                        <th>Factory</th>
                                                        <!-- Tiêu đề cột Factory. -->
                                                        <th>Category</th>
                                                        <!-- Tiêu đề cột Category. -->
                                                        <th>Action</th>
                                                        <!-- Tiêu đề cột Action. -->
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Phần thân của bảng. -->
                                                    <c:forEach var="product" items="${products}">
                                                        <!-- Lặp qua danh sách các sản phẩm. -->
                                                        <tr>
                                                            <!-- Hàng dữ liệu. -->
                                                            <td>${product.name}</td>
                                                            <!-- Hiển thị tên sản phẩm. -->
                                                            <td>
                                                                <!-- Ô dữ liệu. -->
                                                                <fmt:formatNumber type="number"
                                                                    value="${product.price}" />
                                                                đ
                                                                <!-- Hiển thị giá sản phẩm đã được định dạng. -->
                                                            </td>
                                                            <td>${product.factory}</td>
                                                            <!-- Hiển thị tên nhà sản xuất. -->
                                                            <td>${product.category.name}</td>
                                                            <!-- Hiển thị tên danh mục sản phẩm. -->
                                                            <td>
                                                                <!-- Ô dữ liệu. -->
                                                                <a href="/admin/product/${product.id}"
                                                                    class="btn btn-success">View</a>
                                                                <!-- Liên kết để xem chi tiết sản phẩm. -->
                                                                <a href="/admin/product/update/${product.id}"
                                                                    class="btn btn-warning mx-2">Update</a>
                                                                <!-- Liên kết để cập nhật sản phẩm. -->
                                                                <a href="/admin/product/delete/${product.id}"
                                                                    class="btn btn-danger">Delete</a>
                                                                <!-- Liên kết để xóa sản phẩm. -->
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <!-- Kết thúc vòng lặp forEach. -->
                                                </tbody>
                                                <!-- Kết thúc phần thân của bảng. -->
                                            </table>
                                            <!-- Kết thúc bảng. -->
                                        </div>
                                        <!-- Kết thúc div. -->
                                    </div>
                                    <!-- Kết thúc div. -->
                                </div>
                                <!-- Kết thúc div. -->
                            </table>
                            <!-- Kết thúc bảng. -->
                        </div>
                        <!-- Kết thúc div. -->
                    </div>
                    <!-- Kết thúc div. -->
                </div>
                <!-- Kết thúc div. -->

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <!-- Liên kết đến Bootstrap JavaScript bundle. -->

            </body>
            <!-- Kết thúc body. -->

            </html>
            <!-- Kết thúc html. -->