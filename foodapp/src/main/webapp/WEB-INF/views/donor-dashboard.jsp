<%@ include file="/WEB-INF/common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	

		<div class="container-fluid">
			<div class="row">
             
				<div class="col-md-3 col-lg-2 p-0">
				           <%@ include file="/WEB-INF/common/sidebar-donor.jsp" %>
				       </div>

					<!-- Main Content -->
					<div class="col-md-10 p-4">

						<!-- Header -->
						<div class="d-flex justify-content-between align-items-center mb-4">
							<h3>Welcome, Donor ${name} </h3>
							<button type="submit" class="btn btn-primary" onclick="window.location.href='addSurplusfood'" >+ Add New Donation</button>
						</div>

						<!-- Summary Cards -->
						<div class="row mb-4">

						<div class="col-md-3">
						<div class="card dashboard-card total-card text-center shadow-sm">
						<div class="card-body">
						<i class="bi bi-box-seam card-icon text-success"></i>
						<h6 class="card-title">Total Donations</h6>
						<p class="card-number">${totalDonations}</p>
						</div>
						</div>
						</div>

						<div class="col-md-3">
						<div class="card dashboard-card pending-card text-center shadow-sm">
						<div class="card-body">
						<i class="bi bi-hourglass-split card-icon text-warning"></i>
						<h6 class="card-title">Pending</h6>
						<p class="card-number">${pendingDonations}</p>
						</div>
						</div>
						</div>

						<div class="col-md-3">
						<div class="card dashboard-card accepted-card text-center shadow-sm">
						<div class="card-body">
						<i class="bi bi-check-circle card-icon text-primary"></i>
						<h6 class="card-title">Accepted</h6>
						<p class="card-number">${acceptedDonations}</p>
						</div>
						</div>
						</div>

						<div class="col-md-3">
						<div class="card dashboard-card expired-card text-center shadow-sm">
						<div class="card-body">
						<i class="bi bi-x-circle card-icon text-danger"></i>
						<h6 class="card-title">Expired</h6>
						<p class="card-number">${expiredDonations}</p>
						</div>
						</div>
						</div>

						</div>
						<!-- Donation Table -->
						<div class="card shadow-sm">
							<div class="card-header bg-white">
								<h5 class="mb-0">My Donation History</h5>
							</div>
							<div class="card-body table-responsive">
								<table class="table table-bordered table-hover align-middle">
									<thead class="table-light">
										<tr>
											<th>S.No</th>
											<th>Food Name</th>
											<th>Food Type</th>
											<th>Quantity</th>
											<th>Location</th>
											<th>Status</th>

										</tr>
									</thead>
									<tbody>

									<c:forEach var="donation" items="${donations}" varStatus="count">

									<tr>
									<td>${count.index + 1}</td>
									<td>${donation.foodName}</td>
									<td>${donation.foodType}</td>
									<td>${donation.quantity}</td>
									<td>${donation.pickupAddress}</td>

									<td>

									<c:choose>

									<c:when test="${donation.status == 'CREATED'}">
									<span style="color:#ffc107; font-weight:bold;">Pending</span>
									</c:when>

									<c:when test="${donation.status == 'ACCEPTED'}">
									<span style="color:green; font-weight:bold;">Accepted</span>
									</c:when>

									<c:when test="${donation.status == 'CANCELLED'}">
									<span style="color:orange; font-weight:bold;">Cancelled</span>
									</c:when>

									<c:when test="${donation.status == 'EXPIRED'}">
									<span style="color:red; font-weight:bold;">Expired</span>
									</c:when>

									<c:otherwise>
									<span style="color:black;">${donation.status}</span>
									</c:otherwise>

									</c:choose>

									</td>
							

									</tr>

									</c:forEach>

									</tbody>
								</table>
							</div>
						</div>

					</div>
			</div>
		</div>

		<%@ include file="/WEB-INF/common/footer.jsp" %>