<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Hero Start -->
<div id="hero-banner" class="position-relative" style="height: 100vh; width: 100%; overflow: hidden;">
    <div id="carouselId" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="3000"
         style="height: 100%; width: 100%;">
        
        <div class="carousel-inner" style="height: 100%; width: 100%;">
            
            <div class="carousel-item active" data-bs-interval="3000">
                <img src="/client/img/banner01.jpg" class="d-block w-100"
                     style="height: 100vh; object-fit: contain;" alt="First Slide">
            </div>
            
            <div class="carousel-item" data-bs-interval="3000">
                <img src="/client/img/banner02.jpg" class="d-block w-100"
                     style="height: 100vh; object-fit: contain;" alt="Second Slide">
            </div>
            
            <div class="carousel-item" data-bs-interval="3000">
                <img src="/client/img/banner03.jpg" class="d-block w-100"
                     style="height: 100vh; object-fit: contain;" alt="Third Slide">
            </div>
            
            <div class="carousel-item" data-bs-interval="3000">
                <img src="/client/img/banner04.jpg" class="d-block w-100"
                     style="height: 100vh; object-fit: contain;" alt="Fourth Slide">
            </div>
        </div>

        <!-- Điều hướng -->
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev"
                style="z-index: 10; border: none; background: none; padding: 10px;">
    <span class="carousel-control-prev-icon" aria-hidden="true"
          style="width: 50px; height: 50px; filter: invert(1);"></span>
            <span class="visually-hidden">Previous</span>
        </button>

        <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next"
                style="z-index: 10; border: none; background: none; padding: 10px;">
    <span class="carousel-control-next-icon" aria-hidden="true"
          style="width: 50px; height: 50px; filter: invert(1);"></span>
            <span class="visually-hidden">Next</span>
        </button>

    </div>
</div>
<!-- Hero End -->

<!-- Liên kết đến Bootstrap JS và Popper.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>