package com.algo.webshop.client.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DispatcherServlet{
	
	@RequestMapping({"/","/index"})
	public String index(){
		return "index";
	}
	
	@RequestMapping("good")
	public String good(){
		return "good";
	}
	
	
}
