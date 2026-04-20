# Implementation Tracker - Surplus Food Donation App

## Phase 1: Authentication & Basic Security
- [x] Implement User Registration (Donor, NGO, Volunteer) <!-- id: p1_1 -->
- [x] Implement User Login with Role-based redirection <!-- id: p1_2 -->
- [x] Secure password storage using BCrypt <!-- id: p1_3 -->

## Phase 2: Role-Based System
- [x] Configure "NGO" and "Donor" specific dashboards <!-- id: p2_1 -->
- [x] Protect routes using Session Interceptor/Security Configuration <!-- id: p2_2 -->

## Phase 3: Donation Lifecycle
- [x] Track donation status (`CREATED`, `ACCEPTED`, `EXPIRED`, `PICKED`) <!-- id: p3_1 -->
- [x] Enable NGOs to view only available donations <!-- id: p3_2 -->
- [x] Implement "Accept Donation" logic in `DonationService` <!-- id: p3_3 -->

## Phase 4: Admin & NGO Dashboards
- [x] Create NGO "Search Food" dynamic view <!-- id: p4_1 -->
- [x] Create Admin "User Management" CRUD <!-- id: p4_2 -->

## Phase 5: Notification System
- [x] Create `notifications` table and model <!-- id: p5_1 -->
- [x] Develop in-app alert logic <!-- id: p5_2 -->

## Phase 6: Python Expiry Worker
- [x] Create Python script for expiry check <!-- id: p6_1 -->
- [x] Schedule background automation <!-- id: p6_2 -->
