<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Success Evaluation</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
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

    <meta name="_csrf" content="${_csrf.token}" />
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />


    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
          rel="stylesheet">

    <style>
        /* Định dạng toàn trang */
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef); /* Gradient nhẹ cho nền */
            font-family: 'Arial', sans-serif;
        }

        /* Căn giữa container */
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Chiếm toàn bộ chiều cao màn hình */
            flex-direction: column;
            text-align: center;
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        /* Hiệu ứng hover cho container */
        .container:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
        }

        /* Hiệu ứng cho tiêu đề */
        h2 {
            font-size: 2.5rem;
            color: #007bff;
            font-weight: bold;
            animation: fadeIn 1s ease-in-out; /* Hiệu ứng mờ dần cho tiêu đề */
        }

        /* Hiệu ứng cho đoạn văn */
        p {
            font-size: 1.2rem;
            color: #6c757d;
            margin-bottom: 1.5rem;
            animation: fadeIn 1.5s ease-in-out; /* Hiệu ứng mờ dần cho nội dung */
        }

        /* Hiệu ứng nút */
        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-size: 1.1rem;
            background-color: #007bff;
            color: white;
            border: none;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3); /* Hiệu ứng shadow khi hover */
            transform: scale(1.05); /* Phóng to nhẹ khi hover */
        }

        /* Keyframes cho hiệu ứng fadeIn */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(10px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

</head>

<body>
<div class="container">
    <h2>${message}</h2>
    <p>Thank you for contacting us</p> <!-- Thêm tên sản phẩm -->
    <a href="/" class="btn btn-primary">Home</a>
</div>
</body>
<jsp:include page="../layout/footer.jsp" />
</html>
