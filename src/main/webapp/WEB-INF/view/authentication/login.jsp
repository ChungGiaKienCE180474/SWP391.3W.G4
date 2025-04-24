<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Login</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <!-- Font Awesome for icons -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

                <style>
                    * {
                        box-sizing: border-box;
                        font-family: 'Segoe UI', sans-serif;
                        margin: 0;
                        padding: 0;
                    }

                    body {
                        background: url('/images/login-background.jpg') no-repeat center center fixed;
                        background-size: cover;
                        height: 100vh;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                    }

                    .login-card {
                        background: rgba(255, 255, 255, 0.95);
                        padding: 40px 30px;
                        border-radius: 15px;
                        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);
                        width: 100%;
                        max-width: 400px;
                    }

                    .login-card h2 {
                        text-align: center;
                        margin-bottom: 20px;
                        font-weight: 700;
                        color: #333;
                    }

                    .input-group {
                        position: relative;
                        margin-bottom: 20px;
                    }

                    .input-group i {
                        position: absolute;
                        top: 50%;
                        left: 12px;
                        transform: translateY(-50%);
                        color: #777;
                    }

                    .input-group input {
                        width: 100%;
                        padding: 12px 12px 12px 40px;
                        border: 1px solid #ccc;
                        border-radius: 10px;
                        font-size: 14px;
                        transition: border-color 0.3s ease;
                    }

                    .input-group input:focus {
                        border-color: #007bff;
                        outline: none;
                    }

                    .login-card button {
                        width: 100%;
                        padding: 12px;
                        border: none;
                        border-radius: 10px;
                        background: linear-gradient(to right, #007bff, #4dabf7);
                        color: white;
                        font-size: 16px;
                        font-weight: bold;
                        cursor: pointer;
                        transition: 0.3s;
                    }

                    .login-card button:hover {
                        background: linear-gradient(to right, #0056b3, #339af0);
                    }

                    .login-card a {
                        display: block;
                        text-align: center;
                        margin-top: 10px;
                        font-size: 14px;
                        color: #007bff;
                        text-decoration: none;
                    }

                    .login-card a:hover {
                        text-decoration: underline;
                    }

                    .msg {
                        font-size: 14px;
                        margin-bottom: 12px;
                        text-align: center;
                    }
                </style>
            </head>

            <body>
                <div class="login-card">
                    <h2>Welcome</h2>

                    <form method="post" action="/login">
                        <c:if test="${param.error != null}">
                            <div class="msg" style="color: red;">Email or Password is incorrect</div>
                        </c:if>
                        <c:if test="${param.logout != null}">
                            <div class="msg" style="color: green;">Logout successful</div>
                        </c:if>
                        <c:if test="${param.resetsuccess != null}">
                            <div class="msg" style="color: green;">Password changed successfully</div>
                        </c:if>
                        <c:if test="${param.locked != null}">
                            <div class="msg" style="color: orange;">Account locked. Please contact support.</div>
                        </c:if>
                        <c:if test="${param.registersuccess != null}">
                            <div class="msg" style="color: green;">Register successfully</div>
                        </c:if>

                        <div class="input-group">
                            <i class="fa fa-envelope"></i>
                            <input type="email" name="username" placeholder="Email Address" required />
                        </div>

                        <div class="input-group">
                            <i class="fa fa-lock"></i>
                            <input type="password" name="password" placeholder="Password" required />
                        </div>

                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <button type="submit">Sign In</button>

                        <a href="/forgotpassword">Forgot Password?</a>
                        <a href="/register">Register</a>
                        <a href="/">Back to Home</a>
                    </form>
                </div>
            </body>

            </html>