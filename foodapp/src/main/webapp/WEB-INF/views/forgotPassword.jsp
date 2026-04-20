<%@ include file="../common/header.jsp" %>
	<%@ include file="../common/navbar.jsp" %>

		<div class="container d-flex justify-content-center align-items-center min-vh-100">
			<div class="card shadow p-4 w-100" style="max-width: 600px;">
				<div class="card-body">
					<h1 class="card-title text-center mb-2">Surplus Food Donation</h1>
					<h3 class="card-subtitle text-center mb-4 text-muted">Forgot Password</h3>
					<form>
						<div class="mb-3 row align-items-center">
							<label for="inputEmail3" class="col-sm-4 col-form-label text-end text-nowrap">Email/Phone
								Number:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="inputEmail3"
									placeholder="Enter Email/Phone Number">
							</div>
						</div>
						<div class="mb-3 row align-items">
							<label for="otp" class="col-sm-4 col-form-label text-end">OTP:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control mb-2" id="otp" placeholder="Enter OTP">
								<div class="d-flex gap-2">
									<button type="submit" class="btn btn-primary flex-fill">Send OTP</button>
									<button type="submit" class="btn btn-primary flex-fill">Verify OTP</button>
								</div>
							</div>
						</div>
						<div class="mb-3 row align-items-center" class="d-flex gap-2">
							<label for="inputPassword3" class="col-sm-4 col-form-label text-end">New Password:</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="inputPassword3"
									placeholder="Enter new password">
							</div>
						</div>
						<div class="mb-3 row align-items-center">
							<label for="inputPassword3" class="col-sm-4 col-form-label text-end">Confirm
								Password:</label>
							<div class="col-sm-8">
								<input type="password" class="form-control" id="inputPassword3"
									placeholder="Re-enter password">
							</div>
						</div>
						<div class="d-grid">
							<button type="submit" class="btn btn-primary">Reset Password</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%@ include file="../common/footer.jsp" %>