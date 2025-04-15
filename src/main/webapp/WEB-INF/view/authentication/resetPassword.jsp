<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html>

            <head>
                <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet"
                    id="bootstrap-css">
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
                <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
                <link rel="stylesheet"
                    href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">

                <style>
                    /* Make the form container fill the screen and center content */
                    html,
                    body {
                        height: 100%;
                        margin: 0;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        background-color: #f8f9fa;
                        /* Light background for better contrast */
                    }

                    .panel {
                        width: 100%;
                        /* Adjust the form width */
                        max-width: 600px;
                        /* Set a max width for responsiveness */
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                        /* Add some shadow for better appearance */
                        border-radius: 8px;
                        /* Rounded corners for a modern look */
                        padding: 120px;
                    }

                    .form-group i {
                        position: absolute;
                        right: 15px;
                        top: 50%;
                        transform: translateY(-50%);
                        cursor: pointer;
                        font-size: 1.1em;
                    }

                    .password-toggle {
                        position: relative;
                    }

                    .btn-primary {
                        width: 100%;
                        /* Make the button full width */
                        padding: 10px;
                        font-size: 1.2em;
                    }

                    .text-center h2 {
                        margin-bottom: 20px;
                    }
                </style>
            </head>

            <body>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="text-center">
                            <h2><strong>Recover Password</strong></h2>
                            <c:if test="${param.invalidpassword != null}">
                                <div class="my-2" style="color: red;">Password and ConfirmPassword must match</div>
                            </c:if>
                            <form:form method="post" action="/authentication/resetPassword"
                                modelAttribute="resetPasswordForm">
                                <div class="form-group password-toggle">
                                    <form:input path="password" id="password" type="password" placeholder="New Password"
                                        required="required" autocomplete="off" class="form-control" />
                                    <i class="fa fa-eye" id="togglePassword"
                                        onclick="togglePasswordVisibility('password')"></i>
                                </div>
                                <div class="form-group password-toggle">
                                    <form:input path="confPassword" id="confPassword" type="password"
                                        placeholder="Confirm Password" autocomplete="off" required="required"
                                        class="form-control" />
                                    <i class="fa fa-eye" id="toggleConfPassword"
                                        onclick="togglePasswordVisibility('confPassword')"></i>
                                </div>

                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <button type="submit" class="btn btn-primary">Recover Password</button>
                            </form:form>
                        </div>
                    </div>
                </div>

                <script>
                    function togglePasswordVisibility(fieldId) {
                        const inputField = document.getElementById(fieldId);
                        const toggleIcon = inputField.nextElementSibling;

                        if (inputField.type === 'password') {
                            inputField.type = 'text';
                            toggleIcon.classList.remove('fa-eye');
                            toggleIcon.classList.add('fa-eye-slash');
                        } else {
                            inputField.type = 'password';
                            toggleIcon.classList.remove('fa-eye-slash');
                            toggleIcon.classList.add('fa-eye');
                        }
                    }
                </script>
            </body>

            </html>