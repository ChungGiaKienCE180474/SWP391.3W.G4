<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib uri="http://www.springframework.org/tags/form"
prefix="form" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
		<meta name="description" content="Group 4 - Dự án Legoshop" />
		<meta name="author" content="Group 4" />
		<title>Update Voucher</title>
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
		<link
			href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
			rel="stylesheet"
		/>
		<link href="/css/styles.css" rel="stylesheet" />
		<script
			src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
			crossorigin="anonymous"
		></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	</head>

	<body>
		<div class="container-fluid d-flex p-0">
			<!-- Sidebar -->
			<jsp:include page="../layout/navbar.jsp" />

			<!-- Main Content -->
			<div class="main-content p-0">
				<jsp:include page="../layout/header.jsp" />
				<div class="container mt-4">
					<!-- Breadcrumb -->
					<h1 class="mt-4">Dashboard</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
						<li class="breadcrumb-item"><a href="/admin/voucher">Voucher</a></li>
						<li class="breadcrumb-item active">Edit Voucher ${voucher.id}</li>
					</ol>

					<div class="container-fluid px-4">
						<div class="mt-5">
							<div class="row">
								<div class="col-md-6 col-12 mx-auto">
									<h3>Edit Voucher ${voucher.id}</h3>
									<hr />
									<c:if test="${not empty successMessage}">
										<div class="alert alert-success" role="alert">${successMessage}</div>
									</c:if>
									<c:if test="${not empty errorMessage}">
										<div class="alert alert-danger" role="alert">${errorMessage}</div>
									</c:if>
									<form:form
										method="post"
										action="/admin/voucher/update/${voucher.id}"
										modelAttribute="voucher"
										class="row"
									>
										<div class="mb-3 col-12 col-md-6">
											<label class="form-label">Voucher Code:</label>
											<form:input
												type="text"
												class="form-control"
												path="code"
												required="required"
												value="${voucher.code}"
											/>
										</div>
										<div class="mb-3 col-12 col-md-6">
											<label class="form-label">Voucher Title:</label>
											<form:input
												type="text"
												class="form-control"
												path="title"
												required="required"
												value="${voucher.title}"
											/>
										</div>
										<div class="mb-3 col-12 col-md-6">
											<label class="form-label">Voucher Description:</label>
											<form:input
												type="text"
												class="form-control"
												path="description"
												required="required"
												value="${voucher.description}"
											/>
										</div>
										<div class="mb-3 col-12 col-md-6">
											<label class="form-label">Voucher Discount:</label>
											<div class="input-group">
												<div class="input-group-prepend">
													<span class="input-group-text">%</span>
												</div>
												<form:input
													type="number"
													min="1"
													max="75"
													class="form-control"
													path="discount"
													required="required"
													value="${voucher.discount}"
												/>
											</div>
										</div>
										<div class="mb-3 col-12 col-md-6">
											<label class="form-label">Voucher Quantity:</label>
											<form:input
												type="number"
												min="0"
												class="form-control"
												path="quantity"
												required="required"
												value="${voucher.quantity}"
											/>
										</div>
										<div class="mb-3 col-12 col-md-6">
											<label class="form-label">Voucher Start Date:</label>
											<form:input
												type="date"
												class="form-control"
												path="validFrom"
												required="required"
												value="${fn:split(voucher.validFrom, ' ')[0]}"
											/>
										</div>

										<div class="mb-3 col-12 col-md-6">
											<label class="form-label">Voucher End Date:</label>
											<form:input
												type="date"
												class="form-control"
												path="validTo"
												required="required"
												value="${fn:split(voucher.validTo, ' ')[0]}"
											/>
										</div>

										<div class="col-12 mb-5">
											<button type="submit" class="btn btn-primary">Edit</button>
										</div>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Bootstrap JS and custom scripts -->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
			crossorigin="anonymous"
		></script>
		<script src="js/scripts.js"></script>
	</body>
</html>
