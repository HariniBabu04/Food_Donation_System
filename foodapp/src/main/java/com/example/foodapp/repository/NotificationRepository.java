package com.example.foodapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.foodapp.model.Notification;
import com.example.foodapp.model.User;
import java.util.List;

public interface NotificationRepository extends JpaRepository<Notification, Integer> {
    List<Notification> findByUserOrderByTimestampDesc(User user);
    List<Notification> findByUserAndIsReadFalse(User user);
    List<Notification> findTop5ByOrderByNotifyIdDesc();
    
}
