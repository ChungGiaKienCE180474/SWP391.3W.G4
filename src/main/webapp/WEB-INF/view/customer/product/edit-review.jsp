<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit product review</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Edit product review: ${product.name}</h2>
        <p>Price: ${product.price}</p>
        
        <form action="${pageContext.request.contextPath}/customer/update-review/${review.id}" method="POST">
            <label for="reviewContent">Review content:</label>
            <textarea id="reviewContent" name="reviewContent">${review.reviewContent}</textarea>
            
            <!-- <label for="rating">Đánh giá:</label>
            <input type="number" id="rating" name="rating" value="${review.rating}" min="1" max="5" /> -->
            
            <button type="submit">Update review</button>
        </form> 
        
        
    </div>
</body>                                                                                                                     
</html> 
