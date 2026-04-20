<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/common/header.jsp" %>
<%@ include file="/WEB-INF/common/sidebar-admin.jsp" %>

<!-- MAIN CONTENT -->
<div class="col-md-10 p-4 bg-light">

    <h3 class="mb-4">Admin Dashboard</h3>

    <!-- SUMMARY CARDS -->
    <div class="row g-4">

        <!-- Total Users -->
        <div class="col-md-3">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5>Total Users</h5>
                    <h2 class="text-primary">${totalUsers}</h2>
                </div>
            </div>
        </div>

        <!-- Total Donations -->
        <div class="col-md-3">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5>Total Donations</h5>
                    <h2 class="text-success">${totalDonations}</h2>
                </div>
            </div>
        </div>

        <!-- Active NGOs -->
        <div class="col-md-3">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5>Active NGOs</h5>
                    <h2 class="text-warning">${activeNGOs}</h2>
                </div>
            </div>
        </div>

        <!-- Pending Requests -->
        <div class="col-md-3">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h5>Pending Requests</h5>
                    <h2 class="text-danger">${pendingRequests}</h2>
                </div>
            </div>
        </div>

    </div>

    <!-- RECENT DONATIONS TABLE -->
    <div class="card mt-5 shadow-sm">
        <div class="card-header bg-success text-white">
            Recent Donations
        </div>

        <div class="card-body table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Donor</th>
                        <th>Food</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Expiry Time</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${recentDonations}" var="donation">
                        <tr>
                            <td>${donation.donationId}</td>
                            <td>${donation.donor.name}</td>
                            <td>${donation.foodName}</td>
                            <td>${donation.quantity}</td>

                            <!-- Status Badge -->
                            <td>
                                <span class="badge 
                                    ${donation.status == 'CREATED' ? 'bg-warning' : 
                                      donation.status == 'COMPLETED' ? 'bg-success' : 
                                      donation.status == 'EXPIRED' ? 'bg-danger' : 'bg-secondary'}">
                                    ${donation.status}
                                </span>
                            </td>

                            <td>${donation.expiryTime}</td>
                        </tr>
                    </c:forEach>

                    <!-- Empty Case -->
                    <c:if test="${empty recentDonations}">
                        <tr>
                            <td colspan="6" class="text-center text-muted">
                                No donations found.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- RECENT ACTIVITY (DYNAMIC) -->
    <div class="card mt-4 shadow-sm">
        <div class="card-header bg-dark text-white">
            Recent Activity
        </div>

        <div class="card-body">
            <ul>
                <c:forEach items="${activities}" var="act">
                    <li>${act.message}</li>
                </c:forEach>

                <c:if test="${empty activities}">
                    <li class="text-muted">No recent activity.</li>
                </c:if>
            </ul>
        </div>
    </div>

</div>
</div>
</div>

<%@ include file="/WEB-INF/common/footer.jsp" %>