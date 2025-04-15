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
                <link href='' rel='stylesheet'>
                <script type='text/javascript'
                    src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
                <style>
                    body {
                        background-position: center;
                        background-color: #eee;
                        background-repeat: no-repeat;
                        background-size: cover;
                        color: #505050;
                        font-family: "Rubik", Helvetica, Arial, sans-serif;
                        font-size: 14px;
                        font-weight: normal;
                        line-height: 1.5;
                        text-transform: none
                    }

                    .forgot {
                        background-color: #fff;
                        padding: 12px;
                        border: 1px solid #dfdfdf
                    }

                    .padding-bottom-3x {
                        padding-bottom: 72px !important
                    }

                    .card-footer {
                        background-color: #fff
                    }

                    .btn {
                        font-size: 13px
                    }

                    .form-control:focus {
                        color: #495057;
                        background-color: #fff;
                        border-color: #76b7e9;
                        outline: 0;
                        box-shadow: 0 0 0 0px #28a745
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
                                    <li><span class="text-primary text-medium">1. </span>Enter your email address below.</li>
                                    <li><span class="text-primary text-medium">2. </span>Our system will send OTP code to your email.</li>
                                    <li><span class="text-primary text-medium">3. </span>Enter OTP on the next page.</li>
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

                                        <small class="form-text text-muted">Enter your registered email. We will then send an OTP email to this address.</small>
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
                <script type='text/javascript'
                    src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
                <script type='text/javascript' src=''></script>
                <script type='text/javascript' src=''></script>
                <script type='text/Javascript'></script>
            </body>

            </html>