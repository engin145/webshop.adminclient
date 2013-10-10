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
import com.algo.webshop.common.domain.Good;
import com.algo.webshop.common.domainimpl.ICategory;
import com.algo.webshop.common.domainimpl.IGood;

@Controller
public class GoodController {
	private IGood serviceGood;
	private ICategory serviceCategory;

	@Autowired
	public void setGoodService(@Qualifier("goodService") IGood serviceGood) {
		this.serviceGood = serviceGood;
	}

	@Autowired
	public void setCategoryService(
			@Qualifier("categoryService") ICategory serviceCategory) {
		this.serviceCategory = serviceCategory;
	}

//	@RequestMapping("good")
//	public ModelAndView category(Model model) {
//		List<Category> categoryList = serviceCategory.getCategorys();
//		model.addAttribute("categoryList", categoryList);
//		return new ModelAndView("good");
//	}

	@RequestMapping("good")
	public ModelAndView good22(Model model) {
		List<Category> categoryList = serviceCategory.getCategorys();
		model.addAttribute("categoryList", categoryList);
		List<Good> goodList = serviceGood.getGoods(2);
		model.addAttribute("goodList", goodList);
		model.addAttribute("massage", "good");
		System.out.println("good ");
		return new ModelAndView("good");
	}
	
	@RequestMapping("goodSelect")
	public ModelAndView goodSelect(Model model,
			@RequestParam("categoryId") int categoryId) {
		List<Category> categoryList2 = serviceCategory.getCategorys();
		model.addAttribute("categoryList", categoryList2);
		List<Good> goodList2 = serviceGood.getGoods(categoryId);
		model.addAttribute("goodList", goodList2);
		System.out.println("goodSelect ");
		return new ModelAndView("good");
	}

}
