<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Advanced Product Search</title>
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/client/css/style.css" rel="stylesheet" />
    <!-- Include Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    <style>
        .search-container {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: nowrap;
            overflow-x: auto;
        }
        .filters-sidebar {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            background-color: #f9f9f9;
            height: fit-content;
            width: 500px;
            height: 520px;
            box-sizing: border-box;
            flex-shrink: 0;
        }
        .advanced-search-section {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            min-width: 500px;
            box-sizing: border-box;
        }
        .advanced-search-form {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            background-color: #fefefe;
        }
        .custom-product-blog {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
        }
        .custom-product-blog .product-item {
            flex: 0 0 calc(33.333% - 20px);
            max-width: calc(33.333% - 20px);
            box-sizing: border-box;
            margin-bottom: 24px;
            padding: 15px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }
        .custom-product-blog .product-item:hover {
            transform: translateY(-5px);
        }
        .custom-product-blog .product-item img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 8px;
        }
        .filter-group {
            margin-bottom: 20px;
        }
        .filter-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 8px;
        }
        .filter-group select,
        .filter-group input[type="text"],
        .filter-group input[type="number"] {
            width: 100%;
            padding: 6px 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .filter-group .range-inputs {
            display: flex;
            gap: 10px;
        }
        .filter-group .range-inputs input {
            flex: 1;
        }
        .custom-product-blog .product-item .btn {
            margin-top: 10px;
            width: 100%;
            text-align: center;
            padding: 12px;
            border-radius: 20px;
            background: #62f826;
            color: black;
            font-weight: bold;
            transition: background 0.3s;
        }
        .custom-product-blog .product-item .btn:hover {
            background: #1e600b;
        }
        .search-button {
            width: 100%;
            padding: 12px;
            background: #62f826;
            border-radius: 20px;
            font-weight: bold;
            color: black;
            cursor: pointer;
            transition: background 0.3s;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-size: 16px;
            border: none;
        }
        .search-button:hover {
            background: #1e600b;
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />
    <div class="container">
        <h2 class="mt-4">Advanced Product Search</h2>
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Home</a></li>
                <c:choose>
                    <c:when test="${empty param.factory && empty param.target && empty param.price && empty param.sort && empty param.scale && empty param.material && empty param.dimensionsMin && empty param.dimensionsMax && empty param.weightMin && empty param.weightMax}">
                        <li class="breadcrumb-item active" aria-current="page">All products</li>
                    </c:when>
                    <c:otherwise>
                        <li class="breadcrumb-item active" aria-current="page">Advanced Search Results</li>
                    </c:otherwise>
                </c:choose>
            </ol>
        </nav>
        <div class="search-container">
            <div class="filters-sidebar">
                <div>
                    <div class="mb-2"><b>Brand</b></div>
                    <c:forEach var="factory" items="${factories}">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox"
                            id="factory-${factory.id}" value="${factory.id.toString()}"
                            name="factory" <c:if test="${selectedFactories != null && selectedFactories.contains(factory.id.toString())}">checked</c:if>>
                        <label class="form-check-label"
                            for="factory-${factory.id}">${factory.name}</label>
                    </div>
                    </c:forEach>
                    <div class="mb-2"><b>Classify</b></div>
                    <c:forEach var="target" items="${targets}">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox"
                            id="target-${target.id}" value="${target.id.toString()}"
                            name="target" <c:if test="${selectedTargets != null && selectedTargets.contains(target.id.toString())}">checked</c:if>>
                        <label class="form-check-label"
                            for="target-${target.id}">${target.name}</label>
                    </div>
                    </c:forEach>
                    <div class="mb-2"><b>Prices</b></div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="price-2"
                            value="duoi-10-trieu" name="price"
                            <c:if test="${selectedPrices != null && selectedPrices.contains('duoi-10-trieu')}">checked</c:if>>
                        <label class="form-check-label" for="price-2">Under 10 million</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="price-3"
                            value="10-15-trieu" name="price"
                            <c:if test="${selectedPrices != null && selectedPrices.contains('10-15-trieu')}">checked</c:if>>
                        <label class="form-check-label" for="price-3">Between 10 - 15 million</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="price-4"
                            value="15-20-trieu" name="price"
                            <c:if test="${selectedPrices != null && selectedPrices.contains('15-20-trieu')}">checked</c:if>>
                        <label class="form-check-label" for="price-4">Between 15 - 20 million</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="checkbox" id="price-5"
                            value="tren-20-trieu" name="price"
                            <c:if test="${selectedPrices != null && selectedPrices.contains('tren-20-trieu')}">checked</c:if>>
                        <label class="form-check-label" for="price-5">Above 20 million</label>
                    </div>
                    <div class="mb-2"><b>Sorting</b></div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="sort-1"
                            value="priceAsc" name="sort"
                            <c:if test="${sort == 'priceAsc'}">checked</c:if>>
                        <label class="form-check-label" for="sort-1">Price increase</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="sort-2"
                            value="priceDesc" name="sort"
                            <c:if test="${sort == 'priceDesc'}">checked</c:if>>
                        <label class="form-check-label" for="sort-2">Price decrease</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="sort-3"
                            value="priceNone" name="sort"
                            <c:if test="${sort == null || sort == 'priceNone'}">checked</c:if>>
                        <label class="form-check-label" for="sort-3">Non sorting</label>
                    </div>
                    <div>
                        <button
                            class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4"
                            id="btnFilter" onclick="applyFilters()">
                            PRODUCTS SORTING
                        </button>
                    </div>
                </div>
            </div>
            <div class="advanced-search-section">
                <form id="advancedSearchForm" method="get" action="/search/advanced" class="advanced-search-form mb-4">
                    <div class="filter-group">
                        <label>Prices</label>
                        <div class="range-inputs">
                            <input type="number" step="0.01" min="1000" name="priceMin" placeholder="Min" value="${param.priceMin != null ? param.priceMin : ''}" />
                            <input type="number" step="0.01" min="1000" name="priceMax" placeholder="Max" value="${param.priceMax != null ? param.priceMax : ''}" />
                        </div>
                    </div>
                    <div class="filter-group">
                        <label for="scale">Scale</label>
                        <select name="scale" id="scale" multiple style="width: 100%;">
                            <c:forEach var="scaleOption" items="${scales}">
                                <option value="${scaleOption}" <c:if test="${selectedScales != null && selectedScales.contains(scaleOption)}">selected</c:if>>${scaleOption}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="material">Material</label>
                        <select name="material" id="material" multiple style="width: 100%;">
                            <c:forEach var="materialOption" items="${materials}">
                                <option value="${materialOption}" <c:if test="${selectedMaterials != null && selectedMaterials.contains(materialOption)}">selected</c:if>>${materialOption}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label>Dimensions</label>
                        <div class="range-inputs">
                            <input type="number" step="0.01" min="0" name="dimensionsMin" placeholder="Min" value="${param.dimensionsMin != null ? param.dimensionsMin : ''}" />
                            <input type="number" step="0.01" min="0" name="dimensionsMax" placeholder="Max" value="${param.dimensionsMax != null ? param.dimensionsMax : ''}" />
                        </div>
                    </div>
                    <div class="filter-group">
                        <label>Weight</label>
                        <div class="range-inputs">
                            <input type="number" step="0.01" min="0" name="weightMin" placeholder="Min" value="${param.weightMin != null ? param.weightMin : ''}" />
                            <input type="number" step="0.01" min="0" name="weightMax" placeholder="Max" value="${param.weightMax != null ? param.weightMax : ''}" />
                        </div>
                    </div>
                    <c:forEach var="factory" items="${selectedFactories}">
                        <input type="hidden" name="factory" value="${factory}" />
                    </c:forEach>
                    <c:forEach var="target" items="${selectedTargets}">
                        <input type="hidden" name="target" value="${target}" />
                    </c:forEach>
                    <c:forEach var="price" items="${selectedPrices}">
                        <input type="hidden" name="price" value="${price}" />
                    </c:forEach>
                    <input type="hidden" name="sort" value="${sort != null ? sort : 'priceNone'}" />
                    <button type="submit" class="search-button">Search</button>
                </form>
            </div>
        </div>
        <div class="custom-product-blog product-list">
            <c:forEach var="product" items="${products}">
                <c:if test="${product.status == true}">
                    <div class="product-item">
                        <div class="rounded position-relative">
                            <div class="fruite-img">
                                <img src="/images/product/${product.image}"
                                    class="img-fluid w-100 rounded-top" alt="">
                            </div>
                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                style="top: 10px; left: 10px;">
                                ${product.category.name}
                            </div>
                            <div
                                class="p-4 border border-secondary border-top-0 rounded-bottom">
                                <h4 style="font-size: 15px; text-align: center; margin: 0;">
                                    <a
                                        href="/product/${product.id}" style="display: inline-block; width: 100%;">${product.name}</a>
                                </h4>
                                <p class="product-desc">${product.shortDesc}</p>
                                <p style="font-size: 15px; text-align: center; width: 100%;"
                                    class="text-dark fw-bold mb-3">
                                    <fmt:formatNumber type="number"
                                        value="${product.price}" /> đ
                                </p>
                                <c:choose>
                                    <c:when test="${product.quantity > 0}">
                                        <form
                                            action="/add-products-to-cart/${product.id}"
                                            method="post">
                                            <input type="hidden"
                                                name="${_csrf.parameterName}"
                                                value="${_csrf.token}" />
                                            <button class="btn"><i
                                                    class="fa fa-shopping-bag me-2"></i>Add to cart</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary" disabled>Out of stock</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <c:if test="${totalPages > 0}">
            <div class="pagination d-flex justify-content-center mt-5">
                <ul class="pagination">
            <li class="page-item">
                <a class="${0 == currentPage ? 'disabled page-link' : 'page-link'}"
                    href="/search/advanced?page=${currentPage - 1}${queryString}"
                    aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                <li class="page-item">
                    <a class="${loop.index == currentPage ? 'active page-link' : 'page-link'}"
                        href="/search/advanced?page=${loop.index}${queryString}">
                        ${loop.index + 1}
                    </a>
                </li>
            </c:forEach>
            <li class="page-item">
                <a class="${totalPages - 1 == currentPage ? 'disabled page-link' : 'page-link'}"
                    href="/search/advanced?page=${currentPage + 1}${queryString}"
                    aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
                </ul>
            </div>
        </c:if>
    </div>

</body>
<!-- Include jQuery and Select2 JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    $(document).ready(function() {
        // Initialize Select2 on scale and material selects with allowClear to enable deselect
        $('#scale').select2({
            placeholder: "Select scales",
            allowClear: true,
            width: '100%'
        }).on('select2:selecting', function(e) {
            var selectedValues = $(this).val() || [];
            var selectedValue = e.params.args.data.id;
            if (selectedValues.indexOf(selectedValue) !== -1) {
                e.preventDefault();
                var newValues = selectedValues.filter(function(value) {
                    return value !== selectedValue;
                });
                $(this).val(newValues).trigger('change');
            }
        });

        $('#material').select2({
            placeholder: "Select materials",
            allowClear: true,
            width: '100%'
        }).on('select2:selecting', function(e) {
            var selectedValues = $(this).val() || [];
            var selectedValue = e.params.args.data.id;
            if (selectedValues.indexOf(selectedValue) !== -1) {
                e.preventDefault();
                var newValues = selectedValues.filter(function(value) {
                    return value !== selectedValue;
                });
                $(this).val(newValues).trigger('change');
            }
        });
    });

    function applyFilters() {
        const url = new URL(window.location.href);
        const params = new URLSearchParams();

        // Add selected factory filters
        document.querySelectorAll('input[name="factory"]:checked').forEach(el => {
            params.append('factory', el.value);
        });

        // Add selected target filters
        document.querySelectorAll('input[name="target"]:checked').forEach(el => {
            params.append('target', el.value);
        });

        // Add selected price filters
        document.querySelectorAll('input[name="price"]:checked').forEach(el => {
            params.append('price', el.value);
        });

        // Add priceMin and priceMax from advanced search form
        const priceMin = document.querySelector('input[name="priceMin"]');
        const priceMax = document.querySelector('input[name="priceMax"]');
        if (priceMin && priceMin.value.trim() !== '') {
            params.set('priceMin', priceMin.value.trim());
        }
        if (priceMax && priceMax.value.trim() !== '') {
            params.set('priceMax', priceMax.value.trim());
        }

        // Add selected sort filter
        const sort = document.querySelector('input[name="sort"]:checked');
        if (sort) {
            params.set('sort', sort.value);
        }

        // Add scale filter
        const scaleElements = document.querySelectorAll('select[name="scale"] option:checked');
        if (scaleElements.length > 0) {
            const scaleValues = Array.from(scaleElements).map(el => el.value).join(',');
            params.set('scale', scaleValues);
        }

        // Add material filter
        const materialElements = document.querySelectorAll('select[name="material"] option:checked');
        if (materialElements.length > 0) {
            const materialValues = Array.from(materialElements).map(el => el.value).join(',');
            params.set('material', materialValues);
        }

        // Add dimensionsMin and dimensionsMax filter
        const dimensionsMin = document.querySelector('input[name="dimensionsMin"]');
        const dimensionsMax = document.querySelector('input[name="dimensionsMax"]');
        if (dimensionsMin && dimensionsMin.value.trim() !== '') {
            params.set('dimensionsMin', dimensionsMin.value.trim());
        }
        if (dimensionsMax && dimensionsMax.value.trim() !== '') {
            params.set('dimensionsMax', dimensionsMax.value.trim());
        }

        // Add weightMin and weightMax filter
        const weightMin = document.querySelector('input[name="weightMin"]');
        const weightMax = document.querySelector('input[name="weightMax"]');
        if (weightMin && weightMin.value.trim() !== '') {
            params.set('weightMin', weightMin.value.trim());
        }
        if (weightMax && weightMax.value.trim() !== '') {
            params.set('weightMax', weightMax.value.trim());
        }

        // Reset to first page on filter change
        params.set('page', '0');

        // Redirect with updated query params
        window.location.href = url.pathname + '?' + params.toString();
    }
</script>
</html>
