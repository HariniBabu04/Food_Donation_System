<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<title>Access Denied</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Bootstrap 5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

	<style>
		body {
			background: #f4f6f9;
			height: 100vh;
			display: flex;
			justify-content: center;
			align-items: center;
			font-family: Arial, sans-serif;
		}

		.error-box {
			text-align: center;
			background: #fff;
			padding: 40px;
			border-radius: 12px;
			box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
		}

		.error-code {
			font-size: 90px;
			font-weight: bold;
			color: #dc3545;
		}

		.error-text {
			font-size: 24px;
			font-weight: 600;
			margin-bottom: 10px;
		}

		.error-desc {
			color: #666;
			margin-bottom: 25px;
		}
	</style>
</head>

<body>

	<div class="error-box">
		<div class="error-code">403</div>
		<div class="error-text">Access Denied</div>
		<p class="error-desc">
			Sorry, you do not have permission to access this page.
		</p>

		<a href="login" class="btn btn-danger me-2">Login Again</a>
		<a href="home" class="btn btn-secondary">Go Home</a>
	</div>

</body>

</html>