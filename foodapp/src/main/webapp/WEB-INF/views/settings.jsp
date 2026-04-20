<%@ include file="/WEB-INF/common/header.jsp" %>

	<div class="container-fluid">
		<div class="row min-vh-100">


			<%@ include file="/WEB-INF/common/sidebar-donor.jsp" %>


				<!-- Main Content -->
				<div class="col-md-10 p-4">

					<h1 class="text-center mb-4">Settings</h1>

					<div class="d-flex justify-content-center">
						<form id="settingsForm" class="w-75 bg-white p-4 shadow rounded">

						  <h5 class="mb-3">Account Settings</h5>

						  <div class="mb-3">
						    <label class="form-label">Password</label>
						    <div class="input-group">
						      <input type="password" id="passwordField" class="form-control editable" value="password123" disabled>
						      <button class="btn btn-outline-secondary" type="button" id="togglePassword">
						        <i class="bi bi-eye"></i>
						      </button>
						    </div>
						  </div>

						  <div class="mb-3">
						    <label class="form-label">Email</label>
						    <input type="email" class="form-control editable" value="john@example.com" disabled>
						  </div>

						  <div class="mb-3">
						    <label class="form-label">Phone</label>
						    <input type="text" class="form-control editable" value="9876543210" disabled>
						  </div>

						  <div class="form-check mb-3">
						    <input class="form-check-input editable" type="checkbox" id="otpCheck" disabled checked>
						    <label class="form-check-label" for="otpCheck">Enable OTP Verification</label>
						  </div>

						  <h5 class="mb-3 mt-4">Notification Settings</h5>

						  <div class="form-check">
						    <input class="form-check-input editable" type="checkbox" disabled checked>
						    <label class="form-check-label">Email Notifications</label>
						  </div>

						  <div class="form-check">
						    <input class="form-check-input editable" type="checkbox" disabled>
						    <label class="form-check-label">SMS Notifications</label>
						  </div>

						  <div class="form-check mb-3">
						    <input class="form-check-input editable" type="checkbox" disabled checked>
						    <label class="form-check-label">Donation Alerts</label>
						  </div>

						  <h5 class="mb-3 mt-4">Privacy Settings</h5>

						  <div class="form-check">
						    <input class="form-check-input editable" type="checkbox" disabled>
						    <label class="form-check-label">Show Contact Details to NGOs</label>
						  </div>

						  <div class="form-check mb-3">
						    <input class="form-check-input editable" type="checkbox" disabled>
						    <label class="form-check-label">Allow Location Sharing</label>
						  </div>
						  <h5 class="mb-3 mt-4">System Preferences</h5>

						  <div class="mb-3">
						    <label class="form-label">Language</label>
						    <input type="text" class="form-control" value="English" readonly>
						  </div>

						  <div class="mb-3">
						    <label class="form-label">Time Format</label>
						    <select class="form-select editable" disabled>
						      <option selected>12-Hour</option>
						      <option>24-Hour</option>
						    </select>
						  </div>

						  <div class="d-flex justify-content-center gap-3 mt-4">
						    <button type="button" id="editBtn" class="btn btn-outline-success w-25">Edit Settings</button>
						    <button type="submit" id="saveBtn" class="btn btn-success w-25 d-none">Save</button>
						    <button type="button" id="cancelBtn" class="btn btn-secondary w-25 d-none">Cancel</button>
						  </div>

						</form>
					</div>

				</div>

		</div>
	</div>

	<%@ include file="/WEB-INF/common/footer.jsp" %>