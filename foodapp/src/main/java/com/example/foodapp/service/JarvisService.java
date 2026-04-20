package com.example.foodapp.service;

import org.springframework.stereotype.Service;

@Service
public class JarvisService {

    public String getResponse(String message){

        message = message.toLowerCase();

        
        // General Greetings
       
        if(message.contains("hello") || message.contains("hi") || message.contains("hey"))
            return "Hello! I'm Jarvis, your assistant. How can I help you today?";

        if(message.contains("thank"))
            return "You're welcome! Happy to help.";

        if(message.contains("help"))
            return "You can ask me about adding donations, checking donation status, managing your profile, or viewing NGO information.";

        // ------------------------------
        // Donor Actions
        // ------------------------------
        if(message.contains("donate food") || message.contains("add donation"))
            return "To donate food, go to 'Add Surplus Food', fill in the details like food type, quantity, pickup time, and submit.";

        if(message.contains("my donations") || message.contains("view donations") || message.contains("manage donations"))
            return "You can view or manage your donations under 'Manage Donations'. You can also update or delete pending donations.";

        if(message.contains("donation status") || message.contains("status of donation") || message.contains("check donation"))
            return "Check the status of your donations under 'Donation Status'. It shows if your donation is accepted, pending, or expired.";

        if(message.contains("profile") || message.contains("account") || message.contains("settings"))
            return "You can update your profile, change your password, or manage your settings under 'Profile'.";

        if(message.contains("logout") || message.contains("sign out"))
            return "To logout, click the 'Logout' button in the sidebar.";

        // ------------------------------
        // NGO Actions (if donor asks about NGOs)
        // ------------------------------
        if(message.contains("ngo") || message.contains("ngos") || message.contains("view ngo") || message.contains("list ngo"))
            return "NGOs can view available donations in their dashboard. You can also search for NGOs by location or type.";

        if(message.contains("accept donation") || message.contains("claim donation"))
            return "NGOs can accept a donation by clicking the 'Accept' button on available donations in their dashboard.";

        if(message.contains("ngo profile"))
            return "NGOs can manage their profile and contact details in the 'Profile' section of their dashboard.";


        // Food Availability & Search

        if(message.contains("available food") || message.contains("search food") || message.contains("available donations"))
            return "You can search for available surplus food in the dashboard by location or food type.";

        if(message.contains("expired") || message.contains("past donations"))
            return "Expired or past donations can be viewed under 'Donation Status'. You cannot modify expired donations.";


        // Default fallback

        return "Sorry, I didn't understand that. You can ask me about donations, donation status, managing your profile, or NGO actions.";
    }
}