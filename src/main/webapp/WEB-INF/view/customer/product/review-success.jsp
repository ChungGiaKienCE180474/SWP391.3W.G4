<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Thank You for Your Feedback!</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Raleway:wght@600;800&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
    />
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
      rel="stylesheet"
    />

    <!-- Icon Font Stylesheet -->
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link
      href="/client/lib/owlcarousel/assets/owl.carousel.min.css"
      rel="stylesheet"
    />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet" />

    <meta name="_csrf" content="${_csrf.token}" />
    <!-- default header name is X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
      rel="stylesheet"
    />
    <style>
      /* Reset style toàn cục để tránh xung đột */
      html,
      body {
        margin: 0;
        padding: 0;
        height: 100%;
        font-family: "Raleway", sans-serif;
        background: #fff;
      }

      /* Container chính để cách ly style */
      .thank-you-page {
        position: relative;
        z-index: 1; /* Đảm bảo thấp hơn z-index của header (thường là 1000 trong Bootstrap) */
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
      }

      .thank-you-page .thank-you-container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        background: white;
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        animation: fadeIn 1s ease-in-out;
        width: 100%;
        max-width: 500px;
      }

      .thank-you-page .thank-you-icon {
        font-size: 3.5rem;
        color: #28a745;
        margin-bottom: 1.5rem;
      }

      .thank-you-page .thank-you-title {
        font-size: 2.2rem;
        color: #007bff;
        font-weight: 700;
        margin-bottom: 1rem;
      }

      .thank-you-page .thank-you-message {
        font-size: 1.2rem;
        color: #6c757d;
        margin-bottom: 2rem;
      }

      .thank-you-page .btn-back-home {
        padding: 0.8rem 2rem;
        border-radius: 50px;
        font-size: 1.2rem;
        background-color: #007bff;
        color: white;
        transition: all 0.3s ease-in-out;
        text-decoration: none;
      }

      .thank-you-page .btn-back-home:hover {
        background-color: #0056b3;
        color: white;
        box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      /* Responsive design */
      @media (max-width: 576px) {
        .thank-you-page .thank-you-container {
          padding: 1.5rem;
          margin: 1rem;
          border-radius: 10px;
        }

        .thank-you-page .thank-you-title {
          font-size: 1.8rem;
        }

        .thank-you-page .thank-you-message {
          font-size: 1rem;
        }

        .thank-you-page .btn-back-home {
          padding: 0.6rem 1.5rem;
          font-size: 1rem;
        }
      }
    </style>
    <nav>
      <jsp:include page="../layout/header.jsp" />
    </nav>
  </head>

  <body>
    <div class="thank-you-page">
      <div class="thank-you-container">
        <i class="bi bi-check-circle thank-you-icon"></i>
        <h2 class="thank-you-title">Thank You for Your Feedback!</h2>
        <p class="thank-you-message">
          We appreciate your review for this product
        </p>
        <a href="/order-history" class="btn-back-home"
          >Go back to order history</a
        >
      </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
  </body>
</html>
