<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="Group 4 - Dự án LegoStore" />
    <meta name="author" content="Group 4" />
    <title>Create Users</title>
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
      $(document).ready(() => {
        const avatarFile = $("#avatarFile");
        avatarFile.change(function (e) {
          const imgURL = URL.createObjectURL(e.target.files[0]);
          $("#avatarPreview").attr("src", imgURL);
          $("#avatarPreview").css({ display: "block" });
        });
      });
    </script>
  </head>

  <body class="sb-nav-fixed">
    <div id="layoutSidenav">
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Dashboard</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
              <li class="breadcrumb-item">
                <a href="/admin/customer">Customers</a>
              </li>
              <li class="breadcrumb-item active">Create</li>
            </ol>
            <div class="mt-5">
              <div class="row">
                <div class="col-md-6 col-12 mx-auto">
                  <h3>Create a Customer</h3>
                  <hr />
                  <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" role="alert">
                      ${successMessage}
                    </div>
                  </c:if>

                  <form:form
                    method="post"
                    action="/admin/customer/create"
                    modelAttribute="newCustomer"
                    class="row"
                    enctype="multipart/form-data"
                  >
                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Email:</label>
                      <form:input
                        type="email"
                        class="form-control ${not empty emailError or not empty emailExistError ? 'is-invalid' : ''}"
                        path="email"
                      />
                      <c:if test="${not empty emailError}">
                        <div class="invalid-feedback">${emailError}</div>
                      </c:if>
                      <c:if test="${not empty emailExistError}">
                        <div class="invalid-feedback">${emailExistError}</div>
                      </c:if>
                    </div>

                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Password:</label>
                      <form:input
                        type="password"
                        class="form-control ${not empty passwordError ? 'is-invalid' : ''}"
                        path="password"
                      />
                      <c:if test="${not empty passwordError}">
                        <div class="invalid-feedback">${passwordError}</div>
                      </c:if>
                    </div>

                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Phone number:</label>
                      <form:input
                        type="text"
                        class="form-control ${not empty phoneError ? 'is-invalid' : ''}"
                        path="phone"
                      />
                      <c:if test="${not empty phoneError}">
                        <div class="text-danger">${phoneError}</div>
                      </c:if>
                    </div>

                    <div class="mb-3 col-12 col-md-6">
                      <label class="form-label">Full Name:</label>
                      <form:input
                        type="text"
                        class="form-control ${not empty fullNameError ? 'is-invalid' : ''}"
                        path="fullName"
                      />
                      <c:if test="${not empty fullNameError}">
                        <div class="invalid-feedback">${fullNameError}</div>
                      </c:if>
                    </div>

                    <div class="mb-3 col-12">
                      <c:set var="errorAddress">
                        <form:errors
                          path="address"
                          cssClass="invalid-feedback"
                        />
                      </c:set>

                      <label class="form-label">Address:</label>
                      <form:input
                        type="text"
                        class="form-control ${not empty errorAddress or not empty addressError ? 'is-invalid' : ''}"
                        path="address"
                      />
                      ${errorAddress}

                      <c:if test="${not empty addressError}">
                        <div class="text-danger">${addressError}</div>
                      </c:if>
                    </div>

                    <div class="mb-3 col-12 col-md-6" style="display: none">
                      <label class="form-label">Role:</label>
                      <form:select class="form-select" path="role.name">
                        <form:option value="CUSTOMER">CUSTOMER</form:option>
                      </form:select>
                    </div>
                    <div class="mb-3 col-12 col-md-6">
                      <label for="avatarFile" class="form-label">Avatar:</label>
                      <input
                        class="form-control"
                        type="file"
                        id="avatarFile"
                        accept=".png, .jpg, .jpeg"
                        name="imagesFile"
                      />
                    </div>
                    <div class="col-12 mb-3">
                      <img
                        style="max-height: 250px; display: none"
                        alt="avatar preview"
                        id="avatarPreview"
                      />
                    </div>
                    <div class="col-12 mb-5">
                      <button type="submit" class="btn btn-primary">
                        Create
                      </button>
                    </div>
                  </form:form>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/scripts.js"></script>
  </body>
</html>
