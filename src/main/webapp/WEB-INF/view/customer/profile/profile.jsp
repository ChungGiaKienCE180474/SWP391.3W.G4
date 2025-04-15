<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Profile</title>
    <!-- CSS -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div class="container my-5 pt-5">
        <div class="d-flex justify-content-between align-items-center">
            <h3>Customer Profile</h3>
            <a href="/customer/changepass" class="btn btn-primary">Change Password</a>
        </div>
        <hr />
        <!-- Display backend messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <div class="row">
            <div class="col-md-6 mx-auto">
                <form:form method="post" action="/customer/profile/update" modelAttribute="newUser"
                           enctype="multipart/form-data" class="row g-3">
                    <form:input type="hidden" path="id" />
                    <!-- Email (display-only) -->
                    <div class="mb-3">
                        <label for="emailDisplay" class="form-label">Email</label>
                        <input id="emailDisplay" class="form-control" value="${newUser.email}" disabled="true" />
                    </div>
                    <!-- Phone -->
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <form:input id="phone" path="phone" class="form-control" />
                        <form:errors path="phone" cssClass="invalid-feedback" />
                    </div>
                    <!-- Full Name -->
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <form:input id="fullName" path="fullName" class="form-control" />
                        <form:errors path="fullName" cssClass="invalid-feedback" />
                    </div>
                    <!-- Address -->
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <form:input id="address" path="address" class="form-control" />
                        <form:errors path="address" cssClass="invalid-feedback" />
                    </div>
                    <!-- Avatar -->
                    <div class="mb-3">
                        <label for="avatarFile" class="form-label">Avatar</label>
                        <input type="file" id="avatarFile" class="form-control" name="imagesFile" accept=".png, .jpg, .jpeg" />
                        <img id="avatarPreview" class="img-thumbnail mt-3" style="display: none;" />
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <!-- JavaScript -->
    <script>
        $(document).ready(() => {
            // Avatar preview
            const avatarFile = $("#avatarFile");
            const orgImage = "${newUser.avatar}";
            if (orgImage) {
                const urlImage = "/images/avatar/" + orgImage;
                $("#avatarPreview").attr("src", urlImage).show();
            } else {
                $("#avatarPreview").hide();
            }
            avatarFile.change(function (e) {
                if (e.target.files && e.target.files[0]) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL).show();
                }
            });
    
            // Form validation
            $("form").on("submit", function(e) {
                let isValid = true;
    
                // Validate phone
                const phoneInput = $("#phone");
                const phone = phoneInput.val().trim();
                const phoneRegex = /^0[0-9]{9}$/; // Must start with 0 and be exactly 10 digits
                if (!phoneRegex.test(phone)) {
                    isValid = false;
                    showError(phoneInput, "Phone number must start with 0 and be exactly 10 digits.");
                } else {
                    hideError(phoneInput);
                }
    
                // Validate full name
                const fullnameInput = $("#fullName");
                const fullname = fullnameInput.val().trim();
                if (fullname.length < 3) {
                    isValid = false;
                    showError(fullnameInput, "Fullname must be at least 3 characters long.");
                } else {
                    hideError(fullnameInput);
                }
    
                // Validate address
                const addressInput = $("#address");
                const address = addressInput.val().trim();
                if (address.length < 5) {
                    isValid = false;
                    showError(addressInput, "Address must be at least 5 characters long.");
                } else {
                    hideError(addressInput);
                }
    
                if (!isValid) {
                    e.preventDefault();
                }
    
                function showError(input, message) {
                    input.addClass("is-invalid");
                    let feedback = input.siblings(".invalid-feedback");
                    if (!feedback.length) {
                        feedback = $('<div class="invalid-feedback"></div>').insertAfter(input);
                    }
                    feedback.text(message).show();
                }
    
                function hideError(input) {
                    input.removeClass("is-invalid");
                    input.siblings(".invalid-feedback").hide();
                }
            });
        });
    </script>
    
</body>
</html>
