<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<!-- Login Form -->
<div class="container login-container">
	<div class="row justify-content-center">
		<div class="col-md-5">
			<div class="card login-card shadow">
				<div class="card-body">
					<h3 class="text-center login-title">User Login</h3>

					<form action="/login" method="post">

						<!-- Email -->
						<div class="mb-3">
							<label class="form-label">Email Address</label>
							<input type="email" name="email" class="form-control" placeholder="Enter email here" required>
						</div>

						<!-- Password -->
						<div class="mb-3">
							<label class="form-label">Password</label>
							<input type="password" name="password" class="form-control" placeholder="Enter password here" required>
						</div>

						<!-- Role Selection -->
						<div class="mb-3">
							<label class="form-label">Login As</label>
							<select class="form-select" id="role" name="role" onchange="selectRole()">
							    <option value="">Select role...</option>
							    <option value="donor">Donor (Organization / Industry / Hotel)</option>
							    <option value="ngo">NGO</option>
							    <option value="admin">Admin</option>
							</select>
						</div>

						<!-- Submit -->
						<div class="d-grid">
							<button type="submit" class="btn btn-success">Login</button>
						</div>

					</form>

					<!-- Extra Links -->
					<div class="text-center mt-3">
						<p>New user? <a href="register">Register here</a></p>
						<p><a href="forgotPassword">Forgot Password?</a></p>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../common/footer.jsp" %>