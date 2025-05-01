<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>About us - Gundamshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

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
    <link href="/client/css/style.css" rel="stylesheet" />

    <style>
      .content-wrapper {
        display: flex;
        flex-wrap: wrap;
        align-items: flex-start;
        gap: 20px;
        margin-top: 100px;
      }

      .map-responsive {
        flex: 1;
        min-width: 300px;
        height: 450px;
      }

      .map-responsive iframe {
        width: 100%;
        height: 100%;
        border: 0;
      }

      .about-us {
        flex: 1;
        min-width: 300px;
        text-align: left;
      }

      .about-us h2 {
        text-align: center;
        font-size: 2rem;
        color: #333;
        margin-bottom: 20px;
      }

      .about-us h3 {
        font-size: 1.5rem;
        color: #555;
        margin-bottom: 10px;
      }

      .about-us p {
        font-size: 1rem;
        line-height: 1.5;
      }

      .btn-view-products {
        margin-top: 20px;
      }

      .product-card img {
        height: 250px;
        object-fit: cover;
        border-top-left-radius: 0.5rem;
        border-top-right-radius: 0.5rem;
      }

      .featured-section {
        margin-top: 60px;
        text-align: center;
      }

      .featured-section h3 {
        margin-bottom: 30px;
        font-size: 2rem;
        font-weight: 600;
      }

      footer{
        padding-top: 30px;
      }
    </style>
  </head>

  <body>
    <!-- Header -->
    <jsp:include page="../layout/header.jsp" />

    <!-- Main Content -->
    <div class="container">
      <!-- About Us Section -->
      <div class="content-wrapper">
        <div class="map-responsive">
          <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d19237.864610690925!2d105.73899626026024!3d10.006099532120508!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0882139720a77%3A0x3916a227d0b95a64!2sFPT%20University!5e0!3m2!1svi!2s!4v1745829541715!5m2!1svi!2s"
            width="600"
            height="450"
            style="border: 0"
            allowfullscreen=""
            loading="lazy"
            referrerpolicy="no-referrer-when-downgrade"
          ></iframe>
        </div>
        <div class="about-us">
          <h2>About Us</h2>
          <h3>Lego Shop</h3>
          <p>
            Welcome to our LEGO Shop, where creativity and imagination come to
            life! We are your one-stop destination for all things LEGO, offering
            a wide range of iconic sets, exclusive collections, and accessories
            for builders of all ages. From classic bricks to intricate themed
            sets like Star Wars, Harry Potter, and LEGO Technic, our shop
            provides endless opportunities to create, explore, and play. Whether
            you're a passionate collector, a parent looking for educational
            toys, or a fan of hands-on fun, our LEGO Shop is dedicated to
            delivering high-quality products and exceptional service to spark
            joy and inspire innovation in every build.
          </p>
          <div class="text-center btn-view-products">
            <a href="/products" class="btn btn-primary px-4 py-2">
              <i class="fas fa-box-open me-2"></i> View Products
            </a>
          </div>
        </div>
      </div>

      <!-- Featured Products Section -->
      <!-- <div class="featured-section">
      <h3>Featured Products</h3>
      <div class="row justify-content-center">
        <div class="col-md-4 mb-4">
          <div class="card h-100 shadow-sm product-card">
            <img src="/client/img/gundam1.jpg" class="card-img-top" alt="Gundam 1">
            <div class="card-body text-center">
              <h5 class="card-title">Gundam RX-78-2</h5>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="card h-100 shadow-sm product-card">
            <img src="/client/img/gundam2.jpg" class="card-img-top" alt="Gundam 2">
            <div class="card-body text-center">
              <h5 class="card-title">Gundam Barbatos</h5>
            </div>
          </div>
        </div>

        <div class="col-md-4 mb-4">
          <div class="card h-100 shadow-sm product-card">
            <img src="/client/img/gundam3.jpg" class="card-img-top" alt="Gundam 3">
            <div class="card-body text-center">
              <h5 class="card-title">Gundam Exia</h5>
            </div>
          </div>
        </div>
      </div>
    </div> -->
    </div>

    <!-- Footer -->
    <footer><jsp:include page="../layout/footer.jsp" /></footer>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
  </body>
</html>
