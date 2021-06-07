package com.ensah.web.controllers;

import javax.validation.Valid;

import org.hibernate.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.Etudiant;
import com.ensah.core.bo.Utilisateur;
import com.ensah.core.services.IUtilisateurService;
import com.ensah.web.models.TestModel;
import com.ensah.web.models.UserModel;

//@Controller
@RestController
@RequestMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
//@RequestMapping("admin")
public class UtilisateurController {
	
	@Autowired
	IUtilisateurService UserSer;
	
	//@RequestMapping(value="createUser",  method = RequestMethod.POST,consumes="application/json",headers = "content-type=application/x-www-form-urlencoded")
	@PostMapping(value="createUser", consumes = { MediaType.ALL_VALUE })
	public UserModel createUser(@Valid UserModel user, BindingResult bindingResult, Model model) {
		String[] string =  null;
		
		System.out.println("inside userController: "/*+user.getTypePerson()*/);
		
		Utilisateur util = new Etudiant();
		
		//UserSer.addPerson(util);
		
		if(bindingResult.hasErrors()) {
			//converting errors to string for the purpose of returing error in json format 
			//string =  (String[])bindingResult.getAllErrors().toArray();
			
			System.out.println("we have errors:" + bindingResult.getAllErrors().get(0).getCode());
		}
		
		//System.out.println(string.toString());
		
		//for the roles
		/*
		if() {
			
		}else if() {
			
		}else {
			
		}
		*/
		return user;

		
	}
	
    @GetMapping(value = "/hello")
    public String helloBoy(@RequestParam String name) {
        return "Hello, " + name;
    }
	
	
}
