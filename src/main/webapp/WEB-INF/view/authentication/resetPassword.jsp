<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Reset Password</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: "Segoe UI", sans-serif;
      }

      .card {
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
      }

      .form-control {
        padding-left: 40px;
      }

      .password-toggle {
        position: relative;
      }

      .password-toggle .fa-eye,
      .password-toggle .fa-eye-slash {
        position: absolute;
        top: 75%;
        left: 10px;
        transform: translateY(-50%);
        color: #aaa;
        cursor: pointer;
      }

      .form-label {
        font-weight: 500;
      }
    </style>
  </head>

  <body>
    <div class="card p-5" style="width: 100%; max-width: 500px">
      <h3 class="text-center mb-4">🔒 Reset Your Password</h3>

      <c:if test="${param.invalidpassword != null}">
        <div class="alert alert-danger">
          Password and Confirm Password must match.
        </div>
      </c:if>
      <c:if test="${param.shortpassword != null}">
        <div class="alert alert-warning">
          Password must be at least 6 characters long.
        </div>
      </c:if>
      <c:if test="${param.invalidspace != null}">
        <div class="alert alert-danger">
          Password cannot contain only spaces or repeated spaces.
        </div>
      </c:if>

      <form:form
        method="post"
        action="/authentication/resetPassword"
        modelAttribute="resetPasswordForm"
      >
        <div class="mb-3 password-toggle">
          <label for="password" class="form-label">New Password</label>
          <i class="fa fa-eye" onclick="togglePassword('password')"></i>
          <form:input
            path="password"
            id="password"
            type="password"
            class="form-control"
            placeholder="Enter new password"
            required="required"
            autocomplete="off"
          />
        </div>

        <div class="mb-3 password-toggle">
          <label for="confPassword" class="form-label">Confirm Password</label>
          <i class="fa fa-eye" onclick="togglePassword('confPassword')"></i>
          <form:input
            path="confPassword"
            id="confPassword"
            type="password"
            class="form-control"
            placeholder="Confirm new password"
            required="required"
            autocomplete="off"
          />
        </div>

        <input
          type="hidden"
          name="${_csrf.parameterName}"
          value="${_csrf.token}"
        />

        <button type="submit" class="btn btn-success w-100">
          Update Password
        </button>
      </form:form>
    </div>

    <script>
      function togglePassword(id) {
        const input = document.getElementById(id);
        const icon = input.previousElementSibling;
        const isPassword = input.type === "password";

        input.type = isPassword ? "text" : "password";
        icon.classList.toggle("fa-eye");
        icon.classList.toggle("fa-eye-slash");
      }
    </script>
  </body>
</html>
