<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Delete Contact Disabled</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="sb-nav-fixed">
    <div class="d-flex">
        <div class="sidebar bg-light" style="width: 250px;">
            <jsp:include page="../layout/navbar.jsp" />
        </div>
        <div class="flex-grow-1" id="layoutSidenav_content">
            <jsp:include page="../layout/header.jsp" />
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4 text-danger">Delete Contact Disabled</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/contact">Contacts</a></li>
                        <li class="breadcrumb-item active">Delete Disabled</li>
                    </ol>
                    <div class="alert alert-warning mt-5">
                        Deleting contacts has been disabled. Please contact the administrator if you have questions.
                    </div>
                    <a href="/admin/contact" class="btn btn-primary">Back to Contact List</a>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
