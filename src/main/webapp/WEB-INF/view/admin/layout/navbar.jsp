<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- bi bi-person-fill
    bi bi-box-fill
    bi bi-clipboard-fill
    bi bi-tags-fill -->
        <div class="p-3 d-flex flex-column align-items-center"
            style="width: 250px; min-height: 100vh; background-color: #020101;">
            <img src="/images/logo.jpg" alt="Logo" class="logo mb-4"
                style="width: 160px; height: auto; display: block; margin: 0 auto;">
            <ul class="list-unstyled w-100">
                <li><a href="/admin" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-house-fill"></i>
                        Home Page</a></li>
                <li><a href="/admin/category" class=" btn btn-light w-100 text-start mb-3"><i
                            class="bi bi-tags-fill"></i>
                        Category Management</a></li>
                <li><a href="/admin/product" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-box-fill"></i>
                        Product Management</a></li>
                <%-- <li><a href="/admin/user" class="btn btn-light w-100 text-start mb-3"><i
                            class="bi bi-person-fill"></i>--%>
                        <%-- User Management</a></li>--%>
                            <li><a href="/admin/customer" class="btn btn-light w-100 text-start mb-3"><i
                                        class="bi bi-person-fill"></i> Customer Management</a></li>
                            <li><a href="/admin/employee" class="btn btn-light w-100 text-start mb-3"><i
                                        class="bi bi-person-fill"></i> Employee Management</a></li>
                            <li><a href="/admin/order" class="btn btn-light w-100 text-start mb-3"><i
                                        class="bi bi-box-fill"></i> Order Management</a></li>
                            <li><a href="/admin/profile/${sessionScope.id}"
                                    class="btn btn-light w-100 text-start mb-3"><i class="bi bi-person-fill"></i>
                                    Profile Management</a></li>

                            <li><a href="/admin/contact" class="btn btn-light w-100 text-start mb-3"><i
                                        class="bi bi-clipboard-fill"></i> View Contact</a></li>
                            <li><a href="/admin/news" class="btn btn-light w-100 text-start mb-3"><i
                                        class="bi bi-newspaper"></i> News Management</a></li>



                            <li>
                                <form method="post" action="/logout">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button class="btn btn-danger w-100 text-start"><a><i
                                                class="bi bi-box-arrow-right"></i>
                                            Log Out</a></button>
                                </form>
                            </li>
            </ul>
        </div>