<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>Wishlist - GunDamshop</title>
                    <link rel="stylesheet" href="/client/css/bootstrap.min.css">
                    <link rel="stylesheet" href="/client/css/style.css">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />

                    <style>
                        .wishlist-empty-container {
                            padding: 40px 20px;
                            text-align: center;
                            background-color: #f8f9fa;
                            border-radius: 8px;
                            margin: 20px 0;
                        }

                        .wishlist-empty-icon {
                            font-size: 60px;
                            color: #cccccc;
                            margin-bottom: 20px;
                        }

                        .wishlist-empty-title {
                            font-size: 24px;
                            margin-bottom: 10px;
                            color: #343a40;
                        }

                        .wishlist-empty-text {
                            font-size: 16px;
                            color: #6c757d;
                            margin-bottom: 20px;
                        }
                    </style>
                </head>

                <body>

                    <!-- Header -->
                    <jsp:include page="../layout/header.jsp" />

                    <div class="container py-5">
                        <h2 class="mb-4">Your Wishlist</h2>

                        <!-- Bọc toàn bộ bảng wishlist trong 1 div có id để AJAX thay thế -->
                        <div id="wishlist-container">
                            <c:choose>
                                <c:when test="${empty wishlist}">
                                    <!-- Improved empty wishlist display -->
                                    <div class="wishlist-empty-container">
                                        <div class="wishlist-empty-icon">
                                            <i class="fa fa-heart-o"></i>
                                        </div>
                                        <h3 class="wishlist-empty-title">Your wishlist is empty</h3>
                                        <p class="wishlist-empty-text">Discover and save your favorite Gundam models for
                                            later</p>
                                        <a href="/products" class="btn btn-primary">
                                            <i class="fa fa-shopping-cart me-2"></i> Explore Products
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <p class="text-success">Wishlist contains ${wishlist.size()} items.</p>
                                        <table class="table table-bordered">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th scope="col">Product</th>
                                                    <th scope="col">Name</th>
                                                    <th scope="col">Price</th>
                                                    <th scope="col">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${wishlist}">
                                                    <tr>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty product.image}">
                                                                    <img src="/images/product/${product.image}"
                                                                        class="img-fluid rounded"
                                                                        style="width: 80px; height: 80px;"
                                                                        alt="${product.name}">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="/images/product/default.jpg"
                                                                        class="img-fluid rounded"
                                                                        style="width: 80px; height: 80px;"
                                                                        alt="No Image">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${product.name}</td>
                                                        <td>
                                                            <fmt:formatNumber type="currency" currencyCode="VND"
                                                                value="${product.price}" />
                                                        </td>
                                                        <td>
                                                            <!-- Remove from Wishlist (AJAX) -->
                                                            <form action="/wishlist/remove/${product.id}" method="post"
                                                                class="wishlist-ajax-form" style="display:inline;">
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                                <button type="submit" class="btn btn-danger btn-sm">
                                                                    <i class="fa fa-trash me-1"></i> Remove
                                                                </button>
                                                            </form>

                                                            <!-- Modified: Add to Cart button that also removes from wishlist -->
                                                            <button
                                                                onclick="addToCartAndRemoveFromWishlist('${product.id}')"
                                                                class="btn btn-primary btn-sm"
                                                                style="margin-left: 5px;">
                                                                <i class="fa fa-shopping-cart me-1"></i> Add to cart
                                                            </button>

                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- JS -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <script src="/client/js/main.js"></script>

                    <!-- AJAX Wishlist script with new functionality -->
                    <script>
                        // Lấy token CSRF nếu đang dùng Spring Security
                        var csrfToken = $("meta[name='_csrf']").attr("content");
                        var csrfHeader = $("meta[name='_csrf_header']").attr("content");

                        // Bắt sự kiện submit trên các form class="wishlist-ajax-form" (chỉ dùng cho nút Remove)
                        $(document).on('submit', '.wishlist-ajax-form', function (e) {
                            e.preventDefault();
                            var form = $(this);

                            $.ajax({
                                url: form.attr('action'),
                                type: 'POST',
                                data: form.serialize(),
                                beforeSend: function (xhr) {
                                    // Nếu có CSRF
                                    if (csrfToken && csrfHeader) {
                                        xhr.setRequestHeader(csrfHeader, csrfToken);
                                    }
                                },
                                success: function (response) {
                                    // Controller trả về HTML cập nhật cho wishlist
                                    $("#wishlist-container").html(response);
                                },
                                error: function (xhr, status, error) {
                                    console.error("Lỗi AJAX:", status, error);

                                }
                            });
                        });

                        // Hàm mới để xử lý add to cart và remove from wishlist
                        function addToCartAndRemoveFromWishlist(productId) {
                            // Đầu tiên gọi AJAX để xóa khỏi wishlist
                            $.ajax({
                                url: '/wishlist/remove/' + productId,
                                type: 'POST',
                                data: {
                                    "${_csrf.parameterName}": "${_csrf.token}"
                                },
                                beforeSend: function (xhr) {
                                    if (csrfToken && csrfHeader) {
                                        xhr.setRequestHeader(csrfHeader, csrfToken);
                                    }
                                },
                                success: function () {
                                    // Sau khi xóa khỏi wishlist thành công, gọi AJAX để thêm vào giỏ hàng
                                    $.ajax({
                                        url: '/add-products-to-cart/' + productId,
                                        type: 'POST',
                                        data: {
                                            "${_csrf.parameterName}": "${_csrf.token}"
                                        },
                                        beforeSend: function (xhr) {
                                            if (csrfToken && csrfHeader) {
                                                xhr.setRequestHeader(csrfHeader, csrfToken);
                                            }
                                        },
                                        success: function () {
                                            // Sau khi thêm vào giỏ hàng thành công, chuyển hướng đến trang giỏ hàng
                                            window.location.href = '/wishlist';
                                        },
                                        error: function (xhr, status, error) {
                                            console.error("Lỗi khi thêm vào giỏ hàng:", status, error);
                                            alert("Sản phẩm đã được thêm vào giỏ hàng, nhưng có lỗi khi chuyển trang.");
                                            // Nếu có lỗi vẫn cố gắng chuyển trang
                                            window.location.href = '/wishlist';
                                        }
                                    });
                                },
                                error: function (xhr, status, error) {
                                    console.error("Lỗi khi xóa khỏi wishlist:", status, error);

                                    // Nếu có lỗi khi xóa khỏi wishlist, vẫn tiếp tục thêm vào giỏ hàng
                                    $.ajax({
                                        url: '/add-products-to-cart/' + productId,
                                        type: 'POST',
                                        data: {
                                            "${_csrf.parameterName}": "${_csrf.token}"
                                        },
                                        beforeSend: function (xhr) {
                                            if (csrfToken && csrfHeader) {
                                                xhr.setRequestHeader(csrfHeader, csrfToken);
                                            }
                                        },
                                        success: function () {
                                            window.location.href = '/wishlist';
                                        },
                                        error: function (xhr, status, error) {
                                            console.error("Lỗi khi thêm vào giỏ hàng:", status, error);
                                            alert("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng.");
                                        }
                                    });
                                }
                            });
                        }

                    </script>
                    <script>
                        // Khởi tạo tất cả các dropdown
                        document.addEventListener('DOMContentLoaded', function () {
                            var dropdownElementList = [].slice.call(document.querySelectorAll('[data-bs-toggle="dropdown"]'));
                            dropdownElementList.map(function (dropdownToggleEl) {
                                return new bootstrap.Dropdown(dropdownToggleEl);
                            });

                            // Thêm xử lý sự kiện trực tiếp cho biểu tượng người dùng
                            var userIcon = document.querySelector('.dropdown a[role="button"]');
                            if (userIcon) {
                                userIcon.addEventListener('click', function (e) {
                                    e.preventDefault();
                                    var dropdown = bootstrap.Dropdown.getInstance(this);
                                    if (!dropdown) {
                                        dropdown = new bootstrap.Dropdown(this);
                                    }
                                    dropdown.toggle();
                                });
                            }
                        });
                    </script>
                </body>

                </html>