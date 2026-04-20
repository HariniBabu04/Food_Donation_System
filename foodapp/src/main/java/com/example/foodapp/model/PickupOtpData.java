package com.example.foodapp.model;

public class PickupOtpData {

    private String otp;
    private long expiry;
    private int attempts;

    public PickupOtpData(String otp, long expiry) {
        this.otp = otp;
        this.expiry = expiry;
        this.attempts = 0;
    }

    public String getOtp() {
        return otp;
    }

    public long getExpiry() {
        return expiry;
    }

    public int getAttempts() {
        return attempts;
    }

    public void incrementAttempts() {
        this.attempts++;
    }
}