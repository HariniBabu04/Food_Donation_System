<%@ include file="/WEB-INF/common/header.jsp" %>

<div class="container-fluid">
	<div class="row min-vh-100">

		<div class="col-md-3 col-lg-2 p-0">
					           <%@ include file="/WEB-INF/common/sidebar-donor.jsp" %>
					       </div>
	<!-- Main Content -->
	<div class="col-md-10 pt-4 pb-5">

		<h1 class="text-center mb-4">Add Surplus Food</h1>

		<div class="d-flex justify-content-center">
			<form class="w-75 bg-white p-4 shadow rounded" action="/addSurplusfood" method="post">

				<h5 class="mb-3">Food Details</h5>

				<div class="mb-3">
					<label class="form-label">Food Name</label>
					<input type="text" class="form-control" name="foodName">
				</div>

				<div class="mb-3">
					<label class="form-label">Select Category</label>
					<select class="form-select" name="foodType">
						<option value="">Category...</option>
						<option value="Veg">Veg</option>
						<option value="Non Veg">Non Veg</option>
					</select>
				</div>

				<div class="mb-3">
					<label class="form-label">Quantity</label>
					<input type="number" class="form-control" name="quantity">
				</div>

				<h5 class="mt-4 mb-3">Time Details</h5>



				<div class="row">

				    <div class="col-md-3 mb-3">
				        <label>Prepared Date</label>
				        <input type="date" class="form-control" name="preparedDate">
				    </div>

				    <div class="col-md-3 mb-3">
				        <label>Prepared Time</label>
				        <input type="time" class="form-control" name="preparedTime">
				    </div>

				    <div class="col-md-3 mb-3">
				        <label>Expiry Date</label>
				        <input type="date" class="form-control" name="expiryDate">
				    </div>

				    <div class="col-md-3 mb-3">
				        <label>Expiry Time</label>
				        <input type="time" class="form-control" name="expiryTime">
				    </div>

				
				</div>

				<h5 class="mt-4 mb-3">Location Details</h5>

				<div class="mb-3">
					<label class="form-label">Pickup Location</label>
					<input type="text" class="form-control" name="pickupAddress">
				</div>

				<h5 class="mt-4 mb-3">Contact Details</h5>

				<div class="row">
					<div class="col-md-6 mb-3">
						<label class="form-label">Contact Person</label>
						<input type="text" class="form-control" name="contactPerson">
					</div>

					<div class="col-md-6 mb-3">
						<label class="form-label">Contact Number</label>
						<input type="tel" class="form-control" name="contactNumber">
					</div>
				</div>

				<div class="text-center mt-4">
					<button type="submit" class="btn btn-success w-50">Add</button>
				</div>

			</form>
		</div>

	</div>

</div>


</div>

<%@ include file="/WEB-INF/common/footer.jsp" %>
