<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ include file="/WEB-INF/common/header.jsp" %>

		<div class="container-fluid">
			<div class="row min-vh-100">


				<div class="col-md-3 col-lg-2 p-0">
					<%@ include file="/WEB-INF/common/sidebar-donor.jsp" %>
				</div>


				<!-- Main Content -->
				<div class="col-md-10 p-4">

					<h4 class="mb-4">Manage Donations</h4>

					<!-- Filters -->
					<div class="row mb-3">
						<div class="col-md-3">
							<select class="form-select" id="filterStatus">
								<option value="">All Status</option>
								<option value="CREATED">Created</option>
								<option value="ACCEPTED">Accepted</option>
								<option value="PICKED_UP">Picked Up</option>
								<option value="COMPLETED">Completed</option>
								<option value="EXPIRED">Expired</option>
								<option value="CANCELLED">Cancelled</option>
							</select>
						</div>

						<div class="col-md-3">
							<select class="form-select" id="filterDate">
								<option value="">All Dates</option>
								<option value="today">Today</option>
								<option value="thisWeek">This Week</option>
							</select>
						</div>

						<div class="col-md-3">
							<select class="form-select" id="filterType">
								<option value="">All Food</option>
								<option value="veg">Veg Food</option>
								<option value="nonveg">Non Veg Food</option>
								<option value="snack">Snacks</option>
								<option value="Fruits">Fruits</option>
							</select>
						</div>

						<div class="col-md-3">
							<input type="text" class="form-control" placeholder="Search by food or location"
								id="searchBox">
						</div>
					</div>

					<!-- Table -->
					<div class="card shadow-sm">
						<div class="card-body">

							<div class="table-responsive">
								<table id="donationTable" class="table table-bordered table-hover">

									<thead class="table-success">
										<tr>
											<th>Donation ID</th>
											<th>Food Name</th>
											<th>Category</th>
											<th>Quantity</th>
											<th>Location</th>
											<th>Expiry Date</th>
											<th>Expiry Time</th>
											<th>Status</th>
											<th>Actions</th>
										</tr>
									</thead>
									<tbody>

										<c:choose>

											<c:when test="${not empty donations}">

												<c:forEach items="${donations}" var="donation">

													<tr data-prepared-date="${donation.preparedDate}">

														<td>${donation.donationId}</td>
														<td>${donation.foodName}</td>
														<td>${donation.foodType}</td>
														<td>${donation.quantity}</td>
														<td>${donation.pickupAddress}</td>
														<td>${donation.expiryDate}</td>
														<td>${donation.expiryTime}</td>

														<td>

															<c:choose>

																<c:when test="${donation.status == 'CREATED'}">
																	<span class="badge bg-warning">Created</span>
																</c:when>

																<c:when test="${donation.status == 'ACCEPTED'}">
																	<span class="badge bg-success">Accepted</span>
																</c:when>

																<c:when test="${donation.status == 'EXPIRED'}">
																	<span class="badge bg-dark">Expired</span>
																</c:when>

																<c:otherwise>
																	<span
																		class="badge bg-secondary">${donation.status}</span>
																</c:otherwise>

															</c:choose>

														</td>

														<td>
															<div class="d-flex gap-2">

																<c:choose>

																	<c:when test="${donation.status == 'CREATED'}">

																		<a href="/editDonation/${donation.donationId}"
																			class="btn btn-sm btn-outline-warning">
																			Edit
																		</a>

																		<a href="/cancelDonation/${donation.donationId}"
																			class="btn btn-sm btn-outline-danger"
																			onclick="return confirm('Cancel this donation?');">
																			Cancel
																		</a>

																	</c:when>

																	<c:otherwise>

																		<button class="btn btn-sm btn-secondary"
																			disabled>
																			Edit
																		</button>

																		<button class="btn btn-sm btn-secondary"
																			disabled>
																			Cancel
																		</button>

																	</c:otherwise>

																</c:choose>

															</div>
														</td>
													</tr>

												</c:forEach>

											</c:when>

											<c:otherwise>

												<tr class="no-data-row">
													<td colspan="8" class="text-center text-muted">
														No donations found.
													</td>
												</tr>

											</c:otherwise>

										</c:choose>

									</tbody>
								</table>
							</div>

						</div>
					</div>

				</div>

			</div>
		</div>

		<%@ include file="/WEB-INF/common/footer.jsp" %>