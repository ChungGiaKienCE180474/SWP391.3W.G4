<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>OTP Verification</title>
    <style>
        body {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            height: 100vh;
            margin: 0;
        }
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('../images/FhOraKA.jpg') center/cover;
            filter: blur(1px);
            z-index: -1;
        }
        .otp-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-top: 100px;
        }
        .form-gap {
            height: 30px;
        }
    </style>
</head>
<body>
<div class="form-gap"></div>
<div class="container otp-container">
    <h1 class="text-center">OTP Verification</h1>
    <p class="text-center">Check your email and collect OTP to insert</p>
    <form method="post" action="/authentication/enterRegisterOTP" modelAttribute="newOtpForm">
        <div class="form-group">
            <c:if test="${not empty message}">
                <div class="my-2" style="color: red;">${message}</div>
            </c:if>
            <label for="otp">Enter OTP</label>
            <input type="text" id="otp" name="otp" placeholder="Enter OTP" class="form-control" required="required" />
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit" class="btn btn-primary btn-block">OTP Confirmation</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>