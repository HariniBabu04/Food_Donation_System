package com.example.foodapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.foodapp.model.User;

public interface UserRepository extends JpaRepository<User,Integer> {
	   User findByEmail(String email);
	   long countByRole(String role);
	   long countByRoleIgnoreCase(String role);
	   boolean existsByEmailIgnoreCase(String email);
	   long countByRoleAndStatus(String role, String status);
	   
}