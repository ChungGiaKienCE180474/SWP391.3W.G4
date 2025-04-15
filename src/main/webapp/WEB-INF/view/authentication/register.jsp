<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <link rel="stylesheet" href="/css/register.css" />
    <title>Register Page</title>
</head>
<body class="bg-primary">
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-7">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header">
                                <h3 class="text-center font-weight-light my-4">Create Account</h3>
                                <c:if test="${param.exist != null}">
                                    <div class="my-2" style="color: red;">Email already registered. Please try to login.</div>
                                </c:if>
                                <c:if test="${param.password != null}">
                                    <div class="my-2" style="color: red;">Password and ConfirmPassword must match</div>
                                </c:if>
                            </div>
                            <div class="card-body">
                                <form:form method="post" action="/register" modelAttribute="registerUser">
                                    <c:set var="errorPassword">
                                        <form:errors path="password" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorConfirmPassword">
                                        <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorEmail">
                                        <form:errors path="email" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorFirstName">
                                        <form:errors path="firstName" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorLastName">
                                        <form:errors path="lastName" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorPasswordMatching">
                                        <form:errors path="passwordMatching" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorAddress">
                                        <form:errors path="address" cssClass="invalid-feedback" />
                                    </c:set>
                                    <c:set var="errorPhone">
                                        <form:errors path="phone" cssClass="invalid-feedback" />
                                    </c:set>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <form:input
                                                        class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}"
                                                        type="text" placeholder="Enter your first name"
                                                        path="firstName" />
                                                <label for="inputFirstName">First name</label>
                                                ${errorFirstName}
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <form:input
                                                        class="form-control ${not empty errorLastName ? 'is-invalid' : ''}"
                                                        type="text" placeholder="Enter your last name"
                                                        path="lastName" />
                                                <label for="inputLastName">Last name</label>
                                                ${errorLastName}
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-floating mb-3">
                                        <form:input
                                                class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                type="email" 
                                                placeholder="name@example.com" 
                                                path="email" 
                                                pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                                                title="Email must be in valid format, for example: name@domain.com"
                                                required="true" />
                                        <label>Email address</label>
                                        <c:if test="${not empty errorEmail}">
                                            <div class="invalid-feedback">${errorEmail}</div>
                                        </c:if>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <form:input
                                                        class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                        type="password" placeholder="Create a password"
                                                        path="password" />
                                                <label>Password</label>
                                                <form:errors path="password" cssClass="invalid-feedback" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <form:input
                                                        class="form-control ${not empty errorConfirmPassword ? 'is-invalid' : ''}"
                                                        type="password" placeholder="Confirm password"
                                                        path="confirmPassword" />
                                                <label>Confirm Password</label>
                                                <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                                <div class="invalid-feedback ${not empty errorPasswordMatching ? 'd-block' : ''}">
                                                    ${errorPasswordMatching}
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Thêm trường phone -->
                                    <div class="form-floating mb-3">
                                        <form:input
                                                class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                                                type="text" 
                                                placeholder="Enter your phone number" 
                                                path="phone" 
                                                id="phoneInput"
                                                required="true" />
                                        <label for="phoneInput">Phone Number</label>
                                        <c:if test="${not empty errorPhone}">
                                            <div class="invalid-feedback">${errorPhone}</div>
                                        </c:if>
                                    </div>

                                    <!-- Thêm trường address -->
                                    <div class="form-floating mb-3">
                                        <form:input
                                                class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                                                type="text" placeholder="Enter your address"
                                                path="address" />
                                        <label>Address</label>
                                        ${errorAddress}
                                    </div>

                                    <div class="mt-4 mb-0">
                                        <div class="d-grid">
                                            <button class="btn btn-primary btn-block">Create</button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small"><a href="/login">Already have an account? Back to login</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        // Validation email
        const emailInput = document.querySelector('input[name="email"]');
        const email = emailInput.value;
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        
        if (!emailRegex.test(email)) {
            e.preventDefault();
            emailInput.classList.add('is-invalid');
            let feedback = emailInput.nextElementSibling.nextElementSibling;
            if (!feedback || !feedback.classList.contains('invalid-feedback')) {
                feedback = document.createElement('div');
                feedback.classList.add('invalid-feedback');
                emailInput.parentNode.appendChild(feedback);
            }
            feedback.innerHTML = 'Email must be in valid format, for example: name@domain.com';
            feedback.style.display = 'block';
        } else {
            emailInput.classList.remove('is-invalid');
            let feedback = emailInput.nextElementSibling.nextElementSibling;
            if (feedback) feedback.style.display = 'none';
        }

        // Validation phone
        const phoneInput = document.querySelector('input[name="phone"]');
        const phone = phoneInput.value;
        const phoneRegex = /^0\d{9}$/; // Bắt đầu bằng 0, đủ 10 số
        
        if (!phoneRegex.test(phone)) {
            e.preventDefault();
            phoneInput.classList.add('is-invalid');
            let feedback = phoneInput.nextElementSibling.nextElementSibling;
            if (!feedback || !feedback.classList.contains('invalid-feedback')) {
                feedback = document.createElement('div');
                feedback.classList.add('invalid-feedback');
                phoneInput.parentNode.appendChild(feedback);
            }
            feedback.innerHTML = 'Phone number must start with 0 and contain exactly 10 digits';
            feedback.style.display = 'block';
        } else {
            phoneInput.classList.remove('is-invalid');
            let feedback = phoneInput.nextElementSibling.nextElementSibling;
            if (feedback) feedback.style.display = 'none';
        }
    });
</script>
</body>
</html>