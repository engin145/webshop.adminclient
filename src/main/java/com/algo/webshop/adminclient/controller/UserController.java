package com.algo.webshop.adminclient.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.algo.webshop.common.domain.User;
import com.algo.webshop.common.domainimpl.IUser;

@Controller
public class UserController {
	private IUser serviceUser;
	
	@Autowired
	public void setUserService(@Qualifier("userService") IUser service) {
		this.serviceUser = service;
	}
	
	@RequestMapping("user")
	public ModelAndView userStart(Model model) {
		List<User> userList = serviceUser.getAllUsers();
		model.addAttribute("userList", userList);
		return new ModelAndView ("user");
	}
	
	@RequestMapping(value = "/userOrders", method = RequestMethod.GET)
	public ModelAndView userOrders(Model model, @RequestParam("id") int userId) {
		System.out.println("UserController.userOrders()"+userId);
		//List<Order> orderList = 
		
		return new ModelAndView ("userOrders");
	}
	
}
