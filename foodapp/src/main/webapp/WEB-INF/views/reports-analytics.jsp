<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<%@ include file="/WEB-INF/common/header.jsp" %>
		<%@ include file="/WEB-INF/common/sidebar-admin.jsp" %>

			<div class="container mt-4">

				<!-- PAGE TITLE -->
				<h3 class="mb-4">Reports & Analytics</h3>

				<!-- SUMMARY CARDS -->
				<div class="row g-4">

					<div class="col-md-3">
						<div class="card shadow-sm border-0">
							<div class="card-body text-center">
								<h5>Total Donations</h5>
								<h2 class="text-success">${totalDonations}</h2>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card shadow-sm border-0">
							<div class="card-body text-center">
								<h5>Total Donors</h5>
								<h2 class="text-primary">${totalDonors}</h2>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card shadow-sm border-0">
							<div class="card-body text-center">
								<h5>Total NGOs</h5>
								<h2 class="text-warning">${totalNGOs}</h2>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card shadow-sm border-0">
							<div class="card-body text-center">
								<h5>Food Saved (kg)</h5>
								<h2 class="text-danger">${foodSaved}</h2>
							</div>
						</div>
					</div>

				</div>

				<!-- CHARTS -->
				<div class="row mt-5">

					<!-- Donations Chart -->
					<div class="col-md-6">
						<div class="card shadow-sm">
							<div class="card-header bg-success text-white">
								Monthly Donations
							</div>
							<div class="card-body">
								<canvas id="donationChart"></canvas>
							</div>
						</div>
					</div>

					<!-- Status Chart -->
					<div class="col-md-6">
						<div class="card shadow-sm">
							<div class="card-header bg-primary text-white">
								Donation Status
							</div>
							<div class="card-body">
								<canvas id="statusChart"></canvas>
							</div>
						</div>
					</div>

				</div>

				<!-- TABLE REPORT -->
				<div class="card mt-5 shadow-sm">
					<div class="card-header bg-dark text-white">
						Recent Donations
					</div>

					<div class="card-body table-responsive">
						<table class="table table-bordered table-striped">
							<thead class="table-success">
								<tr>
									<th>ID</th>
									<th>Donor</th>
									<th>Food Type</th>
									<th>Quantity</th>
									<th>Status</th>
									<th>Date</th>
								</tr>
							</thead>

							<tbody>

								<c:forEach items="${recentDonations}" var="donation">
									<tr>
										<td>${donation.donationId}</td>
										<td>${donation.donor.name}</td>
										<td>${donation.foodName}</td>
										<td>${donation.quantity}</td>

										<td>
											<span class="badge 
                                    ${donation.status == 'CREATED' ? 'bg-warning' : 
                                      donation.status == 'COMPLETED' ? 'bg-success' : 
                                      donation.status == 'EXPIRED' ? 'bg-danger' : 'bg-secondary'}">
												${donation.status}
											</span>
										</td>

										<td>${donation.preparedDate} ${donation.preparedTime}</td>
									</tr>
								</c:forEach>

								<c:if test="${empty recentDonations}">
									<tr>
										<td colspan="6" class="text-center text-muted">
											No data available
										</td>
									</tr>
								</c:if>

							</tbody>
						</table>
					</div>
				</div>

			</div>
			<script>
			    window.months = [<c:forEach items="${months}" var="m">${m},</c:forEach>];
			    window.counts = [<c:forEach items="${counts}" var="c">${c},</c:forEach>];

			    window.statusLabels = [<c:forEach items="${statusLabels}" var="s">'${s}',</c:forEach>];
			    window.statusCounts = [<c:forEach items="${statusCounts}" var="c">${c},</c:forEach>];
			</script>

			<%@ include file="/WEB-INF/common/footer.jsp" %>