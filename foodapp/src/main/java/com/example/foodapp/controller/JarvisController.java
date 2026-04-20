package com.example.foodapp.controller;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.example.foodapp.service.JarvisService;

@Controller
public class JarvisController {

	@Autowired
	private JarvisService jarvisService;

	// 1️⃣ Page mapping for Ask Jarvis
	@GetMapping("/ask-jarvis-page")
	public String jarvisPage() {
		return "jarvis"; // jarvis.jsp inside /WEB-INF/views/
	}

	// 2️⃣ AJAX POST endpoint for chat
	@PostMapping("/ask-jarvis")
	@ResponseBody
	public String askJarvis(@RequestBody Map<String, String> request) {
		String message = request.get("message");
		return jarvisService.getResponse(message);
	}
}