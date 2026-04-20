package com.example.foodapp.model;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "donations")
public class Donation {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer donationId;

	private String foodName;
	private String foodType;
	private Integer quantity;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private java.time.LocalDate preparedDate;

	@DateTimeFormat(pattern = "HH:mm")
	private java.time.LocalTime preparedTime;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private java.time.LocalDate expiryDate;

	@DateTimeFormat(pattern = "HH:mm")
	private java.time.LocalTime expiryTime;

	private String pickupAddress;

	private String contactPerson;
	private String contactNumber;

	private String status = "CREATED"; // CREATED, ACCEPTED, PICKED_UP, COMPLETED, EXPIRED

	@ManyToOne
	@JoinColumn(name = "ngo_id")
	private User ngo;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User donor;

	@Column(nullable = true)
	private Double latitude;

	@Column(nullable = true)
	private Double longitude;
	@Column(name = "volunteer_name")
	private String volunteerName;

	@Column(name = "vehicle_number")
	private String vehicleNumber;

	@Column(name = "food_condition")
	private String foodCondition;

	@Column(name = "pickup_remarks")
	private String pickupRemarks;

	@Column(name = "actual_pickup_time")
	private LocalDateTime actualPickupTime;

	public String getVolunteerName() {
		return volunteerName;
	}

	public void setVolunteerName(String volunteerName) {
		this.volunteerName = volunteerName;
	}

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}

	public String getFoodCondition() {
		return foodCondition;
	}

	public void setFoodCondition(String foodCondition) {
		this.foodCondition = foodCondition;
	}

	public String getPickupRemarks() {
		return pickupRemarks;
	}

	public void setPickupRemarks(String pickupRemarks) {
		this.pickupRemarks = pickupRemarks;
	}

	public LocalDateTime getActualPickupTime() {
		return actualPickupTime;
	}

	public void setActualPickupTime(LocalDateTime actualPickupTime) {
		this.actualPickupTime = actualPickupTime;
	}

	public Donation() {
	}

	// -----------------------
	// Getters & Setters
	// -----------------------
	public Integer getDonationId() {
		return donationId;
	}

	public void setDonationId(Integer donationId) {
		this.donationId = donationId;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getFoodType() {
		return foodType;
	}

	public void setFoodType(String foodType) {
		this.foodType = foodType;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public LocalDate getPreparedDate() {
		return preparedDate;
	}

	public void setPreparedDate(LocalDate preparedDate) {
		this.preparedDate = preparedDate;
	}

	public LocalTime getPreparedTime() {
		return preparedTime;
	}

	public void setPreparedTime(LocalTime preparedTime) {
		this.preparedTime = preparedTime;
	}

	public LocalDate getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(LocalDate expiryDate) {
		this.expiryDate = expiryDate;
	}

	public LocalTime getExpiryTime() {
		return expiryTime;
	}

	public void setExpiryTime(LocalTime expiryTime) {
		this.expiryTime = expiryTime;
	}

	public String getPickupAddress() {
		return pickupAddress;
	}

	public void setPickupAddress(String pickupAddress) {
		this.pickupAddress = pickupAddress;
	}

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public User getNgo() {
		return ngo;
	}

	public void setNgo(User ngo) {
		this.ngo = ngo;
	}

	public User getDonor() {
		return donor;
	}

	public void setDonor(User donor) {
		this.donor = donor;
	}

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	@Column(length = 500) // optional, adjust as needed
	private String remarks;

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Donation orElseThrow(Object object) {
		// TODO Auto-generated method stub
		return null;
	}

	public Donation orElse(Object object) {
		// TODO Auto-generated method stub
		return null;
	}
}