<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Thank You for Your Feedback!</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">

    <style>
        body, html {
            height: 100%;
            margin: 0;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            font-family: 'Raleway', sans-serif;
        }

        .thank-you-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
            animation: fadeIn 1s ease-in-out;
        }

        .thank-you-icon {
            font-size: 3.5rem;
            color: #28a745;
            margin-bottom: 1rem;
        }

        h2 {
            font-size: 2.2rem;
            color: #007bff;
            font-weight: 700;
        }

        p {
            font-size: 1.2rem;
            color: #6c757d;
            margin-bottom: 1.5rem;
        }

        .btn-home {
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-size: 1.2rem;
            background-color: #007bff;
            color: white;
            transition: all 0.3s ease-in-out;
        }

        .btn-home:hover {
            background-color: #0056b3;
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>
<jsp:include page="../layout/header.jsp"/>

<div class="container d-flex justify-content-center align-items-center">
    <div class="thank-you-container">
        <i class="bi bi-check-circle thank-you-icon"></i>
        <h2>Thank You for Your Feedback!</h2>
        <p>We appreciate your review for this product</p>
        <a href="/order-history" class="btn btn-home">Go back to order history</a>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
</body>
</html>
