<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>Surplus Food Donation</h1>

<div class="container py-5">
	<div class="row justify-content-center">
		<div class="col-lg-10">
			<div class="card shadow-sm">
				<div class="card-body p-4">

					<div class="mb-4 text-center">
						<h3>User Registration</h3>
					</div>
					<c:if test="${not empty errorMessage}">
					    <div class="alert alert-danger text-center">
					        ${errorMessage}
					    </div>
					</c:if>

					<c:if test="${not empty successMessage}">
					    <div class="alert alert-success text-center">
					        ${successMessage}
					    </div>
					</c:if>

					<form action="/register" method="post">

						<div class="row mb-3 align-items-center justify-content-center">
							<label class="col-sm-2 col-form-label">Username:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="name" name="name" placeholder="Enter username">
							</div>
						</div>

						<div class="row mb-3 align-items-center justify-content-center">
							<label class="col-sm-2 col-form-label">Email:</label>
							<div class="col-sm-6">
								<input type="email" class="form-control" id="email" name="email" placeholder="Enter email">
							</div>
						</div>
						<div class="row mb-3 align-items-center justify-content-center">
						    <label class="col-sm-2 col-form-label">Phone number:</label>
						    <div class="col-sm-6">
						        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone number">
						        <small id="phoneError" style="color:red;"></small>
						    </div>
						</div>

						<div class="row mb-3 align-items-center justify-content-center">
							<label class="col-sm-2 col-form-label">Password:</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" id="password" name="password" placeholder="Enter password" 								
								pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$"
								required>
							</div>
						</div>
						<div class="row mb-3 align-items-center justify-content-center">
						    <label class="col-sm-2 col-form-label">Confirm Password:</label>
						    <div class="col-sm-6">
						        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm password">
						        <small id="passwordError" style="color:red;"></small>
						    </div>
						</div>

						<div class="row mb-3 align-items-center justify-content-center">
							<label class="col-sm-2 col-form-label">Select Role:</label>
							<div class="col-sm-6">
								<select class="form-select" id="role" name="role" onchange="selectRole()">
								    <option value="">Select role...</option>
								    <option value="donor">Donor (Organization / Industry / Hotel)</option>
								    <option value="ngo">NGO</option>
								    <option value="admin">Admin</option>
								</select>
							</div>
						</div>

						<!-- DONOR SECTION -->
						<div id="donor" style="display: none;">

							<h5 class="mt-4 text-center">Donor Details</h5>

							<div class="row mb-3 align-items-center justify-content-center">
								<label class="col-sm-2 col-form-label">Organization Name:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="donorName" name="organizationName" placeholder="Organization Name">
								</div>
							</div>

							<div class="row mb-3 align-items-center justify-content-center">
								<label class="col-sm-2 col-form-label">Address:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="donorAddress" name="address" placeholder="Organization Address">
								</div>
							</div>

							

						</div>

						<!-- NGO SECTION -->
						<div id="ngo" style="display: none;">

							<h5 class="mt-4 text-center">NGO Details</h5>

							<div class="row mb-3 align-items-center justify-content-center">
								<label class="col-sm-2 col-form-label">NGO Name:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="ngoName" name="organizationName" placeholder="NGO Name">
								</div>
							</div>

							<div class="row mb-3 align-items-center justify-content-center">
								<label class="col-sm-2 col-form-label">NGO Address:</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="ngoAddress" name="address" placeholder="NGO Address">
								</div>
							</div>

						</div>

						<div class="row mb-3 align-items-center justify-content-center">
							<label class="col-sm-2 col-form-label">OTP:</label>
							<div class="col-sm-6">
								<input type="text" class="form-control mb-2" id="otp" name="otp" placeholder="Enter OTP">
							</div>
						</div>

						<div class="row mb-3 align-items-center justify-content-center">
						    <div class="col-sm-4">
						        <div class="d-flex gap-2 mb-3">
						            <button type="button" id="sendOtpBtn" class="btn btn-outline-primary flex-fill">Send OTP</button>
						            <button type="button" id="verifyOtpBtn" class="btn btn-outline-success flex-fill">Verify OTP</button>
						        </div>
						    </div>
						</div>

						<div class="row mb-3 align-items-center justify-content-center">
						    <div class="col-sm-6">
						        <button type="submit" id="registerBtn" disabled class="btn btn-outline-success w-100">
						            Register
						        </button>
						    </div>
						</div>

						<div class="text-center mt-3">
							<p>Already have an account? <a href="login">Login</a></p>
						</div>

					</form>

				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>