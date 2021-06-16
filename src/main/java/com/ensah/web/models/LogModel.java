package com.ensah.web.models;

import java.util.Date;

public class LogModel {
	private String details;
	private String adresseIP;
	private String typeEvenement;
	private String criticite;
	private Date DateHeure;
	public Date getDateHeure() {
		return DateHeure;
	}
	public void setDateHeure(Date dateHeure) {
		DateHeure = dateHeure;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getAdresseIP() {
		return adresseIP;
	}
	public void setAdresseIP(String adresseIP) {
		this.adresseIP = adresseIP;
	}
	public String getTypeEvenement() {
		return typeEvenement;
	}
	public void setTypeEvenement(String typeEvenement) {
		this.typeEvenement = typeEvenement;
	}
	public String getCriticite() {
		return criticite;
	}
	public void setCriticite(String criticite) {
		this.criticite = criticite;
	}
	@Override
	public String toString() {
		return "LogModel [details=" + details + ", adresseIP=" + adresseIP + ", typeEvenement=" + typeEvenement
				+ ", criticite=" + criticite + ", DateHeure=" + DateHeure + "]";
	}
	
	
}
