<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Payment - GundamShop</title>
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
                </head>

                <body>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div class="mb-3">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Payment information</li>
                                    </ol>
                                </nav>
                            </div>

                            <c:if test="${not empty cartDetails}">
                                <form:form action="/place-order" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <!-- Trường ẩn để lưu mã voucher -->
                                    <input type="hidden" name="voucherCode" id="voucherCodeHidden" value="">
                                    <!-- Trường ẩn để lưu tổng tiền sau giảm giá -->
                                    <input type="hidden" name="finalTotal" id="finalTotalHidden"
                                        value="${totalPrice + 30000}">

                                    <div class="row">
                                        <!-- Thông tin người nhận -->
                                        <div class="col-md-6">
                                            <h4>Receiver Information</h4>
                                            <div class="mb-3">
                                                <label for="receiverName" class="form-label">Full Name:</label>
                                                <input type="text" id="receiverName" name="receiverName"
                                                    class="form-control" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="receiverEmail" class="form-label">Email:</label>
                                                <input type="email" id="receiverEmail" name="receiverEmail"
                                                    class="form-control" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="receiverPhone" class="form-label">Phone Number:</label>
                                                <input type="tel" id="receiverPhone" name="receiverPhone"
                                                    class="form-control" required pattern="0[0-9]{9}"
                                                    oninvalid="this.setCustomValidity('Phone number must start with 0 and have 10 numbers')"
                                                    oninput="this.setCustomValidity('')">
                                            </div>
                                            <div class="mb-3">
                                                <label for="receiverAddress" class="form-label">Address:</label>
                                                <input type="text" id="receiverAddress" name="receiverAddress"
                                                    class="form-control" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="Note" class="form-label">Note:</label>
                                                <textarea id="Note" name="Note" class="form-control" rows="3"
                                                    required></textarea>
                                            </div>
                                        </div>

                                        <!-- Thông tin đơn hàng -->
                                        <div class="col-md-6">
                                            <h4>🛒 Order</h4>
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Product</th>
                                                        <th>Number</th>
                                                        <th>Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="cartDetail" items="${cartDetails}">
                                                        <tr>
                                                            <td>${cartDetail.product.name}</td>
                                                            <td>${cartDetail.quantity}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${cartDetail.price * cartDetail.quantity}" />
                                                                đ
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>

                                            <!-- Hiển thị Tổng tiền -->
                                            <div class="mb-3 d-flex justify-content-between">
                                                <h6>💰 Price:</h6>
                                                <p id="originalTotal" data-cart-total-price="${totalPrice}">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                </p>
                                            </div>

                                            <!-- Phí vận chuyển -->
                                            <div class="mb-3 d-flex justify-content-between">
                                                <h6>🚚 Shipping Fee:</h6>
                                                <p id="shippingFee">30,000 đ</p>
                                            </div>

                                            <!-- Nhập mã voucher -->
                                            <div class="mb-3">
                                                <label>🎟️ Add Voucher:</label>
                                                <div class="input-group">
                                                    <input type="text" class="form-control" id="voucherCodeInput"
                                                        placeholder="Enter Voucher Code">
                                                    <button type="button" class="btn btn-primary"
                                                        id="checkVoucherBtn">Check</button>
                                                </div>
                                            </div>
                                            <!-- Kết quả voucher -->
                                            <div class="mb-3" id="voucherResult" style="display: none;">
                                                <h6>✅ Voucher Found:</h6>
                                                <p id="voucherTitle"></p>
                                                <p><strong>Discount: </strong><span id="voucherDiscount"></span></p>
                                            </div>

                                            <!-- Giảm giá -->
                                            <div class="mb-3 d-flex justify-content-between">
                                                <h6>🎟️ Discount Amount:</h6>
                                                <p id="discountAmount">0 đ</p>
                                            </div>

                                            <!-- Tổng cộng -->
                                            <div class="mb-3 d-flex justify-content-between">
                                                <h5>💰 Total Price:</h5>
                                                <h5 id="finalTotal">
                                                    <fmt:formatNumber type="number" value="${totalPrice + 30000}" /> đ
                                                </h5>
                                            </div>

                                            <!-- Nút Xác Nhận Thanh Toán -->
                                            <form action="/place-order" method="post" style="display: inline;">
                                                <!-- Các trường ẩn -->
                                                <input type="hidden" name="receiverName" th:value="${receiverName}" />
                                                <input type="hidden" name="receiverAddress"
                                                    th:value="${receiverAddress}" />
                                                <input type="hidden" name="receiverPhone" th:value="${receiverPhone}" />
                                                <input type="hidden" name="Note" th:value="${orderInfo}" />
                                                <input type="hidden" name="voucherCode" th:value="${voucherCode}" />
                                                <input type="hidden" name="finalTotal" th:value="${totalPrice}" />

                                                <!-- Nút thanh toán offline -->
                                                <button type="submit" name="paymentMethod" value="offline"
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">
                                                    Cash on Delivery
                                                </button>

                                                <!-- Nút thanh toán online -->
                                                <button type="submit" name="paymentMethod" value="online"
                                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-5">
                                                    Online Payment
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </form:form>
                            </c:if>
                        </div>
                    </div>
                    <!-- Cart Page End -->ss

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            let voucherCodeInput = document.getElementById("voucherCodeInput");
                            let checkVoucherBtn = document.getElementById("checkVoucherBtn");
                            let discountAmountElement = document.getElementById("discountAmount");
                            let finalTotalElement = document.getElementById("finalTotal");
                            let voucherResultContainer = document.getElementById("voucherResult");
                            let voucherTitleElement = document.getElementById("voucherTitle");
                            let voucherDiscountElement = document.getElementById("voucherDiscount");
                            let voucherCodeHidden = document.getElementById("voucherCodeHidden");
                            let finalTotalHidden = document.getElementById("finalTotalHidden");

                            // Thêm container hiển thị gợi ý mã giảm giá
                            let voucherSuggestionContainer = document.createElement("div");
                            voucherSuggestionContainer.id = "voucherSuggestionContainer";
                            voucherSuggestionContainer.style.display = "none";
                            voucherSuggestionContainer.style.position = "absolute";
                            voucherSuggestionContainer.style.background = "#fff";
                            voucherSuggestionContainer.style.border = "1px solid #ccc";
                            voucherSuggestionContainer.style.width = "100%";
                            voucherSuggestionContainer.style.zIndex = "1000";
                            document.querySelector(".input-group").appendChild(voucherSuggestionContainer);

                            const originalTotal = parseFloat(document.getElementById("originalTotal").getAttribute("data-cart-total-price"));
                            const originalShippingFee = 30000;

                            // 🏷️ Lấy mã voucher từ URL (nếu có)
                            const urlParams = new URLSearchParams(window.location.search);
                            const voucherCodeFromUrl = urlParams.get("voucherCode");

                            if (voucherCodeFromUrl) {
                                voucherCodeInput.value = voucherCodeFromUrl;
                                applyVoucher(voucherCodeFromUrl);
                            }

                            checkVoucherBtn.addEventListener("click", function () {
                                let code = voucherCodeInput.value.trim().toUpperCase();
                                if (code === "") {
                                    alert("⚠️ Please enter a voucher code!");
                                    return;
                                }
                                applyVoucher(code);
                            });

                            voucherCodeInput.addEventListener("input", function () {
                                let code = voucherCodeInput.value.trim();
                                if (code.length >= 2) {
                                    fetch(`/voucher/search?code=${code}`)
                                        .then(response => response.json())
                                        .then(data => {
                                            if (data.exists && data.vouchers.length) {
                                                showVoucherSuggestions(data.vouchers);
                                            } else {
                                                voucherSuggestionContainer.style.display = "none";
                                            }
                                        })
                                        .catch(error => console.error("🚨 Error finding vouchers:", error));
                                } else {
                                    voucherSuggestionContainer.style.display = "none";
                                }
                            });

                            function showVoucherSuggestions(vouchers) {
                                let inputValue = voucherCodeInput.value.trim().toUpperCase();
                                let filteredVouchers = vouchers.filter(voucher => voucher.code.toUpperCase().includes(inputValue));

                                if (filteredVouchers.length === 0) {
                                    voucherSuggestionContainer.style.display = "none";
                                    return;
                                }

                                voucherSuggestionContainer.innerHTML = "";
                                filteredVouchers.forEach(voucher => {
                                    let voucherItem = document.createElement("div");
                                    voucherItem.style.padding = "10px";
                                    voucherItem.style.borderBottom = "1px solid #ddd";
                                    voucherItem.style.display = "flex";
                                    voucherItem.style.justifyContent = "space-between";
                                    voucherItem.style.cursor = "pointer";
                                    voucherItem.style.background = "#fff";

                                    let voucherText = document.createElement("span");
                                    voucherText.innerText = voucher.code + " - " + voucher.title;

                                    let useButton = document.createElement("button");
                                    useButton.innerText = "Use Now";
                                    useButton.style.marginLeft = "10px";
                                    useButton.style.padding = "5px 10px";
                                    useButton.style.border = "none";
                                    useButton.style.background = "#007bff";
                                    useButton.style.color = "white";
                                    useButton.style.cursor = "pointer";
                                    useButton.addEventListener("click", function (e) {
                                        e.preventDefault()
                                        voucherCodeInput.value = voucher.code;
                                        voucherSuggestionContainer.style.display = "none";
                                        applyVoucher(voucher.code);
                                    });

                                    voucherItem.appendChild(voucherText);
                                    voucherItem.appendChild(useButton);
                                    voucherSuggestionContainer.appendChild(voucherItem);
                                });

                                let rect = voucherCodeInput.getBoundingClientRect();
                                voucherSuggestionContainer.style.top = (voucherCodeInput.offsetHeight + 5) + "px"; // Đặt ngay dưới input
                                voucherSuggestionContainer.style.left = rect.left + "0";
                                voucherSuggestionContainer.style.width = voucherCodeInput.offsetWidth + "px";
                                voucherSuggestionContainer.style.display = "block";
                            }

                            function applyVoucher(code) {
                                fetch(`/voucher/search?code=${code}`)
                                    .then(response => response.json())
                                    .then(data => {
                                        if (!data.exists || !data.vouchers.length) {
                                            alert("❌ This voucher was not found!");
                                            return;
                                        }

                                        let voucher = data.vouchers.find(v => v.code.toUpperCase() === code.toUpperCase());
                                        if (!voucher) {
                                            alert("❌ This voucher was not found!");
                                            return;
                                        }

                                        let discountAmount = 0;
                                        let appliedShippingDiscount = 0;
                                        let currentTotal = originalTotal + originalShippingFee;

                                        discountAmount = (originalTotal * voucher.discount) / 100;

                                        let totalDiscount = discountAmount + appliedShippingDiscount;
                                        currentTotal -= totalDiscount;

                                        // 🆕 **Cập nhật giá trị vào giao diện & form**
                                        voucherTitleElement.innerText = voucher.description;
                                        voucherDiscountElement.innerText = voucher.discount + "%";
                                        voucherResultContainer.style.display = "block";

                                        discountAmountElement.innerText = totalDiscount.toLocaleString('vi-VN') + " đ";
                                        finalTotalElement.innerText = currentTotal.toLocaleString('vi-VN') + " đ";

                                        // **Cập nhật giá trị vào các trường ẩn để gửi lên server**
                                        voucherCodeHidden.value = voucher.code;
                                        finalTotalHidden.value = currentTotal;
                                    })
                                    .catch(error => console.error("🚨 Error finding voucher:", error));
                            }
                        });
                    </script>

                </body>

                </html>