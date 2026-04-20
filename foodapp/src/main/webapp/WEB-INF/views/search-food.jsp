<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

		<%@ include file="/WEB-INF/common/header.jsp" %>

			<div class="container-fluid">
				<div class="row">

					<%@ include file="/WEB-INF/common/sidebar-ngo.jsp" %>

						<!-- Content -->

						<div class="col-md-10 p-4">

							<h3>Search Food by Location</h3>

							<div class="card mt-3">
								<div class="card-body">

									<form action="/search-food" method="get">

										<div class="row">

											<div class="col-md-4">
												<label>City</label>
												<input type="text" name="city" class="form-control"
													placeholder="Enter city" value="${param.city}">
											</div>

											<div class="col-md-4">
												<label>Food Type</label>
												<select name="foodType" class="form-select">

													<option value="">All</option>
													<option value="Veg">Veg</option>
													<option value="Non-Veg">Non-Veg</option>
													<optoin value="Fruits">Fruits</optoin>
													<option value="Snacks">Snacks</option>

												</select>
											</div>

										</div>

										<button type="submit" class="btn btn-primary mt-3">Search</button>

									</form>

								</div>
							</div>

							<table class="table table-bordered mt-4">

								<thead class="table-dark">

									<tr>
										<th>Donor</th>
										<th>Food</th>
										<th>Food Type</th>
										<th>Qty</th>
										<th>Location</th>
										<th>Expiry</th>
										<th>Action</th>
									</tr>

								</thead>

								<tbody>

									<c:forEach var="donation" items="${donations}">

										<tr>

											<td>${donation.donor.organizationName}</td>

											<td>${donation.foodName}</td>

											<td>${donation.foodType}</td>

											<td>${donation.quantity}</td>

											<td>${donation.pickupAddress}</td>

											<td>${donation.expiryTime}</td>

											<td>

												<a href="/acceptDonation/${donation.donationId}"
													class="btn btn-success btn-sm">
													Accept </a>

											</td>

										</tr>

									</c:forEach>

									<c:if test="${empty donations}">

										<tr>
											<td colspan="7" class="text-center text-muted">
												No food donations found
											</td>
										</tr>
									</c:if>

								</tbody>

							</table>

						</div>
				</div>
			</div>

			<%@ include file="/WEB-INF/common/footer.jsp" %>
			<script>
			document.addEventListener("DOMContentLoaded", function() {
			    const cityInput = document.querySelector('input[name="city"]');
			    const foodTypeSelect = document.querySelector('select[name="foodType"]');
			    const table = document.querySelector('table tbody');
			    const rows = Array.from(table.querySelectorAll('tr'));

			    function filterTable() {
			        const city = cityInput.value.toLowerCase().trim();
			        const foodType = foodTypeSelect.value.toLowerCase().trim();

			        rows.forEach(row => {
			            const rowCity = row.cells[4].textContent.toLowerCase().trim();     // Location column
			            const rowFoodType = row.cells[2].textContent.toLowerCase().trim(); // Food Type column

			            const cityMatch = !city || rowCity.includes(city);
			            const typeMatch = !foodType || rowFoodType === foodType;

			            if (cityMatch && typeMatch) {
			                row.style.display = "";
			            } else {
			                row.style.display = "none";
			            }
			        });
			    }

			    // Event listeners for real-time filtering
			    cityInput.addEventListener('input', filterTable);
			    foodTypeSelect.addEventListener('change', filterTable);
			});
			</script>