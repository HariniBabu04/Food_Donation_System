<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ include file="/WEB-INF/common/header.jsp" %>

		<%@ include file="/WEB-INF/common/sidebar-admin.jsp" %>

			<div class="container mt-4">
				<h3 class="mb-4">Manage Users</h3>

				<div class="row mb-3">
					<div class="col-md-4">
						<input type="text" class="form-control" placeholder="Search by name, email, phone"
							id="searchBox">
					</div>
					<div class="col-md-3">
						<select class="form-select" id="filterRole">
							<option value="">Filter by Role</option>
							<option value="donor">Donor</option>
							<option value="ngo">NGO</option>

							<option value="admin">Admin</option>
						</select>
					</div>
					<div class="col-md-3">
						<select class="form-select" id="filterStatus">
							<option value="">Filter by Status</option>
							<option value="Active">Active</option>
							<option value="Inactive">Inactive</option>
							<option value="Blocked">Blocked</option>
						</select>
					</div>
				</div>

				<div class="table-responsive">
					<table class="table table-hover table-bordered">
						<thead class="table-light">
							<tr>
								<th>User ID</th>
								<th>User Name</th>
								<th>Role</th>
								<th>Email</th>
								<th>Phone</th>
								<th>Organization</th>
								<th>Status</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${users}" var="u">
								<tr>
									<td>${u.userId}</td>
									<td>${u.name}</td>
									<td><span class="text-capitalize">${u.role}</span></td>
									<td>${u.email}</td>
									<td>${u.phone}</td>
									<td>${u.role == 'ngo' ? u.organizationName : '-'}</td>
									<td>${u.status}</td>
									<td>
										<a href="${pageContext.request.contextPath}/viewUser?id=${u.userId}"
											class="btn btn-sm btn-outline-info">View</a>
											<a href="${pageContext.request.contextPath}/editUser?id=${u.userId}" 
											   class="btn btn-sm btn-outline-warning">Edit</a>

									</td>
								</tr>
							</c:forEach>

							<c:if test="${empty users}">
								<tr class="no-data-row">
									<td colspan="8" class="text-center text-danger">No users found.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>

			<%@ include file="/WEB-INF/common/footer.jsp" %>