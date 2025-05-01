<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Contact</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icon -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>

<body class="sb-nav-fixed">
    <!-- Main Wrapper: Sidebar and Content -->
    <div class="d-flex">
        <!-- Sidebar Section -->
        <div class="sidebar bg-light" style="width: 250px;">
            <jsp:include page="../layout/navbar.jsp" />
        </div>

        <!-- Content Section -->
        <div class="flex-grow-1" id="layoutSidenav_content">
            <jsp:include page="../layout/header.jsp" />
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">View Contact</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin/user">Dashboard</a></li>
                        <li class="breadcrumb-item active">View Contact</li>
                    </ol>

                    <!-- Contact List Table -->
                    <div class="mt-5">
                        <div class="row">
                            <div class="col-12">
                                <h3>List Contact</h3>
                                <hr />
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">Email</th>
                                            <th scope="col">Subject Name</th>
                                            <th scope="col">Status</th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Populate Contact List -->
                                        <c:forEach var="contact" items="${contactList}">
                                            <tr>
                                                <td>${contact.user.email}</td>
                                                <td>${contact.subjectName}</td>
                                                <td>
                                                    <form action="/admin/contact/toggle-status" method="post" style="display:inline;">
                                                        <input type="hidden" name="id" value="${contact.id}" />
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                        <label class="switch">
<input type="checkbox" name="statusToggle" data-reply="${not empty contact.replyMessage}" onchange="toggleStatus(this, ${contact.id})" <c:if test="${contact.status}">checked</c:if> <c:if test="${not empty contact.replyMessage}">disabled</c:if>>
                                                            <span class="slider round"></span>
                                                        </label>
                                                    </form>
                                                </td>
                                                <td>
                                                    <a href="/admin/contact/view/${contact.id}"
                                                        class="btn btn-info btn-sm">
                                                        Details
                                                    </a>
                                                    <a href="/admin/contact/reply/${contact.id}"
                                                        class="btn btn-warning btn-sm">
                                                        Reply
                                                    </a>
                                                    <!-- Delete button removed -->
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <!-- Display if contactList is empty -->
                                        <c:if test="${empty contactList}">
                                            <tr>
                                                <td colspan="4" class="text-center">No contact list found
                                                    here</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>

                                <!-- Success and Error Messages -->
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success" role="alert">
                                        ${successMessage}
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger" role="alert">
                                        ${errorMessage}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
    <style>
        /* The switch - the box around the slider */
        .switch {
          position: relative;
          display: inline-block;
          width: 50px;
          height: 24px;
        }
        
        /* Hide default HTML checkbox */
        .switch input {
          opacity: 0;
          width: 0;
          height: 0;
        }
        
        /* The slider */
        .slider {
          position: absolute;
          cursor: pointer;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background-color: #ccc;
          transition: .4s;
          border-radius: 24px;
        }
        
        .slider:before {
          position: absolute;
          content: "";
          height: 18px;
          width: 18px;
          left: 3px;
          bottom: 3px;
          background-color: white;
          transition: .4s;
          border-radius: 50%;
        }
        
        input:checked + .slider {
          background-color: #4CAF50;
        }
        
        input:focus + .slider {
          box-shadow: 0 0 1px #4CAF50;
        }
        
        input:checked + .slider:before {
          transform: translateX(26px);
        }
        
        input:disabled + .slider {
          background-color: #999;
          cursor: not-allowed;
        }
        
        input:disabled + .slider:before {
          background-color: #ccc;
        }
    </style>
    <script>
        function toggleStatus(checkbox, contactId) {
            if (checkbox.disabled) {
                checkbox.checked = !checkbox.checked;
                return;
            }
            const form = checkbox.closest('form');
            form.submit();
        }
    </script>
</body>

</html>
