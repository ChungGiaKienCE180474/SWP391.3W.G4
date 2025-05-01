<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- CSS riêng cho tab trong phần Order -->
<style>
  .order-tab-wrapper .nav-tabs .nav-link {
    color: #555;
    border: 1px solid transparent;
    padding: 10px 20px;
    background-color: #f8f9fa;
    transition: 0.3s;
  }

  .order-tab-wrapper .nav-tabs .nav-link:hover {
    background-color: #e9ecef;
    color: #000;
  }

  .order-tab-wrapper .nav-tabs .nav-link.active {
    font-weight: bold;
    color: #0d6efd;
    background-color: #fff;
    border-color: #dee2e6 #dee2e6 #fff;
    border-bottom: 3px solid #0d6efd;
  }
</style>

<!-- Tab điều hướng được bọc bởi class riêng -->
<div class="order-tab-wrapper">
  <ul class="nav nav-tabs mb-4" id="orderTabs" role="tablist">
    <li class="nav-item">
      <a
        class="nav-link ${pageContext.request.requestURI.contains('/order/tracking') ? 'active' : ''}"
        href="${pageContext.request.contextPath}/customer/order/tracking"
        role="tab"
      >
        Order Tracking
      </a>
    </li>
    <li class="nav-item">
      <a
        class="nav-link ${pageContext.request.requestURI.contains('/order/history') ? 'active' : ''}"
        href="${pageContext.request.contextPath}/customer/order/history"
        role="tab"
      >
        Order History
      </a>
    </li>
    <li class="nav-item">
      <a
        class="nav-link ${pageContext.request.requestURI.contains('/order/cancelled') ? 'active' : ''}"
        href="${pageContext.request.contextPath}/customer/order/cancelled"
        role="tab"
      >
        Cancelled Orders
      </a>
    </li>
    <li class="nav-item">
      <a
        class="nav-link ${pageContext.request.requestURI.contains('/order/rated') ? 'active' : ''}"
        href="${pageContext.request.contextPath}/customer/order/rated"
        role="tab"
      >
        Rated Orders
      </a>
    </li>
    <li class="nav-item">
      <a
        class="nav-link ${pageContext.request.requestURI.contains('/order/unrated') ? 'active' : ''}"
        href="${pageContext.request.contextPath}/customer/order/unrated"
        role="tab"
      >
        Unrated Orders
      </a>
    </li>
  </ul>
</div>
