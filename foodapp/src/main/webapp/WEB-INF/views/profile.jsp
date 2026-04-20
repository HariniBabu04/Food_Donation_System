<%@ include file="/WEB-INF/common/header.jsp" %>

	<div class="container-fluid">
		<div class="row min-vh-100">

			<!-- SIDEBAR -->


			<!-- MAIN CONTENT -->
			<div class="row justify-content-center">

				<div class="container py-4 flex-grow-1">

					<!-- Back Button -->
					<div class="mb-3">
						<button type="button" class="btn btn-outline-secondary" onclick="history.back();">
							&larr; Back
						</button>
					</div>

					<h1 class="text-center mb-4 text-success">My Profile</h1>

					<div class="d-flex justify-content-center">
						<form id="profileForm" class="w-100 w-md-75 w-lg-50 bg-white p-4 shadow rounded"
							action="updateProfile" method="post">

							<div class="text-center mb-3">
								<h5>${donor.name}</h5>
								<small class="text-muted">${donor.role}</small>
							</div>

							<div class="mb-3">
								<label>Full Name</label>
								<input type="text" class="form-control editable" name="name" value="${donor.name}"
									readonly>
							</div>

							<div class="mb-3">
								<label>Email</label>
								<input type="email" class="form-control editable" name="email" value="${donor.email}"
									readonly>
							</div>

							<div class="mb-3">
								<label>Phone</label>
								<input type="text" class="form-control editable" name="phone" value="${donor.phone}"
									readonly>
							</div>

							

							<div class="mb-3">
								<label>Address</label>
								<input type="text" class="form-control editable" name="address" value="${donor.address}"
									readonly>
							</div>

							<div class="mb-3">
								<label>Created At</label>
								<input type="text" class="form-control" value="${donor.createdAt}" readonly>
							</div>

							<div class="mb-3">
								<label>Status</label>
								<input type="text" class="form-control text-success fw-semibold" value="${donor.status}"
									readonly>
							</div>

							<div class="d-flex justify-content-center gap-3 mt-4">
								<button type="button" id="editBtn" class="btn btn-outline-success w-25">Edit</button>
								<button type="submit" id="saveBtn" class="btn btn-success w-25 d-none">Save</button>
								<button type="button" id="cancelBtn"
									class="btn btn-secondary w-25 d-none">Cancel</button>
							</div>

						</form>
					</div>

				</div>

			</div>

		</div>
	</div>

	<%@ include file="/WEB-INF/common/footer.jsp" %>