<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Out Of Stock</title>

    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .out-of-stock-container {
            max-width: 600px;
            margin: 100px auto;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            text-align: center;
        }

        .out-of-stock-container h1 {
            color: #dc3545; /* Bootstrap danger color */
        }

        .btn-custom {
            margin-top: 20px;
        }
    </style>
</head>

<body>
    <div class="out-of-stock-container">
        <h1>Product is Out of Stock</h1>
        <p>Sorry, some items in your cart are out of stock. Please remove them or choose other products.</p>
        <a href="/cart" class="btn btn-danger btn-custom">Back to Cart</a>
    </div>

    <!-- Bootstrap JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
