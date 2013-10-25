package com.algo.webshop.client.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.algo.webshop.common.domain.Category;
import com.algo.webshop.common.domainimpl.ICategory;

@Controller
public class CategoryController {
	private ICategory service;

	@Autowired
	public void setCategoryService(@Qualifier("categoryService") ICategory service) {
		this.service = service;
	}
	
	@RequestMapping("category")
	public ModelAndView category(Model model){
		List<Category> categoryList=service.getCategorys();
		model.addAttribute("categoryList", categoryList);
		return new ModelAndView("category");
	}
	
	
}
