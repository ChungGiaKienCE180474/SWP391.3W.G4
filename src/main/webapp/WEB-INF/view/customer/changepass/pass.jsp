<%@ page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Change Password</title>
    <link rel="icon" type="image/png" href="../../images/icon-logo.png" />

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
      rel="stylesheet"
    />

    <!-- Icon Fonts -->
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />

    <!-- Libraries -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link
      href="/client/lib/owlcarousel/assets/owl.carousel.min.css"
      rel="stylesheet"
    />

    <!-- Bootstrap & Custom CSS -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/client/css/style.css" rel="stylesheet" />
  </head>

  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />

    <div class="container my-5 pt-5">
      <main>
        <div class="container-fluid px-4">
          <h1 class="mt-4">Change Password</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item">
              <a href="/customer/profile/${id}">Customer Profile</a>
            </li>
            <li class="breadcrumb-item active">Change Password</li>
          </ol>

          <div class="mt-5">
            <div class="row">
              <div class="col-md-6 col-12 mx-auto">
                <h3>Update Your Password</h3>
                <hr />

                <!-- Success and Error Messages -->
                <c:if test="${not empty successMessage}">
                  <div class="alert alert-success" role="alert">
                    ${successMessage}
                  </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                  <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                  </div>
                </c:if>

                <!-- Password Change Form -->
                <form:form
                  method="post"
                  action="/customer/changepass"
                  modelAttribute="passwordChangeForm"
                  class="row"
                >
                  <div class="mb-3 col-12 position-relative">
                    <label class="form-label">Current Password:</label>
                    <form:input
                      id="currentPassword"
                      type="password"
                      path="currentPassword"
                      class="form-control"
                    />
                    <form:errors
                      path="currentPassword"
                      cssClass="invalid-feedback"
                    />
                    <i
                      class="bi bi-eye-slash position-absolute top-50 me-2"
                      id="toggleCurrentPassword"
                      style="cursor: pointer; right: 1rem"
                    ></i>
                  </div>

                  <div class="mb-3 col-12 position-relative">
                    <label class="form-label">New Password:</label>
                    <form:input
                      id="newPassword"
                      type="password"
                      path="newPassword"
                      class="form-control"
                    />
                    <form:errors
                      path="newPassword"
                      cssClass="invalid-feedback"
                    />
                    <i
                      class="bi bi-eye-slash position-absolute top-50 me-2"
                      id="toggleNewPassword"
                      style="cursor: pointer; right: 1rem"
                    ></i>
                  </div>

                  <div class="mb-3 col-12 position-relative">
                    <label class="form-label">Confirm New Password:</label>
                    <form:input
                      id="confirmPassword"
                      type="password"
                      path="confirmPassword"
                      class="form-control"
                    />
                    <form:errors
                      path="confirmPassword"
                      cssClass="invalid-feedback"
                    />
                    <i
                      class="bi bi-eye-slash position-absolute top-50 me-2"
                      id="toggleConfirmPassword"
                      style="cursor: pointer; right: 1rem"
                    ></i>
                  </div>

                  <div class="col-12 mb-5">
                    <button type="submit" class="btn btn-primary">
                      Change Password
                    </button>
                    <a href="/customer/profile/${id}" class="btn btn-secondary"
                      >Back</a
                    >
                  </div>
                </form:form>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>

    <!-- Modal -->
    <div
      class="modal fade"
      id="passwordChangeSuccessModal"
      tabindex="-1"
      aria-labelledby="passwordChangeSuccessModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="passwordChangeSuccessModalLabel">
              Password Change Successful
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            Your password has been successfully changed. Please log in again
            with your new password.
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" id="redirectToLogin">
              OK
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      function togglePasswordVisibility(passwordFieldId, toggleButtonId) {
        document
          .getElementById(toggleButtonId)
          .addEventListener("click", function () {
            var passwordField = document.getElementById(passwordFieldId);
            var type = passwordField.type === "password" ? "text" : "password";
            passwordField.type = type;
            this.classList.toggle("bi-eye");
            this.classList.toggle("bi-eye-slash");
          });
      }

      togglePasswordVisibility("currentPassword", "toggleCurrentPassword");
      togglePasswordVisibility("newPassword", "toggleNewPassword");
      togglePasswordVisibility("confirmPassword", "toggleConfirmPassword");

      // Show modal if password changed successfully
      window.addEventListener("load", function () {
        var successMessage = "${successMessage}";
        if (
          successMessage &&
          successMessage !== "null" &&
          successMessage.trim() !== ""
        ) {
          var myModal = new bootstrap.Modal(
            document.getElementById("passwordChangeSuccessModal"),
            {
              keyboard: false,
            }
          );
          myModal.show();
        }
      });

      document
        .getElementById("redirectToLogin")
        .addEventListener("click", function () {
          window.location.href = "/customer/profile/${id}";
        });
    </script>
  </body>
</html>
