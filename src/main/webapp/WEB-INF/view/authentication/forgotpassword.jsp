<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset='utf-8'>
                <meta name='viewport' content='width=device-width, initial-scale=1'>
                <title>Forgot password</title>
                <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet'>
                <script type='text/javascript'
                    src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
                <style>
                    body {
                        background: url('/images/forgot-password-bg.jpg') no-repeat center center fixed;
                        background-size: cover;
                        font-family: "Segoe UI", sans-serif;
                        color: #333;
                    }

                    .container {
                        margin-top: 60px;
                    }

                    .forgot {
                        background: rgba(255, 255, 255, 0.9);
                        border-radius: 16px;
                        padding: 30px;
                        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                        backdrop-filter: blur(10px);
                    }

                    .forgot h2 {
                        font-weight: 700;
                        margin-bottom: 20px;
                        color: #007bff;
                    }

                    .forgot p {
                        font-size: 15px;
                    }

                    .forgot ol {
                        padding-left: 18px;
                        margin-top: 10px;
                    }

                    .card {
                        border: none;
                        background: rgba(255, 255, 255, 0.9);
                        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                        border-radius: 16px;
                    }

                    .card-body {
                        padding: 25px;
                    }

                    .form-control {
                        border-radius: 10px;
                        padding: 12px;
                        font-size: 14px;
                    }

                    .form-control:focus {
                        border-color: #007bff;
                        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
                    }

                    .invalid-feedback {
                        display: block;
                        color: red;
                        font-size: 13px;
                    }

                    .form-text {
                        font-size: 13px;
                    }

                    .card-footer {
                        background-color: transparent;
                        border-top: none;
                        display: flex;
                        justify-content: space-between;
                        padding: 15px 25px;
                    }

                    .btn {
                        border-radius: 8px;
                        padding: 10px 20px;
                    }

                    .btn-danger a {
                        color: white;
                        text-decoration: none;
                    }

                    @media (max-width: 768px) {
                        .container {
                            margin-top: 30px;
                            padding: 0 15px;
                        }
                    }
                </style>
            </head>

            <body oncontextmenu='return false' class='snippet-body'>
                <div class="container padding-bottom-3x mb-2 mt-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-8 col-md-10">
                            <div class="forgot">
                                <h2>Forgot your password?</h2>
                                <p>Change your password in three easy steps. This will help keep your password secure!
                                </p>
                                <ol class="list-unstyled">
                                    <li><span class="text-primary text-medium">1. </span>Enter your email address below.
                                    </li>
                                    <li><span class="text-primary text-medium">2. </span>Our system will send OTP code
                                        to your email.</li>
                                    <li><span class="text-primary text-medium">3. </span>Enter OTP on the next page.
                                    </li>
                                </ol>
                            </div>

                            <form:form method="post" action="/authentication/forgotpassword" modelAttribute="newUser"
                                class="card mt-4" enctype="multipart/form-data">
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="email-for-pass">Enter Email:</label>

                                        <c:set var="errorEmail">
                                            <form:errors path="email" cssClass="invalid-feedback" />
                                        </c:set>

                                        <c:if test="${param.invalidemail != null}">
                                            <div class="my-2" style="color: red;">Invalid email</div>
                                        </c:if>

                                        <form:input type="email"
                                            class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                            path="email" required="" />
                                        ${errorEmail}

                                        <small class="form-text text-muted">
                                            Enter your registered email. We will then send an OTP email to this address.
                                        </small>
                                    </div>
                                </div>

                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <div class="card-footer">
                                    <button type="submit" class="btn btn-primary">Send OTP</button>
                                    <button class="btn btn-danger"><a href="/login">Back</a></button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>

                <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
            </body>

            </html>