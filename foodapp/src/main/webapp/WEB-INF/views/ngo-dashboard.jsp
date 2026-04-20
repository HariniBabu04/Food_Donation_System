<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/common/header.jsp" %>

	<div class="container-fluid">
		<div class="row">

			<%@ include file="/WEB-INF/common/sidebar-ngo.jsp" %>

			<!-- Content -->
			<div class="col-md-10 p-4">
				<h3>Welcome, ${loggedUser.name}</h3>

				<div class="row mt-4">

					<div class="col-md-3">
						<div class="card text-bg-primary">
							<div class="card-body">
								<h5>Total Donations</h5>
								<h3>${totalDonations}</h3>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card text-bg-success">
							<div class="card-body">
								<h5>Accepted</h5>
								<h3>${acceptedDonations}</h3>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card text-bg-warning">
							<div class="card-body">
								<h5>Pending</h5>
								<h3>${pendingDonations}</h3>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card text-bg-danger">
							<div class="card-body">
								<h5>Expired</h5>
								<h3>0</h3>
							</div>
						</div>
					</div>

				</div>

				<h5 class="mt-5">Your Recent Activity</h5>
				<table class="table table-bordered mt-3">
					<thead class="table-dark">
						<tr>
							<th>Donor</th>
							<th>Food</th>
							<th>Location</th>
							<th>Status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${recentDonations}" var="donation">
							<tr>
								<td>${donation.donor.name}</td>
								<td>${donation.foodName}</td>
								<td>${donation.pickupAddress}</td>
								<td><span class="badge ${donation.status == 'ACCEPTED' ? 'bg-success' : 'bg-warning'}">${donation.status}</span></td>
							</tr>
						</c:forEach>
						<c:if test="${empty recentDonations}">
							<tr>
								<td colspan="4" class="text-center">No recent activity.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

			</div>
		</div>
	</div>

	
	<%@ include file="/WEB-INF/common/footer.jsp" %>