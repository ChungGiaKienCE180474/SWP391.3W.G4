<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Register</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
    />
    <style>
      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        font-family: "Segoe UI", sans-serif;
        background: #f3f4f6;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }

      .container {
        display: flex;
        width: 900px;
        background: #fff;
        border-radius: 20px;
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        overflow: hidden;
      }

      .left-panel {
        flex: 1;
        background-color: #1e40af;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px;
        flex-direction: column;
      }

      .left-panel h1 {
        font-size: 36px;
        text-align: center;
      }

      .right-panel {
        flex: 1;
        padding: 40px;
      }

      h3 {
        text-align: center;
        margin-bottom: 20px;
        font-size: 24px;
      }

      .form-group {
        margin-bottom: 16px;
        position: relative;
      }

      .form-group i {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #888;
      }

      .form-control {
        width: 100%;
        padding: 12px 12px 12px 40px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 16px;
      }

      .btn-register {
        width: 100%;
        padding: 14px;
        background-color: #2563eb;
        color: white;
        font-size: 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
      }

      .btn-register:hover {
        background-color: #1e40af;
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
        color: #2563eb;
        text-decoration: none;
      }

      .form-footer a:hover {
        text-decoration: underline;
      }
    </style>
  </head>

  <body>
    <div class="container">
      <div class="left-panel">
        <h1>Welcome to<br />Lego Shop!</h1>
      </div>
      <div class="right-panel">
        <h3>Create Account</h3>

        <c:if test="${param.exist != null}">
          <div class="error-message">
            Email already registered. Please try to login.
          </div>
        </c:if>
        <c:if test="${param.password != null}">
          <div class="error-message">
            Password and ConfirmPassword must match.
          </div>
        </c:if>

        <form:form
          method="post"
          action="/register"
          modelAttribute="registerUser"
        >
          <div class="form-group">
            <i class="fas fa-user"></i>
            <form:input
              path="firstName"
              type="text"
              placeholder="First Name"
              cssClass="form-control"
            />
            <form:errors path="firstName" cssClass="error-message" />
          </div>
          <div class="form-group">
            <i class="fas fa-user"></i>
            <form:input
              path="lastName"
              type="text"
              placeholder="Last Name"
              cssClass="form-control"
            />
            <form:errors path="lastName" cssClass="error-message" />
          </div>
          <div class="form-group">
            <i class="fas fa-envelope"></i>
            <form:input
              path="email"
              type="email"
              placeholder="Email"
              cssClass="form-control"
            />
            <form:errors path="email" cssClass="error-message" />
          </div>
          <div class="form-group">
            <i class="fas fa-lock"></i>
            <form:input
              path="password"
              type="password"
              placeholder="Password"
              cssClass="form-control"
            />
            <i
              style="position: absolute; left: 340px"
              class="fa fa-eye toggle-password"
              onclick="togglePassword(this)"
            ></i>
            <form:errors path="password" cssClass="error-message" />
          </div>
          <div class="form-group">
            <i class="fas fa-lock"></i>
            <form:input
              path="confirmPassword"
              type="password"
              placeholder="Confirm Password"
              cssClass="form-control"
            />
            <i
              style="position: absolute; left: 340px"
              class="fa fa-eye toggle-password"
              onclick="togglePassword(this)"
            ></i>
            <form:errors path="confirmPassword" cssClass="error-message" />
          </div>
          <div class="form-group">
            <i class="fas fa-phone"></i>
            <form:input
              path="phone"
              type="text"
              placeholder="Phone Number"
              cssClass="form-control"
            />
            <form:errors path="phone" cssClass="error-message" />
          </div>
          <div class="form-group">
            <i class="fas fa-location-dot"></i>
            <form:input
              path="address"
              type="text"
              placeholder="Address"
              cssClass="form-control"
            />
            <form:errors path="address" cssClass="error-message" />
          </div>

          <button class="btn-register">Create Account</button>
        </form:form>

        <div class="form-footer">
          <div class="small">
            <a href="/login">Already have an account? Login here</a>
          </div>
        </div>
      </div>
    </div>
  </body>
  <script>
    function togglePassword(icon) {
      const passwordInput = document.getElementById("password");
      if (passwordInput.type === "password") {
        passwordInput.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
      } else {
        passwordInput.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
      }
    }
  </script>
</html>
