<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${selectedCategory != null ? selectedCategory.name : 'Products'} - Gundam Shop</title>

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
                <style>
                    button.btn {
                        min-height: 40px;
                        width: 100%;
                        text-align: center;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 14px;
                        flex: 1;
                    }

                    .fruite-item {
                        display: flex;
                        flex-direction: column;
                        justify-content: space-between;
                        height: 100%;
                    }

                    #chat-icon {
                        position: fixed;
                        bottom: 100px;
                        right: 30px;
                        background-color: #007bff;
                        color: white;
                        width: 50px;
                        height: 50px;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        border-radius: 50%;
                        cursor: pointer;
                        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                        font-size: 24px;
                    }
                </style>
            </head>

            <body>
                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />

                <!-- Gundam Shop Start -->
                <div class="container-fluid fruite py-5">
                    <div class="container py-5">
                        <div class="tab-class text-center">
                            <div class="row g-4">
                                <div class="col-lg-4 text-start">
                                    <h1>${selectedCategory != null ? selectedCategory.name : 'All Products'}</h1>
                                </div>
                                <div class="col-lg-8 text-end">
                                    <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                        <li class="nav-item">
                                            <a class="d-flex m-2 py-2 bg-light rounded-pill active" href="/products">
                                                <span class="text-dark" style="width: 130px;">PRODUCT</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane fade show p-0 active">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="row g-4">
                                                <c:forEach var="product" items="${products}">
                                                    <c:if test="${product.quantity > 0}">
                                                        <div class="col-md-6 col-lg-4 col-xl-3">
                                                            <div class="rounded position-relative fruite-item">
                                                                <div class="fruite-img">
                                                                    <img src="/images/product/${product.image}"
                                                                        class="img-fluid w-100 rounded-top" alt="">
                                                                </div>
                                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                    style="top: 10px; left: 10px;">
                                                                    ${product.category.name}
                                                                </div>
                                                                <div
                                                                    class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                    <h4 style="font-size: 15px;">
                                                                        <a
                                                                            href="/product/${product.id}">${product.name}</a>
                                                                    </h4>
                                                                    <p class="product-desc">${product.shortDesc}</p>
                                                                    <div
                                                                        class="d-flex flex-lg-wrap justify-content-center flex-column">
                                                                        <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                            class="text-dark fw-bold mb-3">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${product.price}" /> đ
                                                                        </p>
                                                                        <form
                                                                            action="/add-products-to-cart/${product.id}"
                                                                            method="post">
                                                                            <input type="hidden"
                                                                                name="${_csrf.parameterName}"
                                                                                value="${_csrf.token}" />
                                                                            <button class="btn btn-primary w-100">
                                                                                <i
                                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                Add to cart
                                                                            </button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${products.size() == 0}">
                                                    <div class="col-12 text-center">
                                                        <p>No products available in this category.</p>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Phân trang -->
                                    <c:if test="${totalPages > 1}">
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination justify-content-center mt-4">
                                                <li class="page-item <c:if test=" ${currentPage==1}">disabled
                                    </c:if>">
                                    <a class="page-link" href="/category?page=${currentPage - 1}&${queryString}"
                                        aria-label="Previous">
                                        <span aria-hidden="true">«</span>
                                    </a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item <c:if test=" ${currentPage==i}">active</c:if>">
                                            <a class="page-link" href="/category?page=${i}&${queryString}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item <c:if test=" ${currentPage==totalPages}">disabled</c:if>">
                                        <a class="page-link" href="/category?page=${currentPage + 1}&${queryString}"
                                            aria-label="Next">
                                            <span aria-hidden="true">»</span>
                                        </a>
                                    </li>
                                    </ul>
                                    </nav>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Gundam Shop End -->

                <jsp:include page="../layout/feature.jsp" />
                <jsp:include page="../layout/footer.jsp" />

                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                <script
                    src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>

                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>
                <script>
                    document.querySelectorAll('.product-desc').forEach(function (desc) {
                        const words = desc.textContent.trim().split(/\s+/);
                        if (words.length > 4) {
                            desc.textContent = words.slice(0, 4).join(' ') + '...';
                        }
                    });
                </script>
                <div id="chat-icon" onclick="redirectToCareService()">
                    <i class="fas fa-comment-alt"></i>
                </div>
                <script>
                    function redirectToCareService() {
                        window.location.href = "/careservice";
                    }
                </script>  
            </body>

            </html>