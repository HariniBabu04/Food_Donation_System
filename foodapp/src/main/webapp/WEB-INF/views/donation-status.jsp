<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/common/header.jsp" %>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-lg-2 p-0">
			           <%@ include file="/WEB-INF/common/sidebar-donor.jsp" %>
			       </div>

				<!-- Main Content -->
				<div class="col-md-10 p-4">

					<!-- Page Header -->
					<div class="mb-4">
						<h3>Donation Status</h3>
						<p class="text-muted">
							Track the current status of your donated food items.
						</p>
					</div>

					<!-- Status Table -->
					<div class="card shadow-sm">
						<div class="card-header bg-white">
							<h5 class="mb-0">Donation Tracking</h5>
						</div>

						<div class="card-body table-responsive">
							<table class="table table-bordered table-hover align-middle">
								<thead class="table-light">
									<tr>
										<th>Donation ID</th>
										<th>Food Name</th>
										<th>NGO / Volunteer</th>
										<th>Status</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach items="${donations}" var="donation" varStatus="status">
										<tr>
											<td>${donation.donationId}</td>
											<td>${donation.foodName}</td>
											<td>
												<c:choose>
													<c:when test="${not empty donation.ngo}">
														${donation.ngo.organizationName}
													</c:when>
													<c:otherwise>
														<span class="text-muted">Not Yet Accepted</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<span class="badge ${donation.status == 'CREATED' ? 'bg-warning' : 'bg-success'}">
													${donation.status}
												</span>
											</td>
										</tr>
									</c:forEach>
									
									<c:if test="${empty donations}">
										<tr>
											<td colspan="4" class="text-center text-muted">You haven't made any donations yet.</td>
										</tr>
									</c:if>
								</tbody>
							</table>
						</div>
					</div>

				</div>
		</div>
	</div>


	<%@ include file="/WEB-INF/common/footer.jsp" %>