<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <title>Product - Gundamshop</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <meta content="" name="keywords">
                <meta content="" name="description">

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                <!-- Customized Bootstrap Stylesheet -->
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="/client/css/style.css" rel="stylesheet">
                <style>
                    /* Thiết kế lại form liên hệ */
                    .row {
                        max-width: 500px;
                        position: fixed;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        padding: 20px;
                        background: rgba(255, 255, 255, 0.7);
                        border-radius: 8px;
                        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                    }

                    form label {
                        display: block;
                        text-align: left;
                        font-weight: bold;
                        margin-bottom: 5px;
                    }

                    h2 {
                        text-align: center;
                        color: #333;
                        font-weight: bold;
                        margin-bottom: 20px;
                    }

                    .form-control {
                        width: 100%;
                        padding: 10px;
                        border: 1px solid #ccc;
                        border-radius: 6px;
                        font-size: 14px;
                        background: #f9f9f9;
                        margin-bottom: 15px;
                    }

                    textarea.form-control {
                        resize: vertical;
                        min-height: 100px;
                    }

                    button[type="submit"] {
                        width: 100%;
                        padding: 10px;
                        background-color: #d43c0e;
                        color: white;
                        border: none;
                        border-radius: 6px;
                        font-size: 16px;
                        cursor: pointer;
                        transition: 0.3s;
                    }

                    button[type="submit"]:hover {
                        background-color: #66CC00;
                    }

                    .contact-section {
                        background-image: url('/client/img/Contact_Img.png');
                        background-repeat: no-repeat;
                        background-size: cover;
                        background-attachment: fixed;
                        background-position: center;
                        min-height: 100vh;
                        padding: 100px 0;
                        position: relative;
                        z-index: 1;
                    }

                    .invalid-feedback {
                        color: #dc3545;
                        font-size: 0.875em;
                        margin-top: 0.25rem;
                        display: none;
                    }

                    .form-control.is-invalid {
                        border-color: #dc3545;
                    }

                    .form-control.is-invalid+.invalid-feedback {
                        display: block;
                    }
                </style>
            </head>

            <body>
                <!-- Include Header -->
                <jsp:include page="../layout/header.jsp" />

                <!-- Contact Form -->
                <section class="contact-section">
                    <form:form method="POST" action="/contact/contact-success" modelAttribute="contact" class="row">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <h2 class="col-12">Send Contact</h2>

                        <!-- Phone Number Field -->
                        <div class="col-12">
                            <form:label for="phoneNumber" path="phoneNumber">Phone Number:</form:label>
                            <form:input id="phoneNumber" path="phoneNumber" class="form-control" required="true"
                                pattern="0[0-9]{9}" title="Phone numbers must start with 0 and have 10 numbers" />
                            <div class="invalid-feedback">Phone numbers must start with 0 and have 10 numbers</div>
                        </div>

                        <!-- Hidden UserId Field -->
                        <input type="hidden" id="userId" name="userId" value="${sessionScope.id}" />

                        <!-- Subject Name Field -->
                        <div class="col-12">
                            <form:label for="subjectName" path="subjectName">Topic:</form:label>
                            <form:input id="subjectName" path="subjectName" class="form-control" />
                        </div>

                        <!-- Note Field -->
                        <div class="col-12">
                            <form:label for="note" path="note">Note:</form:label>
                            <form:textarea id="note" path="note" class="form-control"></form:textarea>
                        </div>

                        <div class="col-12">
                            <button type="submit">Send Contact</button>
                        </div>
                    </form:form>
                </section>

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script
                    src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0-alpha1/js/bootstrap.bundle.min.js"></script>

                <script>
                    document.querySelector('form').addEventListener('submit', function (e) {
                        const phoneInput = document.querySelector('#phoneNumber');
                        const phonePattern = /^0[0-9]{9}$/;
                        const phoneValue = phoneInput.value;

                        if (!phonePattern.test(phoneValue)) {
                            e.preventDefault();
                            phoneInput.classList.add('is-invalid');
                        } else {
                            phoneInput.classList.remove('is-invalid');
                        }
                    });

                    document.querySelector('#phoneNumber').addEventListener('input', function () {
                        this.classList.remove('is-invalid');
                    });
                </script>

            </body>

            </html>