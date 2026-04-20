package com.example.foodapp.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.foodapp.model.Donation;
import com.example.foodapp.model.User;
import com.example.foodapp.repository.DonationRepository;
import com.example.foodapp.repository.UserRepository;
import com.example.foodapp.service.DonationService;
import com.example.foodapp.service.NotificationService;
import com.example.foodapp.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

	@Autowired
	private UserService userService;

	@Autowired
	private DonationService donationService;

	@Autowired
	private NotificationService notificationService;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private DonationRepository donationRepository;

	// Show home Page
	@GetMapping("/")
	public String homePage() {
		return "home";
	}

	// ================= LOGIN PAGE =================
	@GetMapping("/login")
	public String loginPage() {
		return "login";
	}

	// ================= LOGIN PROCESS =================
	@PostMapping("/login")
	public String loginUser(@ModelAttribute User user, @RequestParam("role") String selectedRole, HttpSession session) {

		User existingUser = userService.authenticateUser(user.getEmail(), user.getPassword());

		if (existingUser != null) {

			String role = existingUser.getRole();

			if (role != null && role.equalsIgnoreCase(selectedRole)) {

				// ⭐ STORE USER IN SESSION
				session.setAttribute("loggedUser", existingUser);

				if (role.equalsIgnoreCase("donor")) {
					return "redirect:/donor-dashboard";
				} else if (role.equalsIgnoreCase("ngo")) {
					return "redirect:/ngo-dashboard";
				} else if (role.equalsIgnoreCase("admin")) {
					return "redirect:/admin-dashboard";
				}
			}
		}

		return "login";
	}

	// ================= REGISTER PAGE =================
	@GetMapping("/register")
	public String registerPage() {
		return "register";
	}

	// ================= REGISTER PROCESS =================

	// Register user only if OTP is verified
	@PostMapping("/register")
	public String registerUser(@ModelAttribute User user, HttpSession session, RedirectAttributes ra) {

		// Check if OTP is verified
		Boolean isVerified = (Boolean) session.getAttribute("otpVerified");

		if (isVerified == null || !isVerified) {
			ra.addFlashAttribute("errorMessage", "Please verify OTP before registration.");
			return "redirect:/register";
		}

		// Attempt to register user
		boolean status = userService.registerUser(user);

		if (!status) {
			ra.addFlashAttribute("errorMessage", "Email already exists!");
			return "redirect:/register";
		}

		// Clear OTP session after successful registration
		session.removeAttribute("otpVerified");
		session.removeAttribute("otpPhone");

		return "redirect:/login";
	}

	// ================= LOGOUT =================
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	// Show donor-dashboard Page
	@GetMapping("/donor-dashboard")
	public String DonorPage(HttpSession session, Model model) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null || !"donor".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}

		List<Donation> donorDonations = donationService.getDonationsByDonor(loggedUser);

		int total = donorDonations.size();
		int pending = 0;
		int accepted = 0;
		int expired = 0;

		for (Donation d : donorDonations) {

			if ("CREATED".equalsIgnoreCase(d.getStatus())) {
				pending++;
			}

			if ("ACCEPTED".equalsIgnoreCase(d.getStatus())) {
				accepted++;
			}

			if ("EXPIRED".equalsIgnoreCase(d.getStatus())) {
				expired++;
			}
		}

		model.addAttribute("donations", donorDonations);
		model.addAttribute("totalDonations", total);
		model.addAttribute("pendingDonations", pending);
		model.addAttribute("acceptedDonations", accepted);
		model.addAttribute("expiredDonations", expired);

		return "donor-dashboard";
	}

	@GetMapping("/addSurplusfood")
	public String AddDonationPage(HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"donor".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		return "addSurplusfood";
	}

	@PostMapping("/addSurplusfood")
	public String addDonation(Donation donation, HttpSession session) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null) {
			return "redirect:/login";
		}

		if (!"donor".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}

		donation.setDonor(loggedUser);
		donation.setStatus("CREATED");

		donationService.saveDonation(donation);

		return "redirect:/donor-dashboard";
	}

	// edit donation-donor
	@GetMapping("/editDonation/{id}")
	public String editDonation(@PathVariable Integer id, HttpSession session, Model model) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null || !"donor".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}

		Donation donation = donationRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Donation not found"));

		if (donation == null) {
			return "redirect:/donor-dashboard";
		}
		if (donation.getStatus().equals("ACCEPTED") || donation.getStatus().equals("CANCELLED")) {
			return "redirect:/donor-dashboard";
		}

		model.addAttribute("donation", donation);

		return "editDonation";
	}

	// update donation-donor
	@PostMapping("/updateDonation")
	public String updateDonation(@ModelAttribute Donation donation) {

		Donation existing = donationRepository.findById(donation.getDonationId()).get();

		existing.setFoodName(donation.getFoodName());
		existing.setFoodType(donation.getFoodType());
		existing.setQuantity(donation.getQuantity());
		existing.setPickupAddress(donation.getPickupAddress());
		existing.setExpiryTime(donation.getExpiryTime());
		existing.setStatus(donation.getStatus());

		donationRepository.save(existing);

		return "redirect:/manageDonation";
	}

	// cancel donation-donor
	@GetMapping("/cancelDonation/{id}")
	public String cancelDonation(@PathVariable Integer id, HttpSession session) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null || !"donor".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}

		Donation donation = donationRepository.findById(id).orElse(null);

		if (donation != null) {

			if (donation.getStatus().equals("ACCEPTED")) {
				return "redirect:/donor-dashboard";
			}

			donation.setStatus("CANCELLED");

			donationService.saveDonation(donation);
		}

		return "redirect:/donor-dashboard";
	}

	// Show add-donation Page
	@GetMapping("/acceptDonation/{id}")
	public String acceptDonationPage(@PathVariable Integer id, Model model, HttpSession session) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null || !"ngo".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}

		Donation donation = donationRepository.findById(id).orElse(null);

		model.addAttribute("donation", donation);

		return "acceptDonation";
	}

	@PostMapping("/acceptDonation/{id}")
	public String acceptDonation(@PathVariable Integer id, HttpSession session) {

	    User loggedUser = (User) session.getAttribute("loggedUser");

	    if (loggedUser == null || !"ngo".equalsIgnoreCase(loggedUser.getRole())) {
	        return "redirect:/login";
	    }

	    Donation donation = donationRepository.findById(id).orElse(null);

	    if (donation != null && "CREATED".equalsIgnoreCase(donation.getStatus())) {

	        donation.setStatus("ACCEPTED");
	        donation.setNgo(loggedUser);

	        donationRepository.save(donation);


	        donationService.generatePickupOtp(String.valueOf(id)); 
	    }

	    return "redirect:/viewDonation";
	}

	// Show manage-donation Page
	@GetMapping("/manageDonation")
	public String ManageDonationPage(HttpSession session, Model model) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"donor".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		List<Donation> donorDonations = donationService.getDonationsByDonor(loggedUser);
		model.addAttribute("donations", donorDonations);
		return "manageDonation";
	}

	// Show donation-status Page
	@GetMapping("/donation-status")
	public String DonationStatusPage(HttpSession session, Model model) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"donor".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		List<Donation> donorDonations = donationService.getDonationsByDonor(loggedUser);
		model.addAttribute("donations", donorDonations);
		return "donation-status";
	}

// Show ngo-dashboard Page
	@GetMapping("/ngo-dashboard")
	public String NGOPage(HttpSession session, Model model) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"ngo".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		model.addAttribute("totalDonations", donationService.getDonationsByNgo(loggedUser).size());
		model.addAttribute("acceptedDonations",
				donationService.getDonationsByStatusAndNgo("ACCEPTED", loggedUser).size());
		model.addAttribute("pendingDonations", donationService.getDonationsByStatus("CREATED").size());
		model.addAttribute("recentDonations", donationService.getDonationsByNgo(loggedUser));
		return "ngo-dashboard";
	}
	@GetMapping("/viewDonation")
	public String viewDonationPage(HttpSession session, Model model) {

	    User loggedUser = (User) session.getAttribute("loggedUser");

	    if (loggedUser == null || !"ngo".equalsIgnoreCase(loggedUser.getRole())) {
	        return "redirect:/login";
	    }

	    List<Donation> donations = donationService.getDonationsForNgo(loggedUser);

	    model.addAttribute("donations", donations);

	    return "viewDonation";
	}
	@GetMapping("/search-food")
	public String searchFoodPage(HttpSession session, Model model, @RequestParam(required = false) String city) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null || !"ngo".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}

		List<Donation> donations;

		if (city != null && !city.isEmpty()) {
			donations = donationRepository.findByPickupAddressContainingAndStatus(city, "CREATED");
		} else {
			donations = donationRepository.findByStatus("CREATED");
		}

		model.addAttribute("donations", donations);

		return "search-food";
	}

	// Show ngo-dashboard Page
	@GetMapping("/view-map")
	public String ViewMapPage(HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"ngo".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		return "view-map";
	}

	// Show ngo-dashboard Page
	@GetMapping("/acceptDonation")
	public String AcceptDonationPage(HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"ngo".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		return "acceptDonation";
	}

	// Show ngo-dashboard Page
	@GetMapping("/pickup/{id}")
	public String loadPickupPage(@PathVariable Integer id, Model model) {

		System.out.println("Pickup page opened for ID: " + id);

		Donation donation = donationService.getDonationById(id);

		if (donation == null) {
			throw new RuntimeException("Donation not found");
		}

		model.addAttribute("donation", donation);

		return "pickup";
	}

	@PostMapping("/confirm-pickup")
	public String confirmPickup(@RequestParam Integer donationId,
	                            @RequestParam String volunteerName,
	                            @RequestParam String vehicleNumber,
	                            @RequestParam String pickupRemarks,
	                            @RequestParam String vehicleType,
	                            @RequestParam String actualPickupTime) {

	    Donation donation = donationRepository.findById(donationId).orElse(null);

	    if (donation != null) {

	        donation.setStatus("PICKED_UP");   
	        donation.setVolunteerName(volunteerName);
	        donation.setVehicleNumber(vehicleNumber);
	        donation.setPickupRemarks(pickupRemarks);
	        donation.setActualPickupTime(LocalDateTime.parse(actualPickupTime));

	        donationRepository.save(donation);
	    }

	    return "redirect:/viewDonation";  // 🔥 redirect
	}
	// Show admin-dashboard Page
	@GetMapping("/admin-dashboard")
	public String adminDashboard(HttpSession session, Model model) {

		// 1. Check if user is logged in
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null) {
			// User not logged in → redirect to login
			return "redirect:/login";
		}

		// 2. Check if user is admin
		if (!"admin".equalsIgnoreCase(loggedUser.getRole())) {
			// Not an admin → show access denied page
			return "accessdenied";
		}

		// 3. Fetch dashboard data
		model.addAttribute("totalUsers", userService.getTotalUsers());
		model.addAttribute("activeNGOs", userService.getActiveNGOsCount());
		model.addAttribute("totalDonations", donationService.getTotalDonations());
		model.addAttribute("pendingRequests", donationService.getPendingRequestsCount());
		model.addAttribute("recentDonations", donationService.getRecentDonations());
		model.addAttribute("activities", notificationService.getRecentActivities());

		return "admin-dashboard";
	}

	// Show manage-users Page
	@GetMapping("/manageUsers")
	public String ManageUsersPage(HttpSession session, Model model) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"admin".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		model.addAttribute("users", userRepository.findAll());
		return "manageUsers";
	}

	// Show manage donation-admin Page
	@GetMapping("/manageDonation-admin")
	public String ManageDonationAdminPage(HttpSession session, Model model) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"admin".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		model.addAttribute("donations", donationRepository.findAll());
		return "manageDonation-admin";
	}

	// Show notification-status Page
	@GetMapping("/notification-status")
	public String NotificationStatusPage(HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");
		if (loggedUser == null || !"admin".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}
		return "notification-status";
	}

	// Show reports-analytics Page
	@GetMapping("/reports-analytics")
	public String reportsPage(Model model) {

		// Summary Data
		long donations = donationService.getTotalDonations();
		long donors = userService.countByRole("DONOR");
		long ngos = userService.getActiveNGOsCount();
		Double foodSaved = donationService.getTotalFoodQuantity();

		System.out.println("Total Donations: " + donations);
		System.out.println("Total Donors: " + donors);
		System.out.println("Total NGOs: " + ngos);
		System.out.println("Food Saved: " + foodSaved);

		model.addAttribute("totalDonations", donations);
		model.addAttribute("totalDonors", donors);
		model.addAttribute("totalNGOs", ngos);
		model.addAttribute("foodSaved", foodSaved);

		//  Recent Donations Table
		model.addAttribute("recentDonations", donationService.getRecentDonations());

		// MONTHLY DONATION CHART DATA

		List<Object[]> monthly = donationService.getMonthlyDonations();

		List<Integer> months = new ArrayList<>();
		List<Long> counts = new ArrayList<>();

		for (Object[] obj : monthly) {
			months.add((Integer) obj[0]); // month number
			counts.add((Long) obj[1]); // count
		}

		model.addAttribute("months", months);
		model.addAttribute("counts", counts);

		// STATUS PIE CHART DATA

		List<Object[]> statusList = donationService.getDonationStatusCounts();

		List<String> statusLabels = new ArrayList<>();
		List<Long> statusCounts = new ArrayList<>();

		for (Object[] obj : statusList) {
			statusLabels.add((String) obj[0]); // status
			statusCounts.add((Long) obj[1]); // count
		}

		model.addAttribute("statusLabels", statusLabels);
		model.addAttribute("statusCounts", statusCounts);

		return "reports-analytics";
	}

	// Show edit-user Page
	@GetMapping("/editUser")
	public String editUser(@RequestParam("id") int id, Model model) {

		System.out.println("Editing user ID: " + id); // DEBUG

		User user = userService.getUserById(id);

		model.addAttribute("user", user);

		return "editUser";
	}

	// Show edit-donation Page
	@GetMapping("/admin/editDonation")
	public String editDonationAdmin(@RequestParam("id") int id, HttpSession session, Model model) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null || !"admin".equalsIgnoreCase(loggedUser.getRole())) {
			return "redirect:/login";
		}

		Optional<Donation> donation = donationService.getDonationById(id);
		model.addAttribute("donation", donation);

		return "editDonation-admin";
	}

	// Show view-user Page
	@GetMapping("/viewUser")
	public String viewUser(@RequestParam("id") int id, Model model) {

		User user = userService.getUserById(id);

		model.addAttribute("user", user);

		return "viewUser";
	}

	// fetching profile page
	@GetMapping("/profile")
	public String profilePage(HttpSession session, Model model) {

		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null) {
			return "redirect:/login";
		}

		User donor = userService.findByEmail(loggedUser.getEmail());
		model.addAttribute("donor", donor);

		return "profile"; // profile.jsp
	}

	// Update profile
	@PostMapping("/updateProfile")
	public String updateProfile(@RequestParam String name, @RequestParam String phone, @RequestParam String address,
			HttpSession session) {
		User loggedUser = (User) session.getAttribute("loggedUser");

		if (loggedUser == null) {
			return "redirect:/login";
		}

		User user = userService.findByEmail(loggedUser.getEmail());

		user.setName(name);
		user.setPhone(phone);
		user.setAddress(address);

		userService.updateUser(user);

		session.setAttribute("loggedUser", user);

		return "redirect:/profile";
	}

	// otp
	private Map<String, String> otpStore = new HashMap<>();

	// ================== SEND OTP ==================
	@PostMapping("/send-otp")
	@ResponseBody
	public String sendOtp(@RequestParam String phone, HttpSession session) {

		// Generate random 6-digit OTP
		String otp = String.valueOf(new Random().nextInt(900000) + 100000);

		// Save OTP in map
		otpStore.put(phone, otp);

		// Save phone in session
		session.setAttribute("otpPhone", phone);

		// Print OTP in server console for testing
		System.out.println("DEBUG OTP for " + phone + " : " + otp);

		return "OTP sent. Check server console for testing.";
	}

	// ================== VERIFY OTP ==================
	@PostMapping("/verify-otp")
	@ResponseBody
	public String verifyOtp(@RequestParam String otp, HttpSession session) {

		// Retrieve phone from session
		String phone = (String) session.getAttribute("otpPhone");

		if (phone == null) {
			return "Session expired. Please request OTP again.";
		}

		// Get OTP from map
		String storedOtp = otpStore.get(phone);

		if (storedOtp != null && storedOtp.equals(otp)) {

			// Mark OTP verified in session
			session.setAttribute("otpVerified", true);

			// Remove OTP from map
			otpStore.remove(phone);

			return "OTP Verified Successfully";
		}

		return "Invalid OTP";
	}

	@PostMapping("/updateUser")
	public String updateUser(@ModelAttribute User user) {

		User existingUser = userService.getUserById(user.getUserId());

		existingUser.setName(user.getName());
		existingUser.setEmail(user.getEmail());
		existingUser.setPhone(user.getPhone());
		existingUser.setRole(user.getRole());
		existingUser.setOrganizationName(user.getOrganizationName());

		// THIS LINE WAS MISSING
		existingUser.setStatus(user.getStatus());

		// KEEP PASSWORD SAFE
		existingUser.setPassword(existingUser.getPassword());

		userService.updateUser(existingUser);

		return "redirect:/manageUsers";
	}

	@PostMapping("/admin/updateDonation")
	public String updateDonationAdmin(@ModelAttribute Donation donation, HttpSession session) {

		User user = (User) session.getAttribute("loggedUser");

		// ✅ Only ADMIN allowed
		if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
			return "redirect:/login";
		}

		donationService.updateDonation(donation);

		return "redirect:/manageDonation-admin";
	}

	@GetMapping("/admin/cancelDonation")
	public String cancelDonationAdmin(@RequestParam int id, HttpSession session) {

		User user = (User) session.getAttribute("loggedUser");

		// Only ADMIN allowed
		if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
			return "redirect:/login";
		}

		donationService.cancelDonation(id);

		return "redirect:/manageDonation-admin";
	}

	// Map to store OTPs per pickup (using donationId or NGO phone)
	@PostMapping("/verify-pickup-otp")
	@ResponseBody
	public String verifyPickupOtp(@RequestParam Integer donationId,
	                             @RequestParam String otp) {

	    boolean isValid = donationService.verifyPickupOtp(
	            String.valueOf(donationId),  
	            otp
	    );

	    if (isValid) {
	        return "OTP Verified";
	    } else {
	        return "Invalid or Expired OTP";
	    }
	}

	

}
