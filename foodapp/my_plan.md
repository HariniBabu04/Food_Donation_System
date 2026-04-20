# 1. Project Overview

The Food Donation Management System allows donors to donate surplus food and NGOs to collect it before expiry.

The system should implement a **simple but complete workflow suitable for a college project**.

The project uses:

- Java
- Spring Boot
- Spring MVC
- JSP
- Spring Data JPA
- MySQL
- Optional Python automation for expiry monitoring

---

# 2. Technology Stack

Backend

- Java
- Spring Boot
- Spring MVC
- Spring Data JPA

Frontend

- JSP
- HTML
- CSS
- JavaScript

Database

- MySQL

Automation (Optional Advanced Feature)

- Python Worker Script

Build Tool

- Maven

---

# 3. System Roles

The application should support three user roles.

## Admin

Responsibilities

- manage users
- monitor donations
- remove invalid data
- approve NGOs (optional)

## Donor

Responsibilities

- create food donations
- view donation status
- update profile

## NGO

Responsibilities

- view available donations
- accept donation
- update pickup status

---

# 4. Core Modules

The project should be divided into the following modules.

## 4.1 Authentication Module

Purpose

Allow users to register and login.

Features

- user registration
- user login
- logout
- role selection
- password encryption

Database Table

users

Fields

- id
- name
- email
- password
- role
- created_at

Implementation

- AuthController
- AuthService
- UserRepository

Security

Passwords must be encrypted using BCrypt.

Example

```
BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
String encodedPassword = encoder.encode(password);
```

---

# 4.2 Donation Module

Purpose

Allow donors to donate food.

Features

- create donation
- edit donation
- view donation
- track donation status

Database Table

donations

Fields

- id
- title
- description
- food_type
- quantity
- expiry_time
- donor_id
- ngo_id
- status
- created_at

Donation Status Values

- CREATED
- ACCEPTED
- PICKED_UP
- COMPLETED
- EXPIRED

Implementation Classes

- DonationController
- DonationService
- DonationRepository

---

# 4.3 NGO Module

Purpose

Allow NGOs to collect available donations.

Features

- view available donations
- accept donation
- update pickup status

Example Workflow

Donor creates donation  
→ NGO sees available donation  
→ NGO accepts donation  
→ NGO picks up donation

---

# 4.4 Admin Module

Admin should be able to monitor the system.

Features

- view all users
- view all donations
- remove incorrect entries

Admin Dashboard

Display

- total users
- total donations
- active donations
- expired donations

---

# 4.5 Notification Module

Basic notification system.

Database Table

notifications

Fields

- id
- user_id
- message
- status
- created_at

Example Messages

- "Your donation was accepted"
- "Your donation expired"
- "New food donation available"

Notifications can be shown inside the dashboard.

---

# 5. Donation Expiry Automation

Food donations should automatically expire if not accepted before expiry time.

Example

Donation created at 12:00 PM  
Expiry time 6:00 PM

If current time > expiry time

Status should change to

EXPIRED

---

# 6. Recommended Expiry Implementation

Use Spring Boot scheduler.

Implementation

```
@Scheduled(fixedRate = 60000)
public void checkExpiredDonations() {

    List<Donation> expired = donationRepository.findExpired();

    for(Donation donation : expired){
        donation.setStatus("EXPIRED");
        donationRepository.save(donation);
    }
}
```

Runs every 1 minute.

---

# 7. Optional Advanced Feature (Python Automation)

To demonstrate cross-language integration, a Python script can monitor donation expiry.

Architecture

Spring Boot Application  
↓  
REST API  
↓  
Python Worker Script

Python can

- check expired donations
- send notifications
- call Spring Boot API

---

# 8. Python Expiry Worker Example

Python script example

```
import requests
import datetime

response = requests.get("http://localhost:8080/api/donations")

for donation in response.json():

    expiry = donation["expiry_time"]

    if expiry < datetime.datetime.now():

        requests.post(
            f"http://localhost:8080/api/donation/{donation['id']}/expire"
        )
```

Python can run using cron every few minutes.

---

# 9. Project Architecture

System architecture

```
Browser (JSP Frontend)
        │
        ▼
Spring Boot MVC
        │
        ├── Authentication Module
        ├── Donation Module
        ├── NGO Module
        ├── Admin Module
        └── Notification Module
        │
        ▼
MySQL Database
        │
        ▼
Python Worker (Optional)
Expiry Monitoring + Notifications
```

---

# 10. Project Implementation Phases

The system should be implemented in phases.

---

## Phase 1 Authentication

Implement

- user registration
- login
- logout
- password encryption

Deliverables

- AuthController
- AuthService
- UserRepository

---

## Phase 2 Role System

Implement

- donor role
- NGO role
- admin role

Add role based routing.

---

## Phase 3 Donation System

Implement

- create donation
- view donation
- accept donation
- update donation status

---

## Phase 4 Admin Dashboard

Implement

- user management
- donation monitoring

---

## Phase 5 Notification System

Implement

- notification table
- notification creation
- notification display in dashboard

---

## Phase 6 Expiry Automation

Implement

- expiry scheduler
- expired donation update
- expired notification

---

## Phase 7 Optional Python Integration

Implement

- python worker
- expiry monitoring
- notification sending

---

# 11. Expected Final Features

The final project should support

- user authentication
- role based access
- donation creation
- donation pickup workflow
- automatic expiry detection
- notifications
- simple admin dashboard

---

# 12. Future Improvements (Optional)

Future improvements can include

- mobile application
- Google Maps integration
- food pickup routing
- AI based food demand prediction
- SMS notifications

---

# End of Implementation Guide
