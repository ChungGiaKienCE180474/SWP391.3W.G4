<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Create Order</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
                </head>

                <body>

                    <div class="container py-5 mt-5">
                        <div class="row justify-content-center">
                            <div class="col-md-6">
                                <div class="card shadow-lg p-4">
                                    <div class="card-body text-center">
                                        <h2 class="card-title mb-4">Create Order</h2>
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger">${error}</div>
                                        </c:if>
                                        <form action="${pageContext.request.contextPath}/submitOrder" method="get">
                                            <div class="container">
                                                <div class="row mb-2">
                                                    <label for="ordertype" class="col-md-4 text-end fw-bold">Type of
                                                        Goods</label>
                                                    <div class="col-md-8">
                                                        <select name="ordertype" id="ordertype" class="form-control">
                                                            <option value="billpayment">Pay bills</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="row mb-2">
                                                    <label class="col-md-4 text-end fw-bold">Amount (VND)</label>
                                                    <div class="col-md-8">
                                                        <input type="text" class="form-control"
                                                            value="<fmt:formatNumber value='${totalAmount}' type='number' groupingUsed='true' minFractionDigits='0' maxFractionDigits='0'/> VND"
                                                            readonly>
                                                        <input type="hidden" id="amount" name="amount"
                                                            value="${totalAmount}">
                                                    </div>
                                                </div>

                                                <div class="row mb-2">
                                                    <label for="orderInfo" class="col-md-4 text-end fw-bold">Order
                                                        Information</label>
                                                    <div class="col-md-8">
                                                        <input type="text" id="orderInfo" name="orderInfo"
                                                            value="${orderDetails}" readonly class="form-control"
                                                            required>
                                                    </div>
                                                </div>

                                                <div class="row mb-2">
                                                    <label for="address" class="col-md-4 text-end fw-bold">Receiver
                                                        Address</label>
                                                    <div class="col-md-8">
                                                        <input type="text" id="address" name="address"
                                                            class="form-control" value="${sessionScope.receiverAddress}"
                                                            required>
                                                    </div>
                                                </div>

                                                <div class="row mb-2">
                                                    <label for="name" class="col-md-4 text-end fw-bold">Receiver
                                                        Name</label>
                                                    <div class="col-md-8">
                                                        <input type="text" id="name" name="name" class="form-control"
                                                            value="${sessionScope.receiverName}" required>
                                                    </div>
                                                </div>

                                                <div class="row mb-2">
                                                    <label for="phone" class="col-md-4 text-end fw-bold">Receiver
                                                        Phone</label>
                                                    <div class="col-md-8">
                                                        <input type="text" id="phone" name="phone" class="form-control"
                                                            value="${sessionScope.receiverPhone}" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-block">Pay</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <jsp:include page="../layout/footer.jsp" />
                    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"></script>
                </body>

                </html>