<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

		<%@ include file="/WEB-INF/common/header.jsp" %>

			<div class="container-fluid">
				<div class="row">

					<%@ include file="/WEB-INF/common/sidebar-ngo.jsp" %>

						<!-- Content -->
						<div class="col-md-9 p-4">

							<h3>View Donations</h3>

							<div class="card shadow-sm mt-4">
								<div class="card-body">

									<table class="table table-bordered">
										<thead class="table-success">
											<tr>
												<th>Donation ID</th>
												<th>Food Name</th>
												<th>Category</th>
												<th>Quantity</th>
												<th>Location</th>
												<th>Expiry Time</th>
												<th>Donor Organization</th>
												<th>Status</th>
												<th>Action</th>
											</tr>
										</thead>

										<tbody>

											<c:forEach items="${donations}" var="donation">
												<tr>
													<td>${donation.donationId}</td>
													<td>${donation.foodName}</td>
													<td>${donation.foodType}</td>
													<td>${donation.quantity}</td>

													<td>
														${donation.pickupAddress}
														<a href="https://www.google.com/maps/search/?api=1&query=${donation.pickupAddress}"
															target="_blank">
															<i class="bi bi-geo-alt-fill text-success ms-2"></i>
														</a>
													</td>

													<td>${donation.expiryTime}</td>
													<td>${donation.donor.organizationName}</td>

													<!-- STATUS -->
													<td>
														<span class="badge bg-success">
															${donation.status}
														</span>
													</td>

													<!-- ACTION -->
													<td>
														<div class="d-flex gap-2">

															<!-- CREATED -->
															<c:if
																test="${fn:toUpperCase(fn:trim(donation.status)) eq 'CREATED'}">
																<a href="/acceptDonation/${donation.donationId}"
																	class="btn btn-sm btn-success">
																	Accept
																</a>
															</c:if>

															<!-- ACCEPTED by THIS NGO -->
															<c:if test="${fn:toUpperCase(fn:trim(donation.status)) eq 'ACCEPTED' 
                                                         && donation.ngo.userId == loggedUser.userId}">

																<button class="btn btn-sm btn-success" disabled>
																	Accepted
																</button>

																<a href="/pickup/${donation.donationId}"
																	class="btn btn-sm btn-primary">
																	Pickup
																</a>

															</c:if>

															<!-- ACCEPTED by OTHER NGO -->
															<c:if test="${fn:toUpperCase(fn:trim(donation.status)) eq 'ACCEPTED' 
                                                         && donation.ngo.userId != loggedUser.userId}">

																<button class="btn btn-sm btn-secondary" disabled>
																	Already Accepted
																</button>

															</c:if>

														</div>
													</td>
												</tr>
											</c:forEach>

											<!-- NO DATA -->
											<c:if test="${empty donations}">
												<tr>
													<td colspan="9" class="text-center text-danger">
														No donations available at the moment.
													</td>
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