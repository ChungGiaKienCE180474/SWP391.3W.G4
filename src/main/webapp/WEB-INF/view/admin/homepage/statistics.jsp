<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Revenue Statistics</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Bootstrap Icon -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                <!-- Custom CSS -->
                <link rel="stylesheet" href="/css/ewstyle.css">

                <style>
                    body {
                        background-color: #f8f9fa;
                    }

                    .table thead {
                        background-color: #007bff;
                        color: white;
                    }

                    .card {
                        border: none;
                        border-radius: 16px;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
                        background-color: white;
                    }

                    .form-select {
                        max-width: 300px;
                        margin: auto;
                    }

                    .breadcrumb {
                        background-color: transparent;
                    }
                </style>
            </head>

            <body>
                <div class="container-fluid d-flex p-0">
                    <jsp:include page="../layout/navbar.jsp" />

                    <div class="main-content p-0">
                        <jsp:include page="../layout/header.jsp" />

                        <div class="p-4">
                            <h1 class="mb-4 mt-4 text-center fw-bold text-primary">📊 Revenue Statistics</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Home Page</a></li>
                                <li class="breadcrumb-item active">Statistical</li>
                            </ol>

                            <!-- Form chọn năm -->
                            <form method="get" action="/admin" class="text-center mb-4">
                                <label for="yearSelection" class="form-label fw-semibold">Select Year:</label>
                                <select id="yearSelection" name="year" class="form-select d-inline-block"
                                    onchange="this.form.submit()">
                                    <c:forEach var="y" items="${yearsWithData}">
                                        <option value="${y}" <c:if test="${y == selectedYear}">selected</c:if>>${y}
                                        </option>
                                    </c:forEach>
                                </select>
                            </form>

                            <!-- Bảng dữ liệu -->
                            <div class="card p-4 mb-4">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover align-middle text-center">
                                        <thead>
                                            <tr>
                                                <th>Month</th>
                                                <th>Revenue (VND)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="entry" items="${monthlyRevenue}">
                                                <tr>
                                                    <td>Month ${entry.key}</td>
                                                    <td>
                                                        <fmt:formatNumber type="number" value="${entry.value}" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Biểu đồ -->
                            <div class="card p-4">
                                <div id="chart_div" style="width: 100%; height: 400px;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Google Charts -->
                <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
                <script type="text/javascript">
                    google.charts.load('current', { 'packages': ['corechart'] });
                    google.charts.setOnLoadCallback(drawChart);

                    function drawChart() {
                        var data = google.visualization.arrayToDataTable([
                            ['Tháng', 'Doanh thu (VNĐ)'],
                            <c:forEach var="entry" items="${monthlyRevenue}" varStatus="loop">
                                ['Month ${entry.key}', ${entry.value}]<c:if test="${!loop.last}">,</c:if>
                            </c:forEach>
                        ]);

                        var options = {
                            title: 'Monthly Revenue Statistics',
                            hAxis: {
                                title: 'Month',
                                titleTextStyle: { bold: true, color: '#333' },
                                textStyle: { fontSize: 12 }
                            },
                            vAxis: {
                                title: 'Revenue (VND)',
                                titleTextStyle: { bold: true, color: '#333' },
                                textStyle: { fontSize: 12 },
                                format: 'short'
                            },
                            legend: { position: 'none' },
                            colors: ['#007bff'],
                            backgroundColor: 'transparent',
                            chartArea: { width: '85%', height: '70%' },
                            bar: { groupWidth: '60%' }
                        };

                        if (data.getNumberOfRows() === 0) {
                            document.getElementById('chart_div').innerHTML = "<p class='text-center text-muted'>No data available for this year.</p>";
                        } else {
                            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                            chart.draw(data, options);
                        }
                    }
                </script>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>