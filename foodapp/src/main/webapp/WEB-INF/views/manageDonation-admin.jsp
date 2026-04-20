<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/common/header.jsp" %>
<%@ include file="/WEB-INF/common/sidebar-admin.jsp" %>

<div class="container mt-4">
    <h3 class="mb-4">Manage Donations</h3>

    <!-- SUCCESS ALERT -->
    <div id="cancelAlert" class="alert alert-success alert-dismissible fade d-none">
        Donation canceled successfully.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>

    <!-- SEARCH + FILTER -->
    <div class="row mb-3">
        <div class="col-md-4">
            <input type="text" class="form-control" placeholder="Search..." id="searchBox">
        </div>
        <div class="col-md-3">
            <select class="form-select" id="statusFilter">
                <option value="">Filter by Status</option>
                <option value="CREATED">Available</option>
                <option value="ACCEPTED">Accepted</option>
                <option value="PICKED">Picked Up</option>
                <option value="COMPLETED">Completed</option>
                <option value="EXPIRED">Expired</option>
            </select>
        </div>
    </div>

    <!-- TABLE -->
    <div class="table-responsive">
        <table class="table table-hover table-bordered">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Food Name</th>
                    <th>Donor</th>
                    <th>NGO</th>
                    <th>Quantity</th>
                    <th>Expiry</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>

			<tbody id="donationTable">
			    <c:forEach items="${donations}" var="d">
			        <tr>
			            <td>${d.donationId}</td>
			            <td class="food">${d.foodName}</td>
			            <td class="donor">${d.donor.name}</td>
			            <td class="ngo">${d.ngo != null ? d.ngo.organizationName : '-'}</td>
			            <td>${d.quantity}</td>
			            <td>${d.expiryTime}</td>

			            <!-- ✅ FIX: ADDED data-status -->
			            <td class="status-cell" data-status="${d.status}">
			                <span class="badge 
			                    ${d.status == 'CREATED' ? 'bg-primary' : 
			                      (d.status == 'ACCEPTED' ? 'bg-success' : 
			                      (d.status == 'PICKED' ? 'bg-warning' :
			                      (d.status == 'COMPLETED' ? 'bg-dark' : 'bg-danger')))}">
			                    ${d.status}
			                </span>
			            </td>

			            <td>
			                <button class="btn btn-sm btn-outline-info"
			                    data-bs-toggle="modal"
			                    data-bs-target="#viewModal"
			                    onclick="setDonationData(
			                        '${d.donationId}',
			                        '${d.foodName}',
			                        '${d.donor.name}',
			                        '${d.ngo != null ? d.ngo.organizationName : "-"}',
			                        '${d.quantity}',
			                        '${d.pickupAddress}',
			                        '${d.preparedDate}',
			                        '${d.expiryTime}',
			                        '${d.status}'
			                    )">
			                    View
			                </button>

			                <a href="admin/editDonation?id=${d.donationId}" 
			                   class="btn btn-sm btn-outline-warning">
			                   Edit
			                </a>

			                <button class="btn btn-sm btn-outline-danger"
			                    data-bs-toggle="modal"
			                    data-bs-target="#cancelModal"
			                    onclick="setCancelId('${d.donationId}')">
			                    Cancel
			                </button>
			            </td>
			        </tr>
			    </c:forEach>
			</tbody>        </table>
    </div>
</div>

<!-- ================= VIEW MODAL ================= -->
<div class="modal fade" id="viewModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Donation Details</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <p><strong>ID:</strong> <span id="v_id"></span></p>
                <p><strong>Food:</strong> <span id="v_food"></span></p>
                <p><strong>Donor:</strong> <span id="v_donor"></span></p>
                <p><strong>NGO:</strong> <span id="v_ngo"></span></p>
                <p><strong>Quantity:</strong> <span id="v_qty"></span></p>
                <p><strong>Location:</strong> <span id="v_loc"></span></p>
                <p><strong>Prepared:</strong> <span id="v_date"></span></p>
                <p><strong>Expiry:</strong> <span id="v_exp"></span></p>
                <p><strong>Status:</strong> <span id="v_status"></span></p>
            </div>

        </div>
    </div>
</div>

<!-- ================= CANCEL MODAL ================= -->
<div class="modal fade" id="cancelModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Cancel Donation</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                Are you sure you want to cancel this donation?
            </div>

            <div class="modal-footer">
                <button class="btn btn-danger" id="confirmCancel">Yes, Cancel</button>
                <button class="btn btn-secondary" data-bs-dismiss="modal">No</button>
            </div>

        </div>
    </div>
</div>

<%@ include file="/WEB-INF/common/footer.jsp" %>

<!-- ================= JAVASCRIPT ================= -->

<script>
	// ===============================
	// ADMIN - MANAGE DONATIONS FILTER
	// ===============================
	document.addEventListener("DOMContentLoaded", function () {

	    const table = document.getElementById("donationTable");
	    const searchBox = document.getElementById("searchBox");
	    const statusFilter = document.getElementById("statusFilter");

	    // ✅ STOP SCRIPT if elements missing
	    if (!table || !searchBox || !statusFilter) return;

	    const rows = table.querySelectorAll("tbody tr");

	    function filterAdminDonations() {
	        const search = searchBox.value.toLowerCase().trim();
	        const status = statusFilter.value;

	        rows.forEach(row => {
	            // Skip header / no-data rows
	            if (!row.querySelector(".food")) return;

	            const food = row.querySelector(".food")?.innerText.toLowerCase() || "";
	            const donor = row.querySelector(".donor")?.innerText.toLowerCase() || "";
	            const ngo = row.querySelector(".ngo")?.innerText.toLowerCase() || "";

	            const statusCell = row.querySelector(".status-cell");
	            const rowStatus = statusCell ? statusCell.getAttribute("data-status") : "";

	            const matchSearch = food.includes(search) || donor.includes(search) || ngo.includes(search);
	            const matchStatus = !status || rowStatus === status;

	            row.style.display = (matchSearch && matchStatus) ? "" : "none";
	        });
	    }

	    // Bind events
	    searchBox.addEventListener("keyup", filterAdminDonations);
	    statusFilter.addEventListener("change", filterAdminDonations);

	    // Initial filter
	    filterAdminDonations();
	});
</script>


