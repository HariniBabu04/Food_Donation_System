# Project Workflow & Structure: Food Donation Application

## Project Overview
This application is a **Food Donation Management System** designed to bridge the gap between food donors (individuals/restaurants) and NGOs. It is built using a Java-based Spring Boot stack with JSP/JSTL for the frontend and MySQL for data persistence.

## 1. Project Workflow
The application follows a role-based access control (RBAC) model with three primary roles: **Donor**, **NGO**, and **Admin**.

### Core Flow:
1.  **Registration & Login**:
    -   Users register via `/register` with their role (DONOR/NGO/ADMIN).
    -   Common login is handled at `/login`, which redirects users to their specific dashboard based on their role stored in the session.
2.  **Donor Workspace**:
    -   **Add Donation**: Donors use `/addSurplusfood` to list available food items (name, quantity, expiry time, address).
    -   **Manage Donations**: View and edit own donations via `/manageDonation`.
3.  **NGO Workspace**:
    -   **Search Food**: NGOs browse available food in their vicinity using `/search-food`.
    -   **Accept & Pickup**: NGOs can claim a donation via `/acceptDonation` and manage the logistics through `/pickup`.
    -   **Location View**: NGOs can visualize donation points on a map using `/view-map`.
4.  **Admin Workspace**:
    -   **User Management**: Admins can view/edit/delete users via `/manageUsers`.
    -   **System Oversight**: Monitor all donations and system activities via `/manageDonation-admin` and `/reports-analytics`.

---

## 2. Routing Logic
The routing is centralized in `AuthController.java` using Spring MVC's `@Controller` and `@RequestMapping` (via `@GetMapping` and `@PostMapping`).

| Route | Method | Purpose | View (JSP) |
|---|---|---|---|
| `/` | GET | Home Landing Page | `home.jsp` |
| `/login` | GET/POST | Authentication (Session-based) | `login.jsp` |
| `/register` | GET/POST | User Account Creation | `register.jsp` |
| `/donor-dashboard` | GET | Donor Landing Page | `donor-dashboard.jsp` |
| `/ngo-dashboard` | GET | NGO Landing Page | `ngo-dashboard.jsp` |
| `/admin-dashboard` | GET | Admin Landing Page | `admin-dashboard.jsp` |
| `/addSurplusfood` | GET/POST | Create a new food donation | `addSurplusfood.jsp` |
| `/manageDonation` | GET | List/Edit donor's donations | `manageDonation.jsp` |
| `/viewDonation` | GET | NGO view of available food | `viewDonation.jsp` |
| `/search-food` | GET | Search functionality for NGOs | `search-food.jsp` |
| `/view-map` | GET | Map visualization of donations | `view-map.jsp` |
| `/manageUsers` | GET | Admin user control panel | `manageUsers.jsp` |
| `/reports-analytics` | GET | System-wide statistics | `reports-analytics.jsp` |

---

## 3. Integrations Analysis

### Mandatory Integrations (Core Stack)
-   **Spring Boot (4.0.3)**: Provides the application's skeletal framework, dependency injection, and embedded server.
-   **Spring Data JPA**: Automates the data access layer using ORM mapping to MySQL.
-   **MySQL Connector**: Enables connectivity to the `foodapp02` database.
-   **JSTL & Tomcat Jasper**: Mandatory for rendering dynamic server-side pages using JSP templates.
-   **Jakarta Servlet**: The underlying web engine for handling HTTP requests.

### Optional / External Integrations (Third-Party)
-   **Google Maps API**: Integrated in `/WEB-INF/common/footer.jsp` for location-based food tracking (`/view-map`).
-   **Chart.js**: Integrated for data visualization in the Admin dashboard (`/reports-analytics`).
-   **Bootstrap 5.3 & Bootstrap Icons**: Used for modern, responsive UI components.
-   **Font Awesome**: Integrated via CDN for additional UI iconography.

---

## 4. Current Project Directory Structure
```text
foodapp/
├── pom.xml                     # Maven Dependencies (Spring Boot, JPA, MySQL, JSTL)
├── src/
│   ├── main/
│   │   ├── java/com/example/foodapp/
│   │   │   ├── FoodappApplication.java   # Spring Boot Entry Point
│   │   │   ├── controller/               # AuthController (Routing)
│   │   │   ├── model/                    # Entities: User, Donation
│   │   │   ├── repository/               # Data Access: UserRepository, DonationRepository
│   │   │   └── service/                  # Business Logic: UserService, DonationService
│   │   ├── resources/
│   │   │   ├── application.properties    # Configuration: Port 8089, DB URL, View Prefix
│   │   │   ├── static/                   # Static assets (CSS, JS)
│   │   │   └── templates/                # (Unused in favor of webapp/jsp)
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           ├── common/               # Shared Fragments: header.jsp, footer.jsp, sidebar
│   │           └── views/                # Frontend Screens (25+ JSP files)
└── target/                      # Build Artifacts
```
