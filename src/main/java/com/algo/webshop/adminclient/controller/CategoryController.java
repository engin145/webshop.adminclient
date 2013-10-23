package com.algo.webshop.adminclient.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.algo.webshop.adminclient.category.Categorys;
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
	public String categoryStart() {
		return "category";
	}

	@RequestMapping(value = "/addCategory", method = RequestMethod.POST)
	public @ResponseBody String addCategory(@RequestParam String name) {
		Category category = new Category();
		category.setName(name);
		int id=service.addCategory(category);
		return ""+id;
	}
	
	@RequestMapping(value = "/deleteCategory", method = RequestMethod.POST)
	public @ResponseBody String delCategory(@RequestParam String id) {
		service.delCategory(Integer.parseInt(id));
		return "1";
	}
	
	@RequestMapping(value = "/renameCategory", method = RequestMethod.POST)
	public @ResponseBody String renCategory(@RequestParam String id, @RequestParam String name) {
		Category category = new Category();
		category.setId(Integer.parseInt(id));
		category.setName(name);
		service.updateCategory(category);
		return "1";
	}
	
	@RequestMapping(value = "/getCategorys", method = RequestMethod.POST)
	public @ResponseBody Categorys getCategorys() {
		List<Category> categoryList = service.getCategorys();
		Categorys categorys = new Categorys();
		categorys.setCategoryList(categoryList);
		return categorys;
	}
}