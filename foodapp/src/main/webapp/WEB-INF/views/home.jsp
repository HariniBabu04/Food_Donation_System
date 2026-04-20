<%@ include file="../common/header.jsp" %>
	<%@ include file="../common/navbar.jsp" %>

		<!-- Hero Section -->
		<section class="hero">
			<h1 style="color:black; font-weight: bolder;"><i>Reduce Food Waste. Feed the Needy.</i></h1>
			<p class="mt-3" style="color: black; font-weight:900;">
				A web-based platform connecting organizations and NGOs to donate surplus food safely and efficiently.
			</p>
			<div class="mt-4">
				<a href="register" class="btn btn-light btn-lg me-2">Donate Food</a>
				<a href="register" class="btn btn-outline-light btn-lg">Join as NGO</a>
			</div>
		</section>

		<!-- About Section -->
		<section id="about" class="section-padding">
			<div class="container">
				<h2 class="text-center mb-4">About the System</h2>
				<p class="text-center">
					The Surplus Food Donation System is designed to reduce food wastage by enabling organizations,
					industries, hotels, and event managers to donate surplus food. NGOs and volunteers can view
					available food in real time, locate donors using Google Maps, and ensure secure pickup through
					OTP verification and automatic expiry management.
				</p>
			</div>
		</section>

		<!-- Awareness Section -->
		<section class="bg-light section-padding">
			<div class="container">

				<h2 class="text-center mb-4">Why This System?</h2>

				<div class="row text-center">

					<div class="col-md-3">
						<i class="bi bi-basket-fill fs-1 text-success"></i>
						<p>Large amounts of food are wasted daily</p>
					</div>

					<div class="col-md-3">
						<i class="bi bi-x-circle-fill fs-1 text-danger"></i>
						<p>Lack of coordination causes spoilage</p>
					</div>

					<div class="col-md-3">
						<i class="bi bi-people-fill fs-1 text-primary"></i>
						<p>Needy people lack access to food</p>
					</div>

					<div class="col-md-3">
						<i class="bi bi-globe fs-1 text-info"></i>
						<p>Technology can bridge this gap</p>
					</div>

				</div>
			</div>
		</section>

		<!-- How It Works -->
		<section id="how" class="section-padding">
			<div class="container">
				<h2 class="text-center mb-4">How It Works</h2>

				<div class="row text-center">

					<div class="col-md-3">
						<i class="fas fa-hand-holding-heart fa-3x text-success"></i>
						<p>Donor posts surplus food</p>
					</div>

					<div class="col-md-3">
						<i class="fas fa-bell fa-3x text-primary"></i>
						<p>NGOs receive notification</p>
					</div>

					<div class="col-md-3">
						<i class="fas fa-truck fa-3x text-warning"></i>
						<p>Pickup using OTP verification</p>
					</div>

					<div class="col-md-3">
						<i class="fas fa-check-circle fa-3x text-success"></i>
						<p>Food reaches the needy</p>
					</div>

				</div>
			</div>
		</section>

		<!-- Features Section -->
		<section class="bg-light section-padding">
			<div class="container">
				<h2 class="text-center mb-4">Key Features</h2>

				<div class="row g-4">

					<div class="col-md-4">
						<div class="feature-box text-center">
							<i class="fas fa-shield-alt fa-3x mb-3 text-primary"></i>
							<h5>OTP Verification</h5>
						</div>
					</div>

					<div class="col-md-4">
						<div class="feature-box text-center">
							<i class="fas fa-map-marker-alt fa-3x mb-3 text-danger"></i>
							<h5>Google Maps Location Tracking</h5>
						</div>
					</div>

					<div class="col-md-4">
						<div class="feature-box text-center">
							<i class="fas fa-clock fa-3x mb-3 text-warning"></i>
							<h5>Automatic Food Expiry Removal</h5>
						</div>
					</div>

					<div class="col-md-4">
						<div class="feature-box text-center">
							<i class="fas fa-chart-bar fa-3x mb-3 text-success"></i>
							<h5>Donation Analytics Dashboard</h5>
						</div>
					</div>

					<div class="col-md-4">
						<div class="feature-box text-center">
							<i class="fas fa-users fa-3x mb-3 text-info"></i>
							<h5>Role-Based Access Control</h5>
						</div>
					</div>

				</div>
			</div>
		</section>

		<!-- Impact Statistics -->
		<section class="section-padding">
			<div class="container">
				<h2 class="text-center mb-4">Our Impact</h2>
				<div class="row text-center">
					<div class="col-md-3"><strong>500+</strong><br>Food Donations</div>
					<div class="col-md-3"><strong>10,000+</strong><br>Meals Saved</div>
					<div class="col-md-3"><strong>25+</strong><br>Active NGOs</div>
					<div class="col-md-3"><strong>10+</strong><br>Cities Covered</div>
				</div>
			</div>
		</section>

		<!-- Call to Action -->
		<section class="hero">
			<h2 style="color: black; font-weight: bolder;">Be a Part of the Solution</h2>
			<p style="color: black; font-weight: 900;">Join us today and help reduce food wastage.</p>
			<a href="register" class="btn btn-light btn-lg">Get Started</a>
		</section>
<%@ include file="../common/footer.jsp" %>