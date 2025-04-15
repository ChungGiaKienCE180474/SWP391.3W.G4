<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Product Reviews</title>
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
                    /* Định dạng cho toàn bộ màn hình */
                    body,
                    html {
                        height: 100%;
                        margin: 0;
                        padding: 0;
                    }

                    /* Căn giữa container và mở rộng toàn màn hình */
                    .fullscreen-container {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        height: 100vh;
                        /* Chiếm toàn bộ chiều cao màn hình */
                        background-color: #f8f9fa;
                    }

                    .rating-container {
                        background-color: #ffffff;
                        padding: 2rem;
                        border-radius: 10px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        width: 100%;
                        max-width: 600px;
                        /* Giới hạn chiều rộng tối đa */
                        text-align: center;
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                    }

                    .rating-container:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                    }

                    h2 {
                        color: #343a40;
                        font-weight: bold;
                    }

                    p {
                        color: #6c757d;
                    }

                    /* CSS cho phần đánh giá sao */
                    .star-rating {
                        direction: rtl;
                        display: inline-flex;
                        gap: 0.5rem;
                    }

                    .star-rating input[type="radio"] {
                        display: none;
                    }

                    .star-rating label {
                        font-size: 2.5em;
                        color: #ddd;
                        cursor: pointer;
                        transition: color 0.3s ease-in-out, transform 0.3s ease-in-out;
                    }

                    .star-rating label:hover,
                    .star-rating label:hover~label {
                        color: #ffcc00;
                        transform: scale(1.2);
                        /* Zoom ngôi sao khi hover */
                    }

                    .star-rating input[type="radio"]:checked~label {
                        color: #ffcc00;
                    }

                    /* Hiệu ứng cho textarea */
                    textarea {
                        border-radius: 8px;
                        border: 2px solid #ced4da;
                        transition: border-color 0.3s ease;
                        width: 100%;
                    }

                    textarea:focus {
                        border-color: #007bff;
                        outline: none;
                        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                    }

                    /* Button */
                    button {
                        background-color: #007bff;
                        border: none;
                        padding: 0.6rem 1.5rem;
                        font-size: 1rem;
                        border-radius: 25px;
                        transition: background-color 0.3s ease, box-shadow 0.3s ease;
                        color: white;
                    }

                    button:hover {
                        background-color: #0056b3;
                        box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
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
                </style>
                <nav>
                    <jsp:include page="../layout/header.jsp" />
                </nav>
            </head>

            <body>
                <div class="fullscreen-container">
                    <div class="rating-container">
                        <h2>Product Reviews: ${product.name}</h2>
                        <p>Price:
                            <fmt:formatNumber value="${product.price}" type="number" /> đ
                        </p>

                        <c:if test="${isReviewed}">
                            <p><strong>Your review:</strong></p>
                            <p>${existingReview.reviewContent}</p>
                            <p><strong>Number of stars:</strong> ${existingReview.rating} &#9733;</p>
                            <a href="/order-history" class="btn btn-home">Go back to order history</a>
                        </c:if>

                        <c:if test="${!isReviewed}">
                            <form action="${pageContext.request.contextPath}/customer/submit-review/${orderDetail.id}"
                                method="POST">
                                <input type="hidden" name="_csrf" value="${_csrf.token}" />

                                <label for="reviewContent">Review content:</label>
                                <textarea id="reviewContent" name="reviewContent" rows="4" class="form-control mb-3"
                                    placeholder="Enter your review here"></textarea>

                                <label for="rating">Đánh giá:</label>
                                <div class="star-rating">
                                    <input type="radio" id="star5" name="rating" value="5" /><label
                                        for="star5">&#9733;</label>
                                    <input type="radio" id="star4" name="rating" value="4" /><label
                                        for="star4">&#9733;</label>
                                    <input type="radio" id="star3" name="rating" value="3" /><label
                                        for="star3">&#9733;</label>
                                    <input type="radio" id="star2" name="rating" value="2" /><label
                                        for="star2">&#9733;</label>
                                    <input type="radio" id="star1" name="rating" value="1" /><label
                                        for="star1">&#9733;</label>
                                </div>

                                <button type="submit" onclick="return validateRating()">Submit a review</button>
                            </form>
                        </c:if>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

                <script>
                    function validateRating() {
                        const rating = document.querySelector('input[name="rating"]:checked');
                        if (!rating) {
                            alert("Please select the number of stars to rate the product.");
                            return false;
                        }
                        return true;
                    }
                </script>
            </body>

            </html>