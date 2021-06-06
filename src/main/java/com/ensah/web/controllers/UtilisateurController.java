package com.ensah.web.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ensah.core.services.IUtilisateurService;

@Controller

@RequestMapping("admin")
public class UtilisateurController {
	
	@Autowired
	IUtilisateurService UserSer;
	
	
}
