<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Manage Order</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icon -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
            <!-- Custom CSS -->
            <link rel="stylesheet" href="/css/ewstyle.css">
        </head>

        <body>
            <div class="container-fluid d-flex p-0">
                <!-- Sidebar -->
                <jsp:include page="../layout/navbar.jsp" />


                <!-- Main Content -->

                <div class="main-content p-0">

                    <jsp:include page="../layout/header.jsp" />
                    <div class="p-4">
                        <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Manage User</h1>
                        <table class="table table-bordered table-hover align-middle text-center">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item active">Users</li>
                            </ol>
                            <div class="mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3>Table users</h3>
                                            <a href="/admin/user/create" class="btn btn-primary">Create a user</a>
                                        </div>

                                        <hr />
                                        <table class=" table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Email</th>
                                                    <th>Full Name</th>
                                                    <th>Role</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="user" items="${users}">

                                                    <tr>
                                                        <th>${user.id}</th>
                                                        <td>${user.email}</td>
                                                        <td>${user.fullName}</td>
                                                        <td>${user.role.name}</td>
                                                        <td>
                                                            <a href="/admin/user/${user.id}"
                                                                class="btn btn-success">View</a>
                                                            <a href="/admin/user/update/${user.id}"
                                                                class="btn btn-warning  mx-2">Update</a>
                                                            <a href="/admin/user/delete/${user.id}"
                                                                class="btn btn-danger">Delete</a>
                                                        </td>
                                                    </tr>

                                                </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>

                                </div>

                            </div>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel"
                aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="orderDetailModalLabel">Order Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h6><strong>Order ID:</strong> <span id="order-id"></span></h6>
                            <h6><strong>Order Date:</strong> <span id="order-date"></span></h6>
                            <h6><strong>Customer Name:</strong> <span id="customer-name"></span></h6>
                            <h6><strong>Total Price:</strong> <span id="total-price"></span></h6>
                            <h6><strong>Order Status:</strong> <span id="order-status"></span></h6>
                            <h5 class="mt-4">Ordered Items:</h5>
                            <ul id="ordered-items-list"></ul>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                function filterOrders() {
                    const statusFilter = document.getElementById('status-filter').value;
                    const rows = document.querySelectorAll('#order-table-body tr');
                    rows.forEach(row => {
                        const status = row.querySelector('span.badge').innerText;
                        if (statusFilter === "All" || status === statusFilter) {
                            row.style.display = '';
                        } else {
                            row.style.display = 'none';
                        }
                    });
                }

                function changeStatus(elementId, newStatus, badgeClass) {
                    const badge = document.getElementById(elementId);
                    badge.innerText = newStatus;
                    badge.className = `badge ${badgeClass}`;
                }

                function showOrderDetails(id, date, customerName, totalPrice, status, items) {
                    document.getElementById('order-id').innerText = id;
                    document.getElementById('order-date').innerText = date;
                    document.getElementById('customer-name').innerText = customerName;
                    document.getElementById('total-price').innerText = totalPrice;
                    document.getElementById('order-status').innerText = status;

                    const itemsList = document.getElementById('ordered-items-list');
                    itemsList.innerHTML = '';
                    items.forEach(item => {
                        const li = document.createElement('li');
                        li.innerText = `${item.name} - $${item.price} (Quantity: ${item.quantity})`;
                        itemsList.appendChild(li);
                    });
                }
            </script>
        </body>

        </html>