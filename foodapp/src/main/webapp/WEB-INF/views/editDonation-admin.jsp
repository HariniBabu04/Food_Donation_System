<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <a class="navbar-brand" href="#">Surplus Food Donation</a>
        <div class="ms-auto">
            <a href="manageDonation-admin" class="btn btn-light btn-sm">Back</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h3 class="mb-4">Edit Donation</h3>

    <div class="card">
        <div class="card-body">

            <!-- ✅ FORM START -->
            <form action="updateDonation" method="post">

                <!-- HIDDEN ID -->
                <input type="hidden" name="donationId" value="${donation.donationId}">

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Food Name</label>
                        <input type="text" name="foodName" class="form-control"
                               value="${donation.foodName}" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Donor Name</label>
                        <input type="text" class="form-control"
                               value="${donation.donor.name}" readonly>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">NGO Name</label>
                        <input type="text" class="form-control"
                               value="${donation.ngo != null ? donation.ngo.organizationName : '-'}" readonly>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Quantity</label>
                        <input type="text" name="quantity" class="form-control"
                               value="${donation.quantity}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Location</label>
                    <input type="text" name="pickupAddress" class="form-control"
                           value="${donation.pickupAddress}" required>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Prepared Date</label>
                        <input type="date" name="preparedDate" class="form-control"
                               value="${donation.preparedDate}">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Expiry Time</label>
                        <input type="time" name="expiryTime" class="form-control"
                               value="${donation.expiryTime}">
                    </div>
                </div>

                <!-- STATUS -->
                <div class="mb-3">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">

                        <option value="CREATED"
                            ${donation.status == 'CREATED' ? 'selected' : ''}>Available</option>

                        <option value="ACCEPTED"
                            ${donation.status == 'ACCEPTED' ? 'selected' : ''}>Accepted</option>

                        <option value="PICKED"
                            ${donation.status == 'PICKED' ? 'selected' : ''}>Picked Up</option>

                        <option value="COMPLETED"
                            ${donation.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>

                        <option value="EXPIRED"
                            ${donation.status == 'EXPIRED' ? 'selected' : ''}>Expired</option>

                        <option value="CANCELLED"
                            ${donation.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>

                    </select>
                </div>

                <!-- BUTTONS -->
                <div class="text-end">
                    <button type="submit" class="btn btn-success">
                        Update Donation
                    </button>

                    <a href="manageDonation-admin" class="btn btn-secondary">
                        Cancel
                    </a>
                </div>

            </form>
            <!-- ✅ FORM END -->

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>