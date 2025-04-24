<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
                <title>Register Page</title>
                <style>
                    body {
                        margin: 0;
                        padding: 0;
                        background: #f3f4f6;
                        font-family: "Arial", sans-serif;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        height: 100vh;
                    }

                    .register-container {
                        background: #ffffff;
                        padding: 32px;
                        border-radius: 10px;
                        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
                        width: 100%;
                        max-width: 480px;
                    }

                    .register-container h3 {
                        font-size: 24px;
                        font-weight: bold;
                        text-align: center;
                        margin-bottom: 20px;
                        color: #333;
                    }

                    .form-group {
                        margin-bottom: 18px;
                    }

                    .form-control {
                        width: 100%;
                        padding: 12px;
                        border-radius: 8px;
                        border: 1px solid #d1d5db;
                        font-size: 16px;
                        box-sizing: border-box;
                    }

                    .form-control:focus {
                        outline: none;
                        border-color: #4caf50;
                        box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
                    }

                    .btn-register {
                        width: 100%;
                        padding: 14px;
                        background-color: #4caf50;
                        color: white;
                        border-radius: 8px;
                        border: none;
                        font-size: 16px;
                        cursor: pointer;
                        transition: background-color 0.3s;
                    }

                    .btn-register:hover {
                        background-color: #45a049;
                    }

                    .error-message {
                        color: #ff4d4d;
                        font-size: 14px;
                        margin-top: 4px;
                    }

                    .form-footer {
                        text-align: center;
                        margin-top: 16px;
                    }

                    .form-footer a {
                        color: #4caf50;
                        text-decoration: none;
                        font-size: 14px;
                    }

                    .form-footer a:hover {
                        text-decoration: underline;
                    }
                </style>
            </head>

            <body>
                <div id="layoutAuthentication">
                    <div id="layoutAuthentication_content">
                        <main>
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-lg-7">
                                        <div class="register-container">
                                            <h3>Create Account</h3>
                                            <c:if test="${param.exist != null}">
                                                <div class="error-message">Email already registered. Please try to
                                                    login.</div>
                                            </c:if>
                                            <c:if test="${param.password != null}">
                                                <div class="error-message">Password and ConfirmPassword must match.
                                                </div>
                                            </c:if>

                                            <form:form method="post" action="/register" modelAttribute="registerUser">
                                                <c:set var="errorFirstName">
                                                    <form:errors path="firstName" cssClass="error-message" />
                                                </c:set>
                                                <c:set var="errorLastName">
                                                    <form:errors path="lastName" cssClass="error-message" />
                                                </c:set>
                                                <c:set var="errorEmail">
                                                    <form:errors path="email" cssClass="error-message" />
                                                </c:set>
                                                <c:set var="errorPassword">
                                                    <form:errors path="password" cssClass="error-message" />
                                                </c:set>
                                                <c:set var="errorConfirmPassword">
                                                    <form:errors path="confirmPassword" cssClass="error-message" />
                                                </c:set>
                                                <c:set var="errorPhone">
                                                    <form:errors path="phone" cssClass="error-message" />
                                                </c:set>
                                                <c:set var="errorAddress">
                                                    <form:errors path="address" cssClass="error-message" />
                                                </c:set>

                                                <div class="form-group">
                                                    <form:input
                                                        class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}"
                                                        type="text" placeholder="First Name" path="firstName" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input
                                                        class="form-control ${not empty errorLastName ? 'is-invalid' : ''}"
                                                        type="text" placeholder="Last Name" path="lastName" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input
                                                        class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                        type="email" placeholder="Email" path="email" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input
                                                        class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                        type="password" placeholder="Password" path="password" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input
                                                        class="form-control ${not empty errorConfirmPassword ? 'is-invalid' : ''}"
                                                        type="password" placeholder="Confirm Password"
                                                        path="confirmPassword" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input
                                                        class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                                                        type="text" placeholder="Phone Number" path="phone" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input
                                                        class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                                                        type="text" placeholder="Address" path="address" />
                                                </div>

                                                <div class="form-footer">
                                                    <button class="btn-register">Create Account</button>
                                                </div>
                                            </form:form>

                                            <div class="form-footer">
                                                <div class="small"><a href="/login">Already have an account? Login
                                                        here</a></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                    </div>
                </div>
            </body>

            </html>