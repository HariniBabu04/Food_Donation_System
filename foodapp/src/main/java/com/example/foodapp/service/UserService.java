package com.example.foodapp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.foodapp.model.User;
import com.example.foodapp.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository repo;

	private final org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder passwordEncoder = new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder();

	// LOGIN
	public User authenticateUser(String email, String password) {

		email = email.trim().toLowerCase(); 

		User existingUser = repo.findByEmail(email);

		if (existingUser != null && passwordEncoder.matches(password, existingUser.getPassword())) {
			return existingUser;
		}
		return null;
	}

	// REGISTER
	public boolean registerUser(User user) {

		String email = user.getEmail().trim().toLowerCase(); 
		user.setEmail(email);

		if (repo.existsByEmailIgnoreCase(email)) { 
			return false;
		}

		user.setPassword(passwordEncoder.encode(user.getPassword()));
		repo.save(user);
		return true;
	}

	// NEW: fetch user by email
	public User findByEmail(String email) {
		return repo.findByEmail(email);
	}

	// OPTIONAL: update user
	public void updateUser(User user) {
		repo.save(user); // persist changes
	}

	public long getTotalUsers() {
		return repo.count();
	}

	public long countByRole(String role) {
		return repo.countByRoleIgnoreCase(role);
	}

	public long getActiveNGOsCount() {
		return repo.countByRoleIgnoreCase("NGO");
	}
	
	public User getUserById(int id) {
	    return repo.findById(id).orElse(null);
	}

}