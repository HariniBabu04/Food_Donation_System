/* =========================
   GLOBAL GOOGLE MAP CALLBACK
========================= */
function initMap() {
    const mapDiv = document.getElementById("map");
    if (!mapDiv) return;

    const map = new google.maps.Map(mapDiv, {
        zoom: 10,
        center: { lat: 13.0827, lng: 80.2707 }
    });

    new google.maps.Marker({
        position: { lat: 13.0827, lng: 80.2707 },
        map: map
    });
}

console.log("script loaded");

/* =========================
   ROLE SELECTION
========================= */
function selectRole() {
    const roleElem = document.getElementById("role");
    if (!roleElem) return;

    const role = roleElem.value;
    const donorInfo = document.getElementById("donor");
    const ngoInfo = document.getElementById("ngo");
    // Admin doesn't have extra registration fields in this UI, but we clear others

    if (donorInfo) donorInfo.style.display = "none";
    if (ngoInfo) ngoInfo.style.display = "none";

    if (role === "donor" && donorInfo) {
        donorInfo.style.display = "block";
    }
    else if (role === "ngo" && ngoInfo) {
        ngoInfo.style.display = "block";
    }
}

document.addEventListener("DOMContentLoaded", selectRole);


// ================================
// NGO VIEW DONATIONS PAGE SCRIPT
// ================================
document.addEventListener("DOMContentLoaded", function() {

    const filterType = document.getElementById("filterType");
    const filterQuantity = document.getElementById("filterQuantity");
    const expiryTime = document.getElementById("expiryTime");
    const searchBox = document.getElementById("searchBox");
    const donationTable = document.getElementById("donationTable");

    if (!donationTable) return; // stop script if table not present

    const rows = donationTable.querySelectorAll("tbody tr");
    const noData = document.querySelector(".no-data-row");

    function getQuantitySize(text) {
        let value = parseFloat(text);
        if (value < 5) return "small";
        if (value <= 10) return "medium";
        return "large";
    }

    function isExpiryMatch(time, filter) {
        if (!filter) return true;

        let now = new Date();
        let [h, m] = time.split(":");

        let expiry = new Date();
        expiry.setHours(h, m, 0, 0);

        let diff = (expiry - now) / (1000 * 60);

        if (filter === "soon") return diff <= 120;
        if (filter === "later") return diff > 120;

        return true;
    }

    function filterTable() {

        let visible = false;

        rows.forEach(row => {

            if (row.classList.contains("no-data-row")) return;

            let food = row.cells[1].innerText.toLowerCase();
            let category = row.cells[2].innerText.toLowerCase().trim();
            let quantity = row.cells[3].innerText;
            let location = row.cells[4].innerText.toLowerCase();
            let expiry = row.cells[5].innerText;

            let typeMatch = !filterType.value || category === filterType.value.toLowerCase();
            let quantityMatch = !filterQuantity.value || getQuantitySize(quantity) === filterQuantity.value;
            let expiryMatch = isExpiryMatch(expiry, expiryTime.value);
            let searchMatch = !searchBox.value || food.includes(searchBox.value.toLowerCase()) || location.includes(searchBox.value.toLowerCase());

            if (typeMatch && quantityMatch && expiryMatch && searchMatch) {
                row.style.display = "";
                visible = true;
            } else {
                row.style.display = "none";
            }

        });

        if (noData) {
            noData.style.display = visible ? "none" : "";
        }
    }

    if (filterType) filterType.onchange = filterTable;
    if (filterQuantity) filterQuantity.onchange = filterTable;
    if (expiryTime) expiryTime.onchange = filterTable;
    if (searchBox) searchBox.onkeyup = filterTable;



    // ============================
    // VIEW BUTTON CLICK HANDLER
    // ============================
    document.addEventListener("click", function(e) {

        if (!e.target.classList.contains("View-btn")) return;

        let row = e.target.closest("tr");

        let status = row.cells[7].innerText.trim().toLowerCase();

        if (status === "picked up") {
            alert("This food has already been picked up");
            return;
        }

        if (status === "completed") {
            alert("This order is already completed");
            return;
        }

        if (status === "cancelled") {
            alert("This donation has been cancelled");
            return;
        }

        const donorContacts = {
            "1": "9876543210",
            "2": "9123456780",
            "3": "9988776655",
            "4": "9012345678",
            "5": "9090909090"
        };

        let id = row.cells[0].innerText;

        let data = {
            id: id,
            food: row.cells[1].innerText,
            category: row.cells[2].innerText,
            quantity: row.cells[3].innerText,
            location: row.cells[4].innerText,
            expiry: row.cells[5].innerText,
            donor: row.cells[6].innerText,
            status: status,
            phone: donorContacts[id] || ""
        };

        localStorage.setItem("selectedDonation", JSON.stringify(data));

        window.location.href = "acceptDonation";

    });

});


/* =========================
   GLOBAL BUTTON HANDLER
========================= */
document.addEventListener("click", function(e) {

    /* VIEW BUTTON */
    if (e.target.classList.contains("View-btn")) {

        const row = e.target.closest("tr");
        if (!row) return;

        const status = row.cells[7].innerText.trim();

        if (status === "Picked Up") {
            alert("Food already picked up");
            return;
        }

        const data = {
            id: row.cells[0].innerText,
            food: row.cells[1].innerText,
            category: row.cells[2].innerText,
            quantity: row.cells[3].innerText,
            location: row.cells[4].innerText,
            expiry: row.cells[5].innerText,
            donor: row.cells[6].innerText,
            status: status
        };

        localStorage.setItem("selectedDonation", JSON.stringify(data));
        window.location.href = "acceptDonation";
    }

    /* BLOCK BUTTON */
    if (e.target.classList.contains("block-btn")) {

        const row = e.target.closest("tr");
        const userName = row.cells[1].innerText;
        const statusCell = row.cells[7];

        if (confirm("Block " + userName + "?")) {

            statusCell.innerText = "Blocked";
            statusCell.classList.add("text-danger");

            e.target.disabled = true;
            e.target.innerText = "Blocked";
        }
    }

});


/* =========================
   ACCEPT DONATION PAGE
========================= */
document.addEventListener("DOMContentLoaded", () => {

    const storedData = localStorage.getItem("selectedDonation");

    if (storedData) {

        const data = JSON.parse(storedData);

        if (document.getElementById("foodName")) {

            document.getElementById("foodName").value = data.food;
            document.getElementById("foodType").value = data.category;
            document.getElementById("quantity").value = data.quantity;
            document.getElementById("location").value = data.location;
            document.getElementById("expiry").value = data.expiry;
            document.getElementById("donor").value = data.donor;

        }
    }

});


// ==============================
// PICKUP PAGE SCRIPT
// ==============================
document.addEventListener("DOMContentLoaded", function() {

    let data = JSON.parse(localStorage.getItem("selectedDonation"));

    // check if pickup page exists
    const donationId = document.getElementById("donationId");
    if (!donationId) return;

    // ==============================
    // LOAD DONATION DATA
    // ==============================
    if (data) {

        document.getElementById("donationId").innerText = data.id || "";
        document.getElementById("foodName").innerText = data.food || "";
        document.getElementById("foodType").innerText = data.category || "";
        document.getElementById("quantity").innerText = data.quantity || "";
        document.getElementById("donorName").innerText = data.donor || "";
        document.getElementById("pickupLocation").innerText = data.location || "";

        document.getElementById("acceptedTime").innerText =
            new Date().toLocaleString();

        document.getElementById("ngoName").innerText = "Helping Hands NGO";

        document.getElementById("volunteerName").value = "Arun Kumar";

    }


    // ==============================
    // CONFIRM PICKUP
    // ==============================
    const confirmBtn = document.getElementById("confirmPickup");

    if (confirmBtn) {
        confirmBtn.onclick = function() {

            let pickupTime = document.getElementById("actualPickupTime").value;
            let volunteer = document.getElementById("volunteerName").value;
            let vehicle = document.getElementById("vehicleNumber").value;
            let condition = document.getElementById("foodCondition").value;
            let remarks = document.getElementById("pickupRemarks").value;

            if (!pickupTime || !volunteer) {
                alert("Please fill required fields");
                return;
            }

            alert("Pickup Confirmed\nStatus Updated to Picked Up");

        };
    }

});

/* =========================
   DASHBOARD CHARTS
========================= */
document.addEventListener("DOMContentLoaded", () => {

    const months = window.months || [];
    const counts = window.counts || [];

    const statusLabels = window.statusLabels || [];
    const statusCounts = window.statusCounts || [];

    console.log("Months:", months);
    console.log("Counts:", counts);
    console.log("Status:", statusLabels, statusCounts);

    // 📊 BAR CHART
    if (document.getElementById("donationChart") && months.length > 0) {

        new Chart(document.getElementById("donationChart"), {
            type: "bar",
            data: {
                labels: months,
                datasets: [{
                    label: "Donations",
                    data: counts,
                    backgroundColor: "#198754"
                }]
            }
        });

    }

    // 🥧 PIE CHART
    if (document.getElementById("statusChart") && statusLabels.length > 0) {

        new Chart(document.getElementById("statusChart"), {
            type: "pie",
            data: {
                labels: statusLabels,
                datasets: [{
                    data: statusCounts,
                    backgroundColor: ["#ffc107", "#0d6efd", "#198754", "#dc3545"]
                }]
            }
        });

    }

});
// ===============================
// SETTINGS PAGE SCRIPT
// ===============================
document.addEventListener("DOMContentLoaded", function() {

    const editBtn = document.getElementById("editBtn");
    const saveBtn = document.getElementById("saveBtn");
    const cancelBtn = document.getElementById("cancelBtn");
    const editableFields = document.querySelectorAll(".editable");
    const settingsForm = document.getElementById("settingsForm");
    const togglePassword = document.getElementById("togglePassword");

    // If this page doesn't contain settings elements, stop script
    if (!editBtn || !saveBtn || !cancelBtn || !settingsForm) return;

    let originalValues = [];

    // EDIT BUTTON
    editBtn.addEventListener("click", function() {

        originalValues = [];

        editableFields.forEach((field, index) => {

            if (field.type === "checkbox") {
                originalValues[index] = field.checked;
            } else {
                originalValues[index] = field.value;
            }

            field.disabled = false;
        });

        editBtn.classList.add("d-none");
        saveBtn.classList.remove("d-none");
        cancelBtn.classList.remove("d-none");
    });

    // CANCEL BUTTON
    cancelBtn.addEventListener("click", function() {

        editableFields.forEach((field, index) => {

            if (field.type === "checkbox") {
                field.checked = originalValues[index];
            } else {
                field.value = originalValues[index];
            }

            field.disabled = true;
        });

        editBtn.classList.remove("d-none");
        saveBtn.classList.add("d-none");
        cancelBtn.classList.add("d-none");
    });

    // SAVE FORM
    settingsForm.addEventListener("submit", function(e) {

        e.preventDefault();

        editableFields.forEach(field => field.disabled = true);

        editBtn.classList.remove("d-none");
        saveBtn.classList.add("d-none");
        cancelBtn.classList.add("d-none");

        alert("Settings Saved Successfully");
    });

    // PASSWORD TOGGLE
    if (togglePassword) {

        togglePassword.addEventListener("click", function() {

            const passwordField = document.getElementById("passwordField");
            const icon = this.querySelector("i");

            if (!passwordField) return;

            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.remove("bi-eye");
                icon.classList.add("bi-eye-slash");
            } else {
                passwordField.type = "password";
                icon.classList.remove("bi-eye-slash");
                icon.classList.add("bi-eye");
            }

        });

    }

});


// ===============================
// ADMIN - MANAGE  DONATIONS
// ===============================
document.addEventListener("DOMContentLoaded", function() {

    const searchBox = document.getElementById("searchBox");
    const statusFilter = document.getElementById("statusFilter");
    const cancelModal = document.getElementById("cancelModal");

    // stop script if this page doesn't have the table
    if (!searchBox || !statusFilter) return;

    const tableRows = document.querySelectorAll("tbody tr");
    const cancelButtons = document.querySelectorAll(".cancel-btn");
    const confirmCancel = document.getElementById("confirmCancel");
    const cancelAlert = document.getElementById("cancelAlert");

    let selectedRow = null;

    // ===============================
    // CANCEL BUTTON CLICK
    // ===============================
    cancelButtons.forEach(button => {

        button.addEventListener("click", function() {

            selectedRow = this.closest("tr");

        });

    });

    // ===============================
    // CONFIRM CANCEL
    // ===============================
    if (confirmCancel) {

        confirmCancel.addEventListener("click", function() {

            if (selectedRow) {

                const statusCell = selectedRow.querySelector(".status-cell span");

                if (statusCell) {
                    statusCell.innerText = "Cancelled";
                }

            }

            if (cancelModal) {
                const modal = bootstrap.Modal.getInstance(cancelModal);
                if (modal) modal.hide();
            }

            if (cancelAlert) {
                cancelAlert.classList.remove("d-none");
                cancelAlert.classList.add("show");
            }

        });

    }

    // ===============================
    // TABLE FILTER FUNCTION
    // ===============================
    function filterTable() {

        const searchText = searchBox.value.toLowerCase();
        const selectedStatus = statusFilter.value.toLowerCase();

        tableRows.forEach(row => {

            const food = row.cells[1].innerText.toLowerCase();
            const donor = row.cells[2].innerText.toLowerCase();
            const ngo = row.cells[3].innerText.toLowerCase();
            const status = row.cells[8].innerText.toLowerCase();

            const matchesSearch =
                food.includes(searchText) ||
                donor.includes(searchText) ||
                ngo.includes(searchText);

            const matchesStatus =
                selectedStatus === "" || status === selectedStatus;

            row.style.display = (matchesSearch && matchesStatus) ? "" : "none";

        });

    }

    document.addEventListener("DOMContentLoaded", function() {

        const statusFilter = document.getElementById("filterStatus");
        const typeFilter = document.getElementById("filterType");
        const searchBox = document.getElementById("searchBox");

        if (!statusFilter || !typeFilter || !searchBox) return;

        const rows = document.querySelectorAll("tbody tr");

        function filterTable() {

            const statusValue = statusFilter.value.toLowerCase();
            const typeValue = typeFilter.value.toLowerCase();
            const searchValue = searchBox.value.toLowerCase();

            rows.forEach(row => {

                if (row.classList.contains("no-data-row")) return;

                const food = row.cells[1].innerText.toLowerCase();
                const location = row.cells[3].innerText.toLowerCase();
                const status = row.cells[5].innerText.toLowerCase();

                let type = "";

                if (food.includes("veg")) type = "veg";
                else if (food.includes("chicken") || food.includes("non")) type = "nonveg";
                else if (food.includes("fruit")) type = "fruit";
                else if (food.includes("snack")) type = "snack";
                else if (food.includes("juice") || food.includes("beverage")) type = "beverage";
                else type = "packed";

                const matchStatus = !statusValue || status === statusValue;
                const matchType = !typeValue || type === typeValue;
                const matchSearch = !searchValue || food.includes(searchValue) || location.includes(searchValue);

                row.style.display = (matchStatus && matchType && matchSearch) ? "" : "none";

            });

        }

        statusFilter.addEventListener("change", filterTable);
        typeFilter.addEventListener("change", filterTable);
        searchBox.addEventListener("keyup", filterTable);

    });

    // ===============================
    // FILTER EVENTS
    // ===============================
    searchBox.addEventListener("keyup", filterTable);
    statusFilter.addEventListener("change", filterTable);

});


// ===============================
// ADMIN MANAGE USERS SCRIPT
// ===============================
document.addEventListener("DOMContentLoaded", function() {

    const searchBox = document.getElementById("searchBox");
    const roleFilter = document.getElementById("filterRole");
    const statusFilter = document.getElementById("filterStatus");

    // Stop script if not on Manage Users page
    if (!searchBox || !roleFilter || !statusFilter) return;

    const tableRows = document.querySelectorAll("tbody tr:not(.no-data-row)");
    const noDataRow = document.querySelector(".no-data-row");
    const blockButtons = document.querySelectorAll(".block-btn");


    // ===============================
    // FILTER TABLE FUNCTION
    // ===============================
    function filterTable() {

        const searchText = searchBox.value.toLowerCase();
        const selectedRole = roleFilter.value.toLowerCase();
        const selectedStatus = statusFilter.value.toLowerCase();

        let visibleCount = 0;

        tableRows.forEach(row => {

            const name = row.cells[1]?.innerText.toLowerCase() || "";
            const role = row.cells[2]?.innerText.toLowerCase() || "";
            const email = row.cells[3]?.innerText.toLowerCase() || "";
            const phone = row.cells[4]?.innerText.toLowerCase() || "";
            const status = row.cells[6]?.innerText.toLowerCase() || "";

            const matchesSearch =
                name.includes(searchText) ||
                email.includes(searchText) ||
                phone.includes(searchText);

            const matchesRole =
                selectedRole === "" || role === selectedRole;

            const matchesStatus =
                selectedStatus === "" || status === selectedStatus;

            if (matchesSearch && matchesRole && matchesStatus) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }

        });

        // Show "No Data Found" row
        if (noDataRow) {
            noDataRow.style.display = visibleCount === 0 ? "" : "none";
        }

    }

    // ===============================
    // FILTER EVENTS
    // ===============================
    searchBox.addEventListener("keyup", filterTable);
    roleFilter.addEventListener("change", filterTable);
    statusFilter.addEventListener("change", filterTable);


    // ===============================
    // BLOCK USER FUNCTION
    // ===============================
    blockButtons.forEach(button => {

        button.addEventListener("click", function() {

            const row = this.closest("tr");

            if (!row) return;

            const userName = row.cells[1]?.innerText || "User";
            const userStatusCell = row.cells[7];

            if (confirm(`Are you sure you want to block ${userName}?`)) {

                if (userStatusCell) {
                    userStatusCell.innerText = "Blocked";
                    userStatusCell.classList.add("text-danger");
                }

                this.disabled = true;
                this.innerText = "Blocked";

                this.classList.remove("btn-outline-danger");
                this.classList.add("btn-secondary");

            }

        });

    });

});

// ================================
// DONOR MANAGE DONATION FILTER
// ================================
document.addEventListener("DOMContentLoaded", function() {

    const table = document.getElementById("donationTable");
    if (!table) return;

    const statusFilter = document.getElementById("filterStatus");
    const typeFilter = document.getElementById("filterType");
    const dateFilter = document.getElementById("filterDate");
    const searchBox = document.getElementById("searchBox");

    const rows = table.querySelectorAll("tbody tr");

    function filterTable() {

        const statusValue = statusFilter.value.toLowerCase();
        const typeValue = typeFilter.value.toLowerCase();
        const dateValue = dateFilter.value;
        const searchValue = searchBox.value.toLowerCase();

        const today = new Date();
        const startOfWeek = new Date(today);
        startOfWeek.setDate(today.getDate() - today.getDay());

        let visible = 0;

        rows.forEach(row => {

            if (row.classList.contains("no-data-row")) return;

            const food = row.cells[1].innerText.toLowerCase();
            const category = row.cells[2].innerText.toLowerCase().replace(/\s/g, '');
            const location = row.cells[4].innerText.toLowerCase();
            const status = row.cells[6].innerText.toLowerCase();

            const preparedDate = new Date(row.dataset.preparedDate);

            // ---------- CATEGORY FILTER ----------
            let typeMatch = true;

            if (typeValue) {

                const filterType = typeValue.replace(/\s/g, '');

                typeMatch = category === filterType; // FIXED
            }

            // ---------- STATUS FILTER ----------
            const statusMatch =
                !statusValue || status.includes(statusValue.toLowerCase());

            // ---------- SEARCH FILTER ----------
            const searchMatch =
                !searchValue ||
                food.includes(searchValue) ||
                location.includes(searchValue);

            // ---------- DATE FILTER ----------
            let dateMatch = true;

            if (dateValue === "today") {
                dateMatch = preparedDate.toDateString() === today.toDateString();
            }

            if (dateValue === "thisWeek") {
                dateMatch = preparedDate >= startOfWeek && preparedDate <= today;
            }

            if (typeMatch && statusMatch && searchMatch && dateMatch) {
                row.style.display = "";
                visible++;
            } else {
                row.style.display = "none";
            }

        });

        const noDataRow = document.querySelector(".no-data-row");

        if (noDataRow) {
            noDataRow.style.display = visible === 0 ? "" : "none";
        }

    }

    statusFilter.addEventListener("change", filterTable);
    typeFilter.addEventListener("change", filterTable);
    dateFilter.addEventListener("change", filterTable);
    searchBox.addEventListener("keyup", filterTable);

});
//		=========================
//DONOR GPS LOCATION SCRIPT
//=========================

document.addEventListener("DOMContentLoaded", function() {

    const latField = document.getElementById("latitude");
    const lonField = document.getElementById("longitude");

    // Only run on Add Surplus Food page
    if (!latField || !lonField) return;

    if (navigator.geolocation) {

        navigator.geolocation.getCurrentPosition(function(position) {
            latField.value = position.coords.latitude;
            lonField.value = position.coords.longitude;

            console.log("Donor location captured:", latField.value, lonField.value);

        }, function(error) {
            console.log("Location error:", error.message);
        });

    } else {
        console.log("Geolocation not supported by this browser.");
    }

});

// ================================
// NGO VIEW DONATIONS PAGE SCRIPT
// ================================
document.addEventListener("DOMContentLoaded", function() {

    const filterType = document.getElementById("filterType");
    const filterQuantity = document.getElementById("filterQuantity");
    const expiryTime = document.getElementById("expiryTime");
    const searchBox = document.getElementById("searchBox");
    const donationTable = document.getElementById("donationTable");

    if (!donationTable) return; // stop script if table not present

    const rows = donationTable.querySelectorAll("tbody tr");
    const noData = document.querySelector(".no-data-row");

    function getQuantitySize(text) {
        let value = parseFloat(text);
        if (value < 5) return "small";
        if (value <= 10) return "medium";
        return "large";
    }

    function isExpiryMatch(time, filter) {
        if (!filter) return true;

        let now = new Date();
        let [h, m] = time.split(":");

        let expiry = new Date();
        expiry.setHours(h, m, 0, 0);

        let diff = (expiry - now) / (1000 * 60);

        if (filter === "soon") return diff <= 120;
        if (filter === "later") return diff > 120;

        return true;
    }

    function filterTable() {

        let visible = false;

        rows.forEach(row => {

            if (row.classList.contains("no-data-row")) return;

            let food = row.cells[1].innerText.toLowerCase();
            let category = row.cells[2].innerText.toLowerCase().trim();
            let quantity = row.cells[3].innerText;
            let location = row.cells[4].innerText.toLowerCase();
            let expiry = row.cells[5].innerText;

            let typeMatch = !filterType.value || category === filterType.value.toLowerCase();
            let quantityMatch = !filterQuantity.value || getQuantitySize(quantity) === filterQuantity.value;
            let expiryMatch = isExpiryMatch(expiry, expiryTime.value);
            let searchMatch = !searchBox.value || food.includes(searchBox.value.toLowerCase()) || location.includes(searchBox.value.toLowerCase());

            if (typeMatch && quantityMatch && expiryMatch && searchMatch) {
                row.style.display = "";
                visible = true;
            } else {
                row.style.display = "none";
            }

        });

        if (noData) {
            noData.style.display = visible ? "none" : "";
        }
    }

    if (filterType) filterType.onchange = filterTable;
    if (filterQuantity) filterQuantity.onchange = filterTable;
    if (expiryTime) expiryTime.onchange = filterTable;
    if (searchBox) searchBox.onkeyup = filterTable;


    // ============================
    // VIEW BUTTON CLICK HANDLER
    // ============================
    document.addEventListener("click", function(e) {

        if (!e.target.classList.contains("View-btn")) return;

        let row = e.target.closest("tr");

        let status = row.cells[7].innerText.trim().toLowerCase();

        if (status === "picked up") {
            alert("This food has already been picked up");
            return;
        }

        if (status === "completed") {
            alert("This order is already completed");
            return;
        }

        if (status === "cancelled") {
            alert("This donation has been cancelled");
            return;
        }

        const donorContacts = {
            "1": "9876543210",
            "2": "9123456780",
            "3": "9988776655",
            "4": "9012345678",
            "5": "9090909090"
        };

        let id = row.cells[0].innerText;

        let data = {
            id: id,
            food: row.cells[1].innerText,
            category: row.cells[2].innerText,
            quantity: row.cells[3].innerText,
            location: row.cells[4].innerText,
            expiry: row.cells[5].innerText,
            donor: row.cells[6].innerText,
            status: status,
            phone: donorContacts[id] || ""
        };

        localStorage.setItem("selectedDonation", JSON.stringify(data));

        window.location.href = "acceptDonation";

    });

});

/* =========================
   ACCEPT DONATION PAGE
========================= */
document.addEventListener("DOMContentLoaded", () => {

    const storedData = localStorage.getItem("selectedDonation");

    if (storedData) {

        const data = JSON.parse(storedData);

        if (document.getElementById("foodName")) {

            document.getElementById("foodName").value = data.food;
            document.getElementById("foodType").value = data.category;
            document.getElementById("quantity").value = data.quantity;
            document.getElementById("location").value = data.location;
            document.getElementById("expiry").value = data.expiry;
            document.getElementById("donor").value = data.donor;

        }
    }

});


/*===================
Phone number validation
=====================*/

/*===================
Phone number validation
=====================*/

const phone = document.getElementById("phone");
const phoneError = document.getElementById("phoneError");

// ✅ FIX: check if element exists
if (phone && phoneError) {

    // Validate on blur
    phone.addEventListener("blur", function() {
        if (phone.value === "") {
            phoneError.style.color = "red";
            phoneError.textContent = "Phone number is required";
        } else if (!/^\d{10}$/.test(phone.value)) {
            phoneError.style.color = "red";
            phoneError.textContent = "Phone number should be exactly 10 digits";
        } else {
            phoneError.style.color = "green";
            phoneError.textContent = "Valid phone number ✓";
        }
    });

    // Restrict input
    phone.addEventListener("input", function() {
        phone.value = phone.value.replace(/\D/g, "");

        if (phone.value.length > 10) {
            phone.value = phone.value.slice(0, 10);
        }
    });

}/*=======================
Password validation
========================*/

/*=======================
Password validation
========================*/

document.addEventListener("DOMContentLoaded", function() {

    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const errorMsg = document.getElementById("passwordError");

    // ✅ FIX: check if elements exist
    if (!password || !confirmPassword || !errorMsg) return;

    password.addEventListener("input", function() {
        const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

        if (!pattern.test(password.value)) {
            password.setCustomValidity("Weak password");
        } else {
            password.setCustomValidity("");
        }
    });

    confirmPassword.addEventListener("blur", function() {
        if (confirmPassword.value === "") {
            errorMsg.style.color = "red";
            errorMsg.textContent = "Please confirm your password";
        } else if (confirmPassword.value !== password.value) {
            errorMsg.style.color = "red";
            errorMsg.textContent = "Passwords do not match";
        } else {
            errorMsg.style.color = "green";
            errorMsg.textContent = "Passwords match ✓";
        }
    });

});
/*=======================
profile update script
========================*/
console.log("Profile JS Loaded");
document.addEventListener("DOMContentLoaded", function() {

    const editBtn = document.getElementById("editBtn");
    const saveBtn = document.getElementById("saveBtn");
    const cancelBtn = document.getElementById("cancelBtn");
    const editableFields = document.querySelectorAll(".editable");
    const form = document.getElementById("profileForm");

    // ✅ Prevent errors if elements are not present on other pages
    if (!editBtn || !saveBtn || !cancelBtn || !form) return;

    let originalValues = [];

    // EDIT BUTTON
    editBtn.addEventListener("click", function() {
        originalValues = [];

        editableFields.forEach((field, index) => {
            originalValues[index] = field.value;
            field.removeAttribute("readonly");
        });

        editBtn.classList.add("d-none");
        saveBtn.classList.remove("d-none");
        cancelBtn.classList.remove("d-none");
    });

    // CANCEL BUTTON
    cancelBtn.addEventListener("click", function() {

        editableFields.forEach((field, index) => {
            field.value = originalValues[index];
            field.setAttribute("readonly", true);
        });

        editBtn.classList.remove("d-none");
        saveBtn.classList.add("d-none");
        cancelBtn.classList.add("d-none");
    });

    // FORM SUBMIT
    form.addEventListener("submit", function() {

        editableFields.forEach(field => {
            field.setAttribute("readonly", true);
        });

        editBtn.classList.remove("d-none");
        saveBtn.classList.add("d-none");
        cancelBtn.classList.add("d-none");
    });

});

function sendMessage() {

    let input = document.getElementById("message");
    let message = input.value;

    if (message.trim() === "") return;

    let chatBox = document.getElementById("chat-box");

    chatBox.innerHTML += "<div class='user'><b>You:</b> " + message + "</div>";

    fetch("/ask-jarvis", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ message: message })
    })
        .then(response => response.text())
        .then(data => {

            chatBox.innerHTML += "<div class='bot'><b>Jarvis:</b> " + data + "</div>";

            chatBox.scrollTop = chatBox.scrollHeight;

        });

    input.value = "";
}


// ✅ ENTER KEY SUPPORT
document.addEventListener("DOMContentLoaded", function() {

    const input = document.getElementById("message");

    if (input) {
        input.addEventListener("keydown", function(event) {

            if (event.key === "Enter") {
                event.preventDefault();
                sendMessage();
            }

        });
    }

});


/*==================
OTP Verification
===================*/
let otpVerified = false;

// Send OTP
document.getElementById("sendOtpBtn").addEventListener("click", function() {
    let phone = document.getElementById("phone").value;

    if (!phone) {
        alert("Enter phone number first!");
        return;
    }

    fetch("send-otp", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "phone=" + phone
    })
        .then(res => res.text())
        .then(data => {
            alert("OTP sent! (Check server console)");
        });
});

// Verify OTP
document.getElementById("verifyOtpBtn").addEventListener("click", function() {
    let otp = document.getElementById("otp").value;

    fetch("verify-otp", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "otp=" + otp
    })
        .then(res => res.text())
        .then(data => {
            alert(data);

            if (data.includes("Success")) {
                otpVerified = true;
                document.getElementById("registerBtn").disabled = false;
            }
        });
});

/*=================
Edit User
=================*/
const roleSelect = document.getElementById("roleSelect");
const orgField = document.getElementById("orgField");

function toggleOrgField() {
    if (roleSelect.value === "ngo") {
        orgField.style.display = "block";
    } else {
        orgField.style.display = "none";
    }
}

// Run on load + change
toggleOrgField();
roleSelect.addEventListener("change", toggleOrgField);



// ===============================
// ADMIN - MANAGE DONATIONS (SAFE VERSION)
// ===============================
document.addEventListener("DOMContentLoaded", function () {

    const table = document.getElementById("donationTable");

    // ✅ Run ONLY on admin donations page
    if (!table || !document.body.innerText.includes("Manage Donations")) return;

    const searchBox = document.getElementById("searchBox");
    const statusFilter = document.getElementById("statusFilter");
    const confirmBtn = document.getElementById("confirmCancel");

    let cancelId = null;

    // ================= VIEW =================
    window.setDonationData = function (id, food, donor, ngo, qty, loc, date, exp, status) {

        document.getElementById("v_id").innerText = id;
        document.getElementById("v_food").innerText = food;
        document.getElementById("v_donor").innerText = donor;
        document.getElementById("v_ngo").innerText = ngo;
        document.getElementById("v_qty").innerText = qty;
        document.getElementById("v_loc").innerText = loc;
        document.getElementById("v_date").innerText = date;
        document.getElementById("v_exp").innerText = exp;
        document.getElementById("v_status").innerText = status;
    };

    // ================= CANCEL =================
    window.setCancelId = function (id) {
        cancelId = id;
    };

    if (confirmBtn) {
        confirmBtn.addEventListener("click", function () {
            if (cancelId) {
                window.location.href = "admin/cancelDonation?id=" + cancelId;
            }
        });
    }

    // ================= FILTER FUNCTION =================
    function adminFilterTable() {

        if (!searchBox || !statusFilter) return;

        const search = searchBox.value.toLowerCase();
        const status = statusFilter.value;

        const rows = table.querySelectorAll("tr");

        rows.forEach(row => {

            const food = row.querySelector(".food")?.innerText.toLowerCase() || "";
            const donor = row.querySelector(".donor")?.innerText.toLowerCase() || "";
            const ngo = row.querySelector(".ngo")?.innerText.toLowerCase() || "";
            const rowStatus = row.querySelector(".status-cell")?.getAttribute("data-status");

            const matchSearch =
                food.includes(search) ||
                donor.includes(search) ||
                ngo.includes(search);

            const matchStatus =
                !status || rowStatus === status;

            row.style.display = (matchSearch && matchStatus) ? "" : "none";
        });
    }

    // ================= EVENTS =================
    if (searchBox) searchBox.addEventListener("keyup", adminFilterTable);
    if (statusFilter) statusFilter.addEventListener("change", adminFilterTable);

});