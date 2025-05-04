<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions"
prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Voucher Management</title>
		<!-- Bootstrap CSS -->
		<link
			href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
			rel="stylesheet"
		/>
		<!-- Bootstrap Icon -->
		<link
			rel="stylesheet"
			href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
		/>
		<!-- Custom CSS -->
		<link rel="stylesheet" href="/css/ewstyle.css" />
	</head>

	<body>
		<div class="container-fluid d-flex p-0">
			<jsp:include page="../layout/navbar.jsp" />

			<!-- Main Content -->
			<div class="main-content p-0">
				<jsp:include page="../layout/header.jsp" />

				<div class="p-4">
					<h1 class="mb-4 mt-4 text-center" style="font-weight: bold">Voucher Management</h1>
					<c:if test="${not empty successMessage}">
						<div class="alert alert-success" role="alert">${successMessage}</div>
					</c:if>
					<c:if test="${not empty errorMessage}">
						<div class="alert alert-danger" role="alert">${errorMessage}</div>
					</c:if>
					<table class="table table-bordered table-hover align-middle text-center">
						<ol class="breadcrumb mb-4">
							<li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
							<li class="breadcrumb-item active">Voucher</li>
						</ol>
						<div class="mt-5">
							<div class="row">
								<div class="col-12 mx-auto">
									<div class="d-flex justify-content-between">
										<h3>Voucher Management</h3>
										<a href="/admin/voucher/create" class="btn btn-primary">Create Voucher</a>
									</div>

									<hr />
									<table class="table table-bordered table-hover">
										<thead>
											<tr>
												<th>ID</th>
												<th>Code</th>
												<th>Discount</th>
												<th>Quantity</th>
												<th>Valid From</th>
												<th>Valid To</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="voucher" items="${vouchers}">
												<tr>
													<td>${voucher.id}</td>
													<td>${voucher.code}</td>
													<td>${voucher.discount}</td>
													<td>${voucher.quantity}</td>
													<td>${fn:split(voucher.validFrom, ' ')[0]}</td>
													<td>${fn:split(voucher.validTo, ' ')[0]}</td>
													<td>
														<a href="/admin/voucher/${voucher.id}" class="btn btn-success">View</a>
														<a href="/admin/voucher/update/${voucher.id}" class="btn btn-warning mx-2">Update</a>
														<a href="/admin/voucher/delete/${voucher.id}" class="btn btn-danger">Delete</a>
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
		<!-- Bootstrap JS -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
