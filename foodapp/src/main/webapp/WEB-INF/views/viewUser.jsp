<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>View User</title>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">


</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Surplus Food Donation</a>

        <div class="ms-auto">
            <a class="btn btn-light btn-sm" 
               href="${pageContext.request.contextPath}/manageUsers">
               Back to Manage Users
            </a>
        </div>
    </div>
</nav>

<!-- CONTENT -->
<div class="container mt-4">
    <h3 class="mb-4">View User</h3>

    <div class="border p-4 rounded bg-light">

        <p><strong>User ID:</strong> ${user.userId}</p>
        <p><strong>Name:</strong> ${user.name}</p>
        <p><strong>Role:</strong> <span class="text-capitalize">${user.role}</span></p>
        <p><strong>Email:</strong> ${user.email}</p>
        <p><strong>Phone:</strong> ${user.phone}</p>

        <p><strong>Organization:</strong> 
            <c:choose>
                <c:when test="${user.role == 'ngo'}">
                    ${user.organizationName}
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </p>

        <p><strong>Status:</strong> 
            <span class="badge 
                ${user.status=='Active' ? 'bg-success' : 
                  (user.status=='Blocked' ? 'bg-danger' : 'bg-secondary')}">
                ${user.status}
            </span>
        </p>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
