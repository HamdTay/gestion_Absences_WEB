package com.ensah.web.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

	@Autowired
	PasswordEncoder pd;
	
	@GetMapping("/login")
	public String showLogin() {
		return "login";
	}
	
}
