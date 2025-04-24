<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <div class="p-3 d-flex flex-column align-items-center"
            style="width: 250px; min-height: 100vh; background-color: #020101;">
            <img src="/images/logo.jpg" alt="Logo" class="logo mb-4"
                style="width: 160px; height: auto; display: block; margin: 0 auto;">
            <ul class="list-unstyled w-100">

                <li><a href="/employee/product" class="btn btn-light w-100 text-start mb-3"><i
                            class="bi bi-clipboard-fill"></i> Manage Product</a></li>
                <li><a href="/employee/order" class="btn btn-light w-100 text-start mb-3"><i
                            class="bi bi-clipboard-fill"></i> Manage Order</a></li>
                <li><a href="/employee/profile/${sessionScope.id}" class="btn btn-light w-100 text-start mb-3"><i
                            class="bi bi-calendar-fill"></i> Employee Profile</a></li>
                <form method="post" action="/logout">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button class="btn btn-danger w-100 text-start"><a><i class="bi bi-box-arrow-right"></i>

                            Log Out</a></button>
                </form>

                </li>
            </ul>
        </div>