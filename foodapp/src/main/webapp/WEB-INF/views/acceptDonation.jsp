<%@ include file="/WEB-INF/common/header.jsp" %>
<div class="container-fluid">
    <div class="row">

        <%@ include file="/WEB-INF/common/sidebar-ngo.jsp" %>

        <div class="container my-4">
            <div class="card shadow">
                <div class="card-body">

                    <h5 class="text-success mb-3">Accept Food Donation</h5>

                    <!-- FORM (added ID for JS control) -->
                    <form id="acceptForm" class="row g-3"
                          action="/acceptDonation/${donation.donationId}"
                          method="post">

                        <!-- Food Information -->
                        <div class="col-12">
                            <h6 class="text-secondary">Food Information</h6>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Food Name</label>
                            <input type="text" class="form-control" value="${donation.foodName}" readonly>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Food Type</label>
                            <input type="text" class="form-control" value="${donation.foodType}" readonly>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Quantity</label>
                            <input type="number" class="form-control" value="${donation.quantity}" readonly>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Expiry Date & Time</label>
                            <input type="text" class="form-control"
                                   value="${donation.expiryDate} ${donation.expiryTime}" readonly>
                        </div>

                        <!-- Location -->
                        <div class="col-12 mt-3">
                            <h6 class="text-secondary">Location Information</h6>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Pickup Address</label>
                            <input type="text" class="form-control" value="${donation.pickupAddress}" readonly>
                        </div>

                        <!-- Donor -->
                        <div class="col-12 mt-3">
                            <h6 class="text-secondary">Donor Information</h6>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Donor / Organization Name</label>
                            <input type="text" class="form-control" value="${donation.donor.name}" readonly>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Contact Number</label>
                            <input type="text" class="form-control" value="${donation.contactNumber}" readonly>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Special Instructions</label>
                            <textarea class="form-control" rows="2">${donation.remarks}</textarea>
                        </div>

                        <!-- NGO -->
                        <div class="col-12 mt-3">
                            <h6 class="text-secondary">NGO Information</h6>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">NGO Name</label>
                            <input type="text" class="form-control" value="${donation.ngo.name}" readonly>
                        </div>

                        <!-- Pickup Planning -->
                        <div class="col-12 mt-3">
                            <h6 class="text-secondary">Pickup Planning</h6>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Expected Pickup Time</label>
                            <input type="datetime-local" class="form-control" name="expectedPickupTime">
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Volunteers</label>
                            <input type="number" class="form-control" name="numberOfVolunteers">
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Vehicle Type</label>
                            <select class="form-select" name="vehicleType">
                                <option>Bike</option>
                                <option>Van</option>
                                <option>Truck</option>
                            </select>
                        </div>

                        <!-- ACTION BUTTONS -->
                        <div class="col-12 d-flex justify-content-end gap-2 mt-4">
                            <button type="submit" class="btn btn-success">
                                Accept Donation
                            </button>

                            <button type="button" class="btn btn-outline-danger"
                                    onclick="window.location.href='/viewDonation'">
                                Cancel
                            </button>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/common/footer.jsp" %>

<!-- ================= JS ================= -->
<script>
document.getElementById("acceptForm").addEventListener("submit", function(event) {

    event.preventDefault(); // stop immediate submit

    let donorName = "${donation.donor.name}";

    // 🔥 Browser Console Message
    console.log("📲 OTP sent to donor: " + donorName);

    // Popup for UI
    alert("OTP sent to donor: " + donorName);

    // Now submit form to backend
    this.submit();
});
</script>