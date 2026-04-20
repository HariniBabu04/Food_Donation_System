<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Edit User</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">


</head>

<body>


<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Surplus Food Donation</a>
    </div>
</nav>

<!-- MAIN CONTAINER -->
<div class="container mt-4">
    <h3 class="mb-4">Edit User</h3>

    <!-- FORM START -->
    <form action="${pageContext.request.contextPath}/updateUser" method="post">

        <!-- Hidden ID -->
        <input type="hidden" name="userId" value="${user.userId}" />

        <!-- NAME -->
        <div class="mb-3">
            <label class="form-label">User Name</label>
            <input type="text" class="form-control" name="name" value="${user.name}" required>
        </div>

        <!-- EMAIL -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="email" value="${user.email}" required>
        </div>

        <!-- PHONE -->
        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" class="form-control" name="phone" value="${user.phone}" required>
        </div>

        <!-- ROLE -->
        <div class="mb-3">
            <label class="form-label">Role</label>
            <select class="form-select" name="role" id="roleSelect">
                <option value="donor" ${user.role=='donor' ? 'selected' : ''}>Donor</option>
                <option value="ngo" ${user.role=='ngo' ? 'selected' : ''}>NGO</option>
                <option value="volunteer" ${user.role=='volunteer' ? 'selected' : ''}>Volunteer</option>
                <option value="admin" ${user.role=='admin' ? 'selected' : ''}>Admin</option>
            </select>
        </div>

        <!-- ORGANIZATION -->
        <div class="mb-3" id="orgField">
            <label class="form-label">Organization</label>
            <input type="text" class="form-control" name="organizationName" value="${user.organizationName}">
        </div>

        <!-- STATUS -->
        <div class="mb-3">
            <label class="form-label">Status</label>
            <select class="form-select" name="status">
                <option value="Active" ${user.status=='Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${user.status=='Inactive' ? 'selected' : ''}>Inactive</option>
                <option value="Blocked" ${user.status=='Blocked' ? 'selected' : ''}>Blocked</option>
            </select>
        </div>

        <!-- BUTTONS -->
        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="${pageContext.request.contextPath}/manageUsers" class="btn btn-secondary">Cancel</a>

    </form>
    <!-- FORM END -->

</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/script.js"

</body></html>
