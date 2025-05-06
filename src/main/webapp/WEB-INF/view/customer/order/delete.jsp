<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="Hỏi Dân IT - Dự án Legoshop" />
    <meta name="author" content="Hỏi Dân IT" />
    <title>Cancel Order</title>
    <link
      href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
      rel="stylesheet"
    />
    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

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
  </head>

  <body>
    <jsp:include page="../layout/header.jsp" />
    <main>
      <div class="container-fluid py-5 mt-5">
        <div class="container py-5">
          <h2 class="mb-4 text-center">Cancel Order</h2>
          <div class="mt-5">
            <div class="row">
              <div class="col-12 mx-auto">
                <hr />
                <div class="alert alert-danger">
                  Do you really want to cancel your order?
                </div>

                <!-- Cancel Order Form -->
                <form method="post" action="/customer/order/delete" class="row">
                  <!-- CSRF Token -->
                  <input type="hidden" name="_csrf" value="${_csrf.token}" />
                  <!-- Hidden field for id -->
                  <input type="hidden" name="id" value="${newOrder.id}" />

                  <!-- Order info -->
                  <div class="mb-3">
                    <p>Order ID: ${newOrder.id}</p>
                    <p>
                      Price:
                      <fmt:formatNumber
                        type="number"
                        value="${newOrder.totalPrice}"
                      />
                      đ
                    </p>
                    <p>User: ${newOrder.user.fullName}</p>
                  </div>

                  <!-- Cancel reason -->
                  <div class="mb-3 col-12">
                    <label class="form-label" for="cancelReason">
                      <strong>Reason for Canceling:</strong>
                    </label>
                    <select
                      class="form-select"
                      name="cancelReason"
                      id="cancelReason"
                      required
                    >
                      <option value="" disabled selected>
                        Select a reason
                      </option>
                      <option value="out_of_stock">Out of Stock</option>
                      <option value="price_issue">Price Issue</option>
                      <option value="changed_mind">Changed My Mind</option>
                      <option value="other">Other</option>
                    </select>
                    <small class="text-muted">
                      Please select the reason for canceling the order.
                    </small>
                  </div>

                  <!-- Other reason -->
                  <div
                    class="mb-3 col-12"
                    id="otherReasonDiv"
                    style="display: none"
                  >
                    <label class="form-label" for="otherReason">
                      Please specify the reason:
                    </label>
                    <textarea
                      class="form-control"
                      name="otherReason"
                      id="otherReason"
                      rows="3"
                    ></textarea>
                  </div>

                  <!-- Submit and Back Buttons -->
                  <div class="text-center">
                    <button type="submit" class="btn btn-danger">
                      Confirm Cancel
                    </button>
                    <a
                      href="/customer/order/tracking"
                      class="btn btn-secondary ms-2"
                      >Back</a
                    >
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="js/scripts.js"></script>
    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>

    <!-- Script to toggle "Other" reason textarea -->
    <script>
      $(document).ready(function () {
        $("#cancelReason").change(function () {
          if ($(this).val() === "other") {
            $("#otherReasonDiv").slideDown();
          } else {
            $("#otherReasonDiv").slideUp();
          }
        });
      });
    </script>
  </body>
</html>
