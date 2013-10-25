package com.algo.webshop.adminclient.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.algo.webshop.common.domainimpl.IUserSystem;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	private IUserSystem userSystemService;
	
	@Autowired
	public void setUserSystemService(@Qualifier("userSystemService") IUserSystem service) {
		this.userSystemService = service;
	}
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		return userSystemService.getUserSystemByName(username);
	}

}
