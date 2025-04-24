<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Font Awesome for icons -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />

    <style>
      * {
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
        margin: 0;
        padding: 0;
      }

      body {
        /* background: url("/resources/images/background1.jpg") no-repeat
          center center fixed; */
        background-size: cover;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
      }

      .container {
        display: flex;
        width: 100%;
        max-width: 800px;
        height: 500px;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      }

      .left-side {
        flex: 1;
        background-color: #022bc0;
        background-size: cover;
        filter: opacity(0.9);
      }

      .left-side h2 {
        text-align: center;
        color: white;
        font-size: 50px;
        font-weight: bolder;
        padding-top: 150px;
      }

      .right-side {
        flex: 1;
        background: #fff;
        padding: 40px 30px;
        display: flex;
        flex-direction: column;
        justify-content: center;
      }

      .right-side h2 {
        font-weight: 600;
        color: #333;
        margin-bottom: 20px;
        text-align: center;
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
        color: #aaa;
        font-size: 16px;
      }

      .input-group input {
        width: 100%;
        padding: 10px 10px 10px 40px;
        border: 1px solid #ddd;
        border-radius: 25px;
        font-size: 14px;
        transition: border-color 0.3s ease;
      }

      .input-group input:focus {
        border-color: #007bff;
        outline: none;
      }

      .remember-me {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
      }

      .remember-me input {
        margin-right: 8px;
      }

      .remember-me label {
        font-size: 14px;
        color: #666;
      }

      .login-btn {
        width: 100%;
        padding: 12px;
        border: none;
        border-radius: 25px;
        background: #007bff;
        color: white;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.3s ease;
      }

      .login-btn:hover {
        background: #0056b3;
      }

      .links {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 15px 0;
        font-size: 14px;
      }

      .links a {
        color: #007bff;
        text-decoration: none;
      }

      .links a:hover {
        text-decoration: underline;
      }

      .social-login {
        display: flex;
        justify-content: space-between;
        gap: 10px;
      }

      .social-btn {
        flex: 1;
        padding: 10px;
        border: none;
        border-radius: 25px;
        color: white;
        font-size: 14px;
        cursor: pointer;
        transition: background 0.3s ease;
      }

      .social-btn.facebook {
        background: #3b5998;
      }

      .social-btn.facebook:hover {
        background: #2d4373;
      }

      .social-btn.google {
        background: #db4437;
      }

      .social-btn.google:hover {
        background: #c13528;
      }

      .social-btn.twitter {
        background: #1da1f2;
      }

      .social-btn.twitter:hover {
        background: #1a91da;
      }

      .register-link {
        text-align: center;
        margin-top: 15px;
        font-size: 14px;
      }

      .register-link a {
        color: #007bff;
        text-decoration: none;
      }

      .register-link a:hover {
        text-decoration: underline;
      }

      .msg {
        font-size: 14px;
        margin-bottom: 15px;
        padding: 10px;
        border-radius: 8px;
        text-align: center;
      }

      .msg.error {
        background: #ffe6e6;
        color: #d63031;
      }

      .msg.success {
        background: #e6ffed;
        color: #2ecc71;
      }

      .msg.warning {
        background: #fff3e0;
        color: #e67e22;
      }

      /* Responsive design */
      @media (max-width: 768px) {
        .container {
          flex-direction: column;
          height: auto;
          max-width: 400px;
          margin: 20px;
        }

        .left-side {
          display: none;
        }

        .right-side {
          padding: 30px 20px;
          border-radius: 20px;
        }

        .social-btn {
          font-size: 12px;
          padding: 8px;
        }
      }
    </style>

    <!-- Google Fonts for Poppins -->
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap"
      rel="stylesheet"
    />
  </head>

  <body>
    <div class="container">
      <div class="left-side">
        <h2>Welcome to Lego Shop!</h2>
      </div>
      <div class="right-side">
        <h2>Login to account</h2>

        <form method="post" action="/login">
          <c:if test="${param.error != null}">
            <div class="msg error">Email or Password is incorrect</div>
          </c:if>
          <c:if test="${param.logout != null}">
            <div class="msg success">Logout successful</div>
          </c:if>
          <c:if test="${param.resetsuccess != null}">
            <div class="msg success">Password changed successfully</div>
          </c:if>
          <c:if test="${param.locked != null}">
            <div class="msg warning">
              Account locked. Please contact support.
            </div>
          </c:if>
          <c:if test="${param.registersuccess != null}">
            <div class="msg success">Register successfully</div>
          </c:if>

          <div class="input-group">
            <i class="fa fa-envelope"></i>
            <input
              type="email"
              name="username"
              placeholder="Email Address"
              required
            />
          </div>

          <div class="input-group">
            <i class="fa fa-lock"></i>
            <input
              type="password"
              name="password"
              placeholder="Password"
              required
            />
          </div>

          <!-- <div class="remember-me">
            <input type="checkbox" id="rememberMe" name="remember-me" />
            <label for="rememberMe">Remember me</label>
          </div> -->

          <input
            type="hidden"
            name="${_csrf.parameterName}"
            value="${_csrf.token}"
          />

          <button type="submit" class="login-btn">Login</button>

          <div class="links">
            <a href="/forgotpassword">Forgot Password?</a>
          </div>

          <div class="register-link">
            <span>Don't have an account? </span>
            <a href="/register">Register here</a><br /><br />
            <a href="/">Click here to view HOME PAGE!</a>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
