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
                <link rel="stylesheet" href="/css/style.css" />
                <title>Trang Đăng Nhập</title>
            </head>

            <body>
                <div class="container" id="container">
                    <div>

                    </div>
                    <div class="form-container sign-in">


                        <form method="post" action="/login">

                            <h1>Sign In</h1>
                            <c:if test="${param.error != null}">
                                <div class="my-2" style="color: red;">Email or Password is incorrect</div>
                            </c:if>
                            <c:if test="${param.logout != null}">
                                <div class="my-2" style="color: green;">Logout successful</div>
                            </c:if>

                            <c:if test="${param.resetsuccess != null}">
                                <div class="my-2" style="color: green;">Password changed successfully</div>
                            </c:if>

                            <c:if test="${param.locked != null}">
                                <div class="d-flex justify-content-center my-2">
                                    <div style="color: orange; text-align: center;">
                                        Your account has been deleted for violating the rules. Please contact us for more information
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${param.registersuccess != null}">
                                <div class="my-2" style="color: green;">Register successfully</div>
                            </c:if>


                            <input type="email" placeholder="Email Address" name="username" />
                            <input type="password" placeholder="Password" name="password" />

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <a href="/forgotpassword">Forgot Password?</a>

                            <button>Sign In</button>
<%--                            <div class="google-login">--%>
<%--                                <a href="${pageContext.request.contextPath}/oauth2/authorization/google" class="btn-google">--%>
<%--                                    <i class="fab fa-google"></i> Login with Google--%>
<%--                                </a>--%>
<%--                            </div>--%>


                        </form>


                    </div>
                    <div class="toggle-container">
                        <div class="toggle">
                            <div class="toggle-panel toggle-right">
                                <h1>Hi there!</h1>
                                <p>
                                    Register with your personal information to use all the features of the site
                                </p>
                                <a href="/register"><button class="hidden" id="register">Register</button></a>
                                <a href="/"><button class="hidden" id="register">Back</button></a>

                            </div>
                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/script.js"></script>
            </body>

            </html>