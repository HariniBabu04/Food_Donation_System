package com.example.foodapp.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.foodapp.model.Donation;
import com.example.foodapp.model.User;

public interface DonationRepository extends JpaRepository<Donation, Integer> {
    List<Donation> findByStatus(String status);
    List<Donation> findByNgo(User ngo);
    List<Donation> findByDonor(User donor);
    List<Donation> findByStatusAndNgo(String status, User ngo);
    
    long countByStatus(String status);

    List<Donation> findTop5ByOrderByDonationIdDesc();
    
    // Search donations by city and status
    List<Donation> findByPickupAddressContainingAndStatus(String city, String status);
    @Query("SELECT SUM(d.quantity) FROM Donation d")
    Double sumQuantity();
   
    @Query("SELECT MONTH(d.preparedDate), COUNT(d) FROM Donation d GROUP BY MONTH(d.preparedDate)")
    List<Object[]> getMonthlyDonations();
    @Query("SELECT d.status, COUNT(d) FROM Donation d GROUP BY d.status")
    List<Object[]> getDonationStatusCounts();
    
    long countByDonor(User donor);

    long countByDonorAndStatus(User donor, String status);
    
    List<Donation> findByStatusIgnoreCase(String status);
    List<Donation> findByStatusAndNgoIsNullAndExpiryTimeAfter(
    	    String status,
    	    LocalDateTime time
    	);
    


    List<Donation> findByNgoAndStatus(User ngo, String status);
    
}
