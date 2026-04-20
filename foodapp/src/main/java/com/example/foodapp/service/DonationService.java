package com.example.foodapp.service;

import java.time.LocalDateTime;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.foodapp.model.*;
import com.example.foodapp.repository.*;

@Service
public class DonationService {

    @Autowired
    private DonationRepository donationRepo;
    
    @Autowired
    private UserRepository repo;

    @Autowired
    private NotificationRepository notificationRepo;

    // ================= PICKUP OTP STORE =================
    private Map<String, PickupOtpData> pickupOtpStore = new HashMap<>();

    // ================= BASIC OPERATIONS =================

    public void saveDonation(Donation donation) {
        donationRepo.save(donation);
    }

    public Optional<Donation> getDonationById(int id) {
        return donationRepo.findById(id);
    }

    public List<Donation> getDonationsByStatus(String status) {
        return donationRepo.findByStatus(status);
    }

    // ================= DONOR FUNCTIONS =================

    public List<Donation> getDonationsByDonor(User donor) {
        return donationRepo.findByDonor(donor);
    }

    public long getTotalDonationsByDonor(User donor) {
        return donationRepo.countByDonor(donor);
    }

    public long getPendingDonationsByDonor(User donor) {
        return donationRepo.countByDonorAndStatus(donor, "CREATED");
    }

    public long getAcceptedDonationsByDonor(User donor) {
        return donationRepo.countByDonorAndStatus(donor, "ACCEPTED");
    }

    public long getExpiredDonationsByDonor(User donor) {
        return donationRepo.countByDonorAndStatus(donor, "EXPIRED");
    }

    // ================= NGO FUNCTIONS =================

    public List<Donation> getDonationsByNgo(User ngo) {
        return donationRepo.findByNgo(ngo);
    }

    public List<Donation> getDonationsByStatusAndNgo(String status, User ngo) {
        return donationRepo.findByStatusAndNgo(status, ngo);
    }

    public void acceptDonation(Integer donationId, User ngo) {
        Optional<Donation> donationOpt = donationRepo.findById(donationId);

        if (donationOpt.isPresent()) {
            Donation donation = donationOpt.get();

            donation.setStatus("ACCEPTED");
            donation.setNgo(ngo);
            donationRepo.save(donation);

            // ✅ Generate Pickup OTP
            generatePickupOtp(String.valueOf(donationId));

            // Notification for donor
            Notification notification = new Notification(
                "Your donation '" + donation.getFoodName() +
                "' has been accepted by " + ngo.getOrganizationName(),
                donation.getDonor()
            );

            notificationRepo.save(notification);
        }
    }

    // ================= PICKUP OTP METHODS =================



    public void generatePickupOtp(String donationId) {

        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);

        long expiry = System.currentTimeMillis() + (5 * 60 * 1000);

        PickupOtpData data = new PickupOtpData(otp, expiry);

        pickupOtpStore.put(donationId, data);

        System.out.println("=================================");
        System.out.println("Pickup OTP for Donation ID " + donationId + " : " + otp);
        System.out.println("=================================");
    }
    public boolean verifyPickupOtp(String donationId, String enteredOtp) {

        PickupOtpData data = pickupOtpStore.get(donationId);

        if (data == null) {
            System.out.println("OTP NOT FOUND for Donation ID: " + donationId);
            return false;
        }

        // Check expiry
        if (System.currentTimeMillis() > data.getExpiry()) {
            pickupOtpStore.remove(donationId);
            System.out.println("OTP EXPIRED for Donation ID: " + donationId);
            return false;
        }

        // Check OTP
        if (data.getOtp().equals(enteredOtp)) {
            pickupOtpStore.remove(donationId);

           
            System.out.println("=================================");
            System.out.println(" OTP VERIFIED SUCCESSFULLY for Donation ID: " + donationId);
            System.out.println("=================================");

            return true;

        } else {
            data.incrementAttempts();

            System.out.println(" INVALID OTP for Donation ID: " + donationId +
                               " | Attempts: " + data.getAttempts());

            if (data.getAttempts() >= 3) {
                pickupOtpStore.remove(donationId);
                System.out.println(" OTP BLOCKED after 3 attempts for Donation ID: " + donationId);
            }

            return false;
        }
    }    public void markAsPickedUp(String donationId) {

        Donation donation = donationRepo.findById(Integer.parseInt(donationId))
                .orElseThrow(() -> new RuntimeException("Donation not found"));

        donation.setStatus("PICKED_UP");

        donationRepo.save(donation);
    }

    // ================= ADMIN DASHBOARD =================

    public long getTotalDonations() {
        return donationRepo.count();
    }

    public long getPendingRequestsCount() {
        return donationRepo.countByStatus("CREATED");
    }

    public long getAcceptedDonationsCount() {
        return donationRepo.countByStatus("ACCEPTED");
    }

    public long getExpiredDonationsCount() {
        return donationRepo.countByStatus("EXPIRED");
    }

    public long getCancelledDonationsCount() {
        return donationRepo.countByStatus("CANCELLED");
    }

    public List<Donation> getRecentDonations() {
        return donationRepo.findTop5ByOrderByDonationIdDesc();
    }

    // ================= ANALYTICS =================

    public Double getTotalFoodQuantity() {
        return donationRepo.sumQuantity();
    }

    public List<Object[]> getDonationStatusCounts() {
        return donationRepo.getDonationStatusCounts();
    }

    public List<Object[]> getMonthlyDonations() {
        return donationRepo.getMonthlyDonations();
    }
    
    public long getTotalUsers() {
        return repo.count();
    }

    public long getActiveNgoCount() {
        return repo.countByRoleAndStatus("NGO", "ACTIVE");
    }
    
    public void updateDonation(Donation donation) {
        donationRepo.save(donation);
    }
    
    public void cancelDonation(int id) {

        Donation donation = donationRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Donation not found"));

        donation.setStatus("CANCELLED");

        donationRepo.save(donation);
    }

    public List<Donation> getAllDonations() {
        return donationRepo.findAll();
    }

    public List<Donation> getAvailableDonations() {
        return donationRepo.findByStatusAndNgoIsNullAndExpiryTimeAfter(
            "CREATED",
            LocalDateTime.now()
        );
    }

    public Donation getDonationById(Integer id) {
        return donationRepo.findById(id).orElse(null);
    }

    public List<Donation> getDonationsForNgo(User ngo) {

        List<Donation> created = donationRepo.findByStatus("CREATED");

        List<Donation> accepted = donationRepo.findByNgoAndStatus(ngo, "ACCEPTED");

        created.addAll(accepted);

        return created;
    }
}