package com.ensah.web.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.services.ICompteService;
import com.ensah.core.services.IJournalisationEvenementsService;
import com.ensah.core.services.IUtilisateurService;
import com.ensah.web.models.AccountGestionModel;
import com.ensah.web.models.AccountModel;
import com.ensah.web.models.LogModel;
import com.ensah.core.bo.Compte;
import com.ensah.core.bo.JournalisationEvenements;

@RestController
@RequestMapping("admin")
public class AccountController {

	@Autowired
	ICompteService accountSer;
	
	@Autowired
	IUtilisateurService UserSer;
	
	@Autowired
	IJournalisationEvenementsService logSer;
	
	@PostMapping(value="createAccount", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public String createAccount(AccountModel account) {
		
		String password = accountSer.createAccount(account.getRoleId(), account.getPersonId());
		System.out.println("Password:" + password);
		return password;
	}
	
	@GetMapping(value="getAccounts", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<AccountGestionModel> getAccounts(){

		
		List<Compte> accounts = accountSer.getAllAccounts();
		accounts.get(0).getProprietaire();
		List<AccountGestionModel> accountReturned= new ArrayList<>(); 
		
		for(int i=0; i<accounts.size(); ++i) {
			
			AccountGestionModel am = new AccountGestionModel();
			BeanUtils.copyProperties(accounts.get(i), am);
			am.setNomRole(accounts.get(i).getRole().getNomRole());
			am.setEmail(accounts.get(i).getProprietaire().getEmail());
			
			accountReturned.add(am);
			
		}
		
		return accountReturned;
	}
	
	
	@PostMapping(value="changePassword/{password}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public AccountModel changePassword(AccountModel account) {
				
		accountSer.changePassword(account.getPersonId(), account.getPassword());
		
		return account;
		
	}
	
	@GetMapping(value="resetPassword/{idCompte}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public String resetPassword(@PathVariable("idCompte")Long idCompte) {
		
		return accountSer.resetPassword(idCompte);
		
	}
	
	
	@PostMapping(value="updateAccount", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public AccountModel updateAccount(AccountModel acc) {
		
		accountSer.updateAccount(acc.getUsername(), acc.getPassword(), acc.getRoleId(), acc.getPersonId());
		
		return acc;
		
	}
	
	
	@GetMapping(value="DeactivateAccount/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public void DeactivateAccount(@PathVariable("id") String id) {
		accountSer.deactivate(id);
	}
	
	@GetMapping(value="ActivateAccount/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public void ActivateAccount(@PathVariable("id") String id) {
		accountSer.activate(id);
	}
	
	@GetMapping(value="LogLogin/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<LogModel> LogLogin(@PathVariable("id")Long id, HttpServletRequest rq){
		logSer.addLog(getUserName(), rq.getRemoteAddr(), "preview logs", "TRACE", getUserName() + " is checking the login logs of accountId: "+id);
		List<LogModel> logModel = new ArrayList<>();
		List<JournalisationEvenements> logArr= logSer.getLoginLogs(id);
		for(JournalisationEvenements journal : logArr) {
			LogModel lm = new LogModel();
			BeanUtils.copyProperties(journal, lm);
			logModel.add(lm);
		}
		return logModel;
	}
	
	@GetMapping(value="LogActivity/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<LogModel> LogActivity(@PathVariable("id")Long id, HttpServletRequest rq){
		
		logSer.addLog(getUserName(), rq.getRemoteAddr(), "preview logs -a", "TRACE", getUserName() + " is checking the logs of accountId: "+id);
		List<LogModel> logModel = new ArrayList<>();
		List<JournalisationEvenements> logArr= logSer.getAllLogsOfUser(id);
		for(JournalisationEvenements journal : logArr) {
			LogModel lm = new LogModel();
			BeanUtils.copyProperties(journal, lm);
			logModel.add(lm);
		}
		return logModel;
	}
	
	public String getUserName() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String username = "";
		
		if (principal instanceof UserDetails) {
		  username = ((UserDetails)principal).getUsername();
		} else {
		  username = principal.toString();
		}
		return username;
	}
	
}
