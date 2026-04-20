	package com.example.foodapp.model;
	
	import jakarta.persistence.*;
	import java.time.LocalDateTime;
	
	@Entity
	@Table(name = "notifications")
	public class Notification {
	
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Integer notifyId;
	
	    private String message;
	
	    @ManyToOne
	    @JoinColumn(name = "user_id")
	    private User user;
	
	    private boolean isRead = false;
	
	    private LocalDateTime timestamp = LocalDateTime.now();
	
	    public Notification() {}
	
	    public Notification(String message, User user) {
	        this.message = message;
	        this.user = user;
	    }
	
	    // Getters and Setters
	    public Integer getNotifyId() { return notifyId; }
	    public void setNotifyId(Integer notifyId) { this.notifyId = notifyId; }
	
	    public String getMessage() { return message; }
	    public void setMessage(String message) { this.message = message; }
	
	    public User getUser() { return user; }
	    public void setUser(User user) { this.user = user; }
	
	    public boolean isRead() { return isRead; }
	    public void setRead(boolean read) { isRead = read; }
	
	    public LocalDateTime getTimestamp() { return timestamp; }
	    public void setTimestamp(LocalDateTime timestamp) { this.timestamp = timestamp; }
	}
