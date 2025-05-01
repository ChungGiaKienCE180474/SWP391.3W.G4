<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
            <style>
                /*** by me ***/
                .nav-item.search-bar {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    padding: 5px;
                    position: relative;
                }

                .nav-search {
                    width: 150px;
                    padding: 8px;
                    border: 2px solid #ccc;
                    border-radius: 20px;
                    outline: none;
                    font-size: 14px;
                    transition: width 0.4s ease-in-out;
                }

                .nav-search:focus {
                    width: 300px;
                    border-color: #007bff;
                }

                .nav-search::placeholder {
                    color: #999;
                    font-style: italic;
                }

                /* Tùy chỉnh dropdown */
                .dropdown-menu {
                    min-width: 200px;
                }

                .dropdown-item:hover {
                    background-color: #2f4c68;
                }

                .d-flex.m-3.me-0 {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    /* Thêm khoảng cách nhỏ giữa các mục */
                    white-space: nowrap;
                    /* Ngăn chữ xuống dòng */
                    padding-bottom: 20px;

                }

                /* Sửa lỗi xuống hàng bằng cách giảm kích thước chữ và khoảng cách */
                .nav-link {
                    white-space: nowrap;
                    /* Ngăn văn bản xuống hàng */
                    font-size: 13px;
                    /* Giảm kích thước chữ để vừa hàng */
                    padding: 0.5rem 0.5rem;
                    /* Giảm padding để tiết kiệm không gian */
                }

                .nav-item {
                    padding: 0 2px;
                    /* Giảm khoảng cách giữa các mục */
                }

                /* Responsive: Điều chỉnh trên màn hình nhỏ */
                @media screen and (max-width: 768px) {
                    .nav-search {
                        width: 120px;
                        /* Giảm chiều rộng thanh tìm kiếm trên mobile */
                    }

                    .nav-search:focus {
                        width: 150px;
                    }

                    .nav-link {
                        font-size: 11px;
                        /* Giảm thêm kích thước chữ trên mobile */
                        padding: 0.3rem 0.4rem;
                        /* Giảm padding trên mobile */
                    }

                    .nav-item {
                        padding: 0 1px;
                        /* Giảm khoảng cách trên mobile */
                    }
                }
            </style>
        </head>

        <body>
            <!-- Navbar Start -->
            <div class="container-fluid fixed-top">
                <div class="container px-0">
                    <nav class="navbar navbar-light bg-white navbar-expand-xl">
                        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarCollapse">
                            <span class="fa fa-bars text-primary"></span>
                        </button>
                        <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                            <div class="navbar-nav">
                                <li class="nav-item logo-item">
                                    <a href="/"><img class="nav-logo" style="width: 50px" src="/client/img/logo.jpg"
                                            alt=""></a>
                                </li>
                                <a href="/" class="nav-item nav-link active fw-bold">Home Page</a>
                                <!-- Search Form -->
                                <form action="/search" method="get" class="nav-item search-bar d-flex">
                                    <input class="nav-search" type="text" name="query" placeholder="What do you need..."
                                        required>
                                    <button type="submit" class="btn p-0 ms-2" style="background: none; border: none;">
                                        <i class="fas fa-search fa-lg"></i>
                                    </button>
                                </form>
                                <a href="/products" class="nav-item nav-link fw-bold">Product</a>
                                <a href="/careservice" class="nav-item nav-link fw-bold">Care Service</a>
                                <a href="/news" class="nav-item nav-link fw-bold">News</a>
                                <a href="/contact/new" class="nav-item nav-link fw-bold">Contact</a>
                                <a href="/aboutus" class="nav-item nav-link fw-bold">About Us</a>
                                <a href="/voucher/all" class="nav-item nav-link fw-bold">Vouchers</a>
                                <!-- Dropdown Category -->
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link fw-bold dropdown-toggle"
                                        data-bs-toggle="dropdown">Themes</a>
                                    <ul class="dropdown-menu">
                                        <c:forEach var="category" items="${categories}">
                                            <li><a class="dropdown-item"
                                                    href="/category?categoryId=${category.id}">${category.name}</a></li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <div class="d-flex m-3 me-0">
                                <c:if test="${not empty pageContext.request.userPrincipal}">
                                    <!-- Giỏ hàng -->
                                    <a href="/cart" class="position-relative me-4 my-auto">
                                        <i class="fa fa-shopping-bag fa-2x"></i>
                                        <span
                                            class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                            style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                            ${sessionScope.sum}
                                        </span>
                                    </a>
                                    <!-- Wishlist -->
                                    <a href="/wishlist" class="position-relative me-4 my-auto wishlist-icon"
                                        title="Wishlist">
                                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="2" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16z"></path>
                                            <path
                                                d="M12 7C11.17 7 10.5 7.67 10.5 8.5C10.5 9.11 10.04 10.59 12 12.5C13.96 10.59 13.5 9.11 13.5 8.5C13.5 7.67 12.83 7 12 7Z">
                                            </path>
                                        </svg>
                                        <span
                                            class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                            style="top: -5px; left: 15px; height: 20px; min-width: 20px;"
                                            id="sumWishlist">
                                            <c:out
                                                value="${sessionScope.wishlistSize != null ? sessionScope.wishlistSize : 0}" />
                                        </span>
                                    </a>
                                    <!-- User Dropdown -->
                                    <div class="dropdown my-auto">
                                        <a href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                            <i class="fas fa-user fa-2x"></i>
                                        </a>
                                        <ul class="dropdown-menu dropdown-menu-end p-4"
                                            aria-labelledby="dropdownMenuLink">
                                            <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                                <img style="width: 150px; height: 150px; border-radius: 50%;"
                                                    src="/images/avatar/${sessionScope.avatar}" alt="User Avatar" />
                                                <div class="text-center my-3">
                                                    <c:out value="${sessionScope.username}" />
                                                </div>
                                            </li>
                                            <li><a class="dropdown-item"
                                                    href="/customer/profile/${sessionScope.id}">Account Management</a>
                                            </li>
                                            <a href="/customer/order/tracking" class="dropdown-item">Order Management</a>
                                            <!-- <li><a class="dropdown-item" href="/order-history">Purchase History</a></li> -->
                                            <li>
                                                <hr class="dropdown-divider">
                                            </li>
                                            <li>
                                                <form method="post" action="/logout">
                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                        value="${_csrf.token}" />
                                                    <button class="dropdown-item">Log Out</button>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>
                                </c:if>
                                <c:if test="${empty pageContext.request.userPrincipal}">
                                    <a href="/login" class="a-login position-relative me-4 my-auto">Sign in</a>
                                    <a href="/register" class="a-login position-relative me-4 my-auto">Register</a>
                                </c:if>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
            <!-- Navbar End -->
        </body>

        </html>