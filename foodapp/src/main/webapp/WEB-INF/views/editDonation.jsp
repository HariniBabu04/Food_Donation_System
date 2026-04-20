<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Edit Donation</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-success">
<div class="container-fluid">
<a class="navbar-brand">Surplus Food Donation</a>
<div class="ms-auto">
<a href="/donor-dashboard" class="btn btn-light btn-sm">Back</a>
</div>
</div>
</nav>

<div class="container mt-4">
<h3 class="mb-4">Edit Donation</h3>

<div class="card">
<div class="card-body">

<form action="/updateDonation" method="post">

<!-- Hidden ID -->
<input type="hidden" name="donationId" value="${donation.donationId}">

<div class="row mb-3">

<div class="col-md-6">
<label class="form-label">Food Name</label>
<input type="text" name="foodName" class="form-control" value="${donation.foodName}">
</div>

<div class="col-md-6">
<label class="form-label">Quantity</label>
<input type="number" name="quantity" class="form-control" value="${donation.quantity}">
</div>

</div>

<div class="row mb-3">

<div class="col-md-6">
<label class="form-label">Food Type</label>
<input type="text" name="foodType" class="form-control" value="${donation.foodType}">
</div>

<div class="col-md-3">
<label class="form-label">Expiry Date</label>
<input type="date" name="expiryTime" class="form-control" value="${donation.expiryDate}">
</div>

<div class="col-md-3">
<label class="form-label">Expiry Time</label>
<input type="time" name="expiryTime" class="form-control" value="${donation.expiryTime}">
</div>

</div>

<div class="mb-3">
<label class="form-label">Pickup Address</label>
<input type="text" name="pickupAddress" class="form-control" value="${donation.pickupAddress}">
</div>

<div class="mb-3">
<label class="form-label">Status</label>

<select name="status" class="form-select">

<option value="CREATED" ${donation.status == 'CREATED' ? 'selected' : ''}>Pending</option>
<option value="ACCEPTED" ${donation.status == 'ACCEPTED' ? 'selected' : ''}>Accepted</option>
<option value="PICKED_UP" ${donation.status == 'PICKED_UP' ? 'selected' : ''}>Picked Up</option>
<option value="COMPLETED" ${donation.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
<option value="EXPIRED" ${donation.status == 'EXPIRED' ? 'selected' : ''}>Expired</option>
<option value="CANCELLED" ${donation.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>

</select>

</div>

<div class="text-end">

<button type="submit" class="btn btn-success">
Update Donation
</button>

<a href="/donor-dashboard" class="btn btn-secondary">
Cancel
</a>

</div>

</form>

</div>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>