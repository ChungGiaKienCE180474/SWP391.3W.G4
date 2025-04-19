<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>${product.name} - Gundamshop</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">

                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />

                    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
                        rel="stylesheet">
                </head>

                <body>
                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Single Product Start -->
                    <div class="container-fluid py-5 mt-5">
                        <div class="container py-5">
                            <div class="row g-4 mb-5">
                                <div>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Product Details</li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-lg-8 col-xl-9">
                                    <div class="row g-4">
                                        <div class="col-lg-6">
                                            <div class="border rounded">
                                                <img src="/images/product/${product.image}" class="img-fluid rounded"
                                                    alt="Image">
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <h4 class="fw-bold mb-3">${product.name}</h4>
                                            <p class="mb-3">${product.factory}</p>
                                            <h5 class="fw-bold mb-3">
                                                <fmt:formatNumber type="number" value="${product.price}" /> đ
                                            </h5>
                                            <h5 class="fw-bold mb-3">
                                                <c:forEach var="i" begin="1" end="5">
                                                    <i
                                                        class="fa fa-star ${i <= averageRating ? 'text-secondary' : ''}"></i>
                                                </c:forEach>
                                            </h5>
                                            <p class="mb-4">
                                                ${product.shortDesc}
                                            </p>

                                            <c:choose>
                                                <c:when test="${product.quantity > 0}">
                                                    <div class="input-group quantityDetail mb-5" style="width: 100px;">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="1"
                                                            data-available-quantity="${cartDetail.product.quantity}"
                                                            data-cart-detail-index="0"
                                                            cartDetail-available-quantity="${cartDetail.quantity}">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>

                                                    <!-- Form thêm vào giỏ hàng (giữ nguyên) -->
                                                    <form action="/add-product-from-view-detail" method="post"
                                                        modelAttribute="product">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <input class="form-control d-none" type="text"
                                                            value="${product.id}" name="id" />
                                                        <input class="form-control d-none" type="text" name="quantity"
                                                            id="cartDetails0.quantity" value="1" />
                                                        <button data-product-id="${product.id}"
                                                            class="btn btn-primary border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">
                                                            <i class="fa fa-shopping-bag me-2 text-primary"></i> Add to
                                                            cart
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-secondary rounded-pill px-4 py-2 mb-4"
                                                        disabled>
                                                        Out of stock
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="col-lg-12">
                                            <nav>
                                                <div class="nav nav-tabs mb-3">
                                                    <button class="nav-link active border-white border-bottom-0"
                                                        type="button" role="tab" id="nav-about-tab" data-bs-toggle="tab"
                                                        data-bs-target="#nav-about" aria-controls="nav-about"
                                                        aria-selected="true">
                                                        Description
                                                    </button>
                                                </div>
                                            </nav>
                                            <div class="tab-content mb-5">
                                                <div class="tab-pane active" id="nav-about" role="tabpanel"
                                                    aria-labelledby="nav-about-tab">
                                                    <p id="product-description">${product.detailDesc}</p>
                                                </div>
                                            </div>

                                            <h4 class="fw-bold mb-4">Customer Reviews:</h4>
                                            <c:forEach var="review" items="${reviews}">
                                                <div class="review-item d-flex align-items-start mb-3">
                                                    <img src="/images/avatar/${review.user.avatar}"
                                                        alt="${review.user.fullName} Avatar" class="rounded-circle"
                                                        width="50" height="50" style="margin-right: 15px;">
                                                    <div>
                                                        <p><strong>${review.user.fullName} </strong> rated:
                                                            <c:forEach begin="1" end="${review.rating}">
                                                                <i class="fa fa-star text-secondary"></i>
                                                            </c:forEach>
                                                        </p>
                                                        <c:if test="${review.visible == 'Yes'}">
                                                            <p>${review.reviewContent}</p>
                                                        </c:if>
                                                        <c:if test="${review.visible != 'Yes'}">
                                                            <p class="text-muted">
                                                                Comment hidden for containing inappropriate language.
                                                            </p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-xl-3">
                                    <div class="row g-4 fruite">
                                        <div class="col-lg-12">
                                            <!-- ... -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
                        <i class="fa fa-arrow-up"></i>
                    </a>

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>

                    <script
                        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
                    <script>
                        $(document).ready(function () {
                            var description = document.querySelector("#product-description");
                            if (description) {
                                description.innerHTML = description.innerHTML.replace(/\n/g, "<br>");
                            }
                        });
                    </script>
                    <script>
                        $(document).ready(function () {
                            // Chuyển đổi \n thành <br> trong phần mô tả sản phẩm
                            var description = document.querySelector("#product-description");
                            if (description) {
                                description.innerHTML = description.innerHTML.replace(/\n/g, "<br>");
                            }

                            // Xử lý thêm vào wishlist
                            $(".add-to-wishlist").on("click", function (e) {
                                e.preventDefault();
                                var productId = $(this).data("product-id");

                                // Kiểm tra nếu sản phẩm đã có trong wishlist
                                $.ajax({
                                    url: "/wishlist/add",
                                    type: "POST",
                                    data: {
                                        productId: productId,
                                        "_csrf": $("meta[name='_csrf']").attr("content")
                                    },
                                    success: function (response) {
                                        if (response.success) {
                                            $.toast({
                                                heading: 'Success',
                                                text: 'Product added to your wishlist!',
                                                icon: 'success',
                                                position: 'top-right',
                                                hideAfter: 3000
                                            });
                                        } else if (response.message) {
                                            $.toast({
                                                heading: 'Info',
                                                text: response.message,
                                                icon: 'info',
                                                position: 'top-right',
                                                hideAfter: 3000
                                            });
                                        }
                                    },
                                    error: function () {
                                        $.toast({
                                            heading: 'Error',
                                            text: 'An error occurred. Please try again later.',
                                            icon: 'error',
                                            position: 'top-right',
                                            hideAfter: 3000
                                        });
                                    }
                                });
                            });
                        });
                    </script>

                </body>

                </html>