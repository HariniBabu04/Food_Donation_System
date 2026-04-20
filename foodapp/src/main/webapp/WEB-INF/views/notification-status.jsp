<%@ include file="/WEB-INF/common/header.jsp" %>

	<%@ include file="/WEB-INF/common/sidebar-admin.jsp" %>



		<div class="container mt-4">

			<!-- Page Header -->
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h3 class="page-title">Notification Logs</h3>
				<button class="btn btn-success">Refresh</button>
			</div>

			<!-- Notification Table -->
			<div class="card shadow-sm">
				<div class="card-body">

					<table class="table table-bordered table-hover align-middle">
						<thead class="table-success">
							<tr>
								<th>#</th>
								<th>User</th>
								<th>Message</th>
								<th>Type</th>
								<th>Sent Time</th>
								<th>Status</th>
							</tr>
						</thead>

						<tbody>

							<tr>
								<td>1</td>
								<td>ABC NGO</td>
								<td>New food donation available near you</td>
								<td>Email</td>
								<td>14 Feb 2026, 10:30 AM</td>
								<td><span class="badge bg-success status-badge">Delivered</span></td>
							</tr>

							<tr>
								<td>2</td>
								<td>XYZ Organization</td>
								<td>Pickup confirmed successfully</td>
								<td>SMS</td>
								<td>14 Feb 2026, 09:50 AM</td>
								<td><span class="badge bg-warning text-dark status-badge">Pending</span></td>
							</tr>

							<tr>
								<td>3</td>
								<td>Helping Hands NGO</td>
								<td>Food expired and removed</td>
								<td>Email</td>
								<td>13 Feb 2026, 08:15 PM</td>
								<td><span class="badge bg-danger status-badge">Failed</span></td>
							</tr>

						</tbody>
					</table>

				</div>
			</div>

		</div>

		<%@ include file="/WEB-INF/common/footer.jsp" %>