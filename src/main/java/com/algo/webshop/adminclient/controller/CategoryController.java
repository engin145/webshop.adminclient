package com.algo.webshop.adminclient.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.algo.webshop.common.domain.Category;
import com.algo.webshop.common.domainimpl.ICategory;

@Controller
public class CategoryController {
	private ICategory service;

	@Autowired
	public void setCategoryService(
			@Qualifier("categoryService") ICategory service) {
		this.service = service;
	}

	@RequestMapping("category")
	public ModelAndView category(Model model) {
		List<Category> categoryList = service.getCategorys();
		model.addAttribute("categoryList", categoryList);
		System.out.println("CategoryController.category()");
		return new ModelAndView("category");
	}

	@RequestMapping("addCategory")
	public ModelAndView addCategory(Model model,
			@RequestParam("nameCategory") String newCategory) {
		Category category = new Category();
		category.setName(newCategory);
		service.addCategory(category);
		List<Category> categoryList = service.getCategorys();
		model.addAttribute("categoryList", categoryList);
		System.out.println("CategoryController.addCategory()");
		return new ModelAndView("category");
	}

	@RequestMapping("deleteCategory")
	public ModelAndView delCategory(Model model,
			@RequestParam("categoryId") int categoryId) {
		service.delCategory(categoryId);
		List<Category> categoryList = service.getCategorys();
		model.addAttribute("categoryList", categoryList);
		System.out.println("CategoryController.delCategory()");
		return new ModelAndView("category");
	}

	@RequestMapping("renameCategory")
	public ModelAndView renCategory(Model model,
			@RequestParam("categoryId") int categoryId,
			@RequestParam("categoryName") String newName) {
		Category category = new Category();
		category.setId(categoryId);
		category.setName(newName);
		service.updateCategory(category);
		List<Category> categoryList = service.getCategorys();
		model.addAttribute("categoryList", categoryList);
		System.out.println("CategoryController.renCategory()");
		return new ModelAndView("category");
	}
}
