package com.algo.webshop.adminclient.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.algo.webshop.adminclient.good.GoodFull;
import com.algo.webshop.adminclient.good.Goods;
import com.algo.webshop.common.domain.Category;
import com.algo.webshop.common.domain.Good;
import com.algo.webshop.common.domain.Manufacturer;
import com.algo.webshop.common.domain.Price;
import com.algo.webshop.common.domain.Unit;
import com.algo.webshop.common.domainimpl.ICategory;
import com.algo.webshop.common.domainimpl.IGood;
import com.algo.webshop.common.domainimpl.IManufacturer;
import com.algo.webshop.common.domainimpl.IPrice;
import com.algo.webshop.common.domainimpl.IUnit;

@Controller
public class GoodController {
	private IGood serviceGood;
	private ICategory serviceCategory;
	private IManufacturer serviceManufacturer;
	private IUnit serviceUnit;
	private IPrice servicePrice;

	@Autowired
	public void setGoodService(@Qualifier("goodService") IGood service) {
		this.serviceGood = service;
	}

	@Autowired
	public void setCategoryService(
			@Qualifier("categoryService") ICategory service) {
		this.serviceCategory = service;
	}

	@Autowired
	public void setManufacturerService(
			@Qualifier("manufacturerService") IManufacturer service) {
		this.serviceManufacturer = service;
	}

	@Autowired
	public void setUnitService(@Qualifier("unitService") IUnit service) {
		this.serviceUnit = service;
	}

	@Autowired
	public void setPriceService(@Qualifier("priceService") IPrice service) {
		this.servicePrice = service;
	}

	@RequestMapping("good")
	public ModelAndView goodStart(Model model) {
		// Category
		List<Category> categoryList = serviceCategory.getCategorys();
		Map<Integer, String> categoryMap = new HashMap<Integer, String>();
		for (Category category : categoryList) {
			categoryMap.put(category.getId(), category.getName());
		}
		model.addAttribute("categoryMap", categoryMap);

		// Manufacturer
		List<Manufacturer> manufacturerList = serviceManufacturer
				.getManufacturers();
		Map<Integer, String> manufacturerMap = new HashMap<Integer, String>();
		for (Manufacturer manufacturer : manufacturerList) {
			manufacturerMap.put(manufacturer.getId(), manufacturer.getName());
		}
		model.addAttribute("manufacturerMap", manufacturerMap);

		// unit
		List<Unit> unitList = serviceUnit.getUnits();
		Map<Integer, String> unitMap = new HashMap<Integer, String>();
		for (Unit unit : unitList) {
			unitMap.put(unit.getId(), unit.getName());
		}
		model.addAttribute("unitMap", unitMap);

		return new ModelAndView("good");
	}

	@RequestMapping(value = "/getGoods", method = RequestMethod.POST)
	public @ResponseBody
	Goods getCategorys(@RequestParam String categoryId,
			@RequestParam String manufacturerId,
			@RequestParam String minAmount, @RequestParam String maxAmount) {
		Goods goods = new Goods();

		// get goods
		List<Good> goodList = serviceGood.getGoodsSelect(
				Integer.parseInt(categoryId), Integer.parseInt(manufacturerId),
				Integer.parseInt(minAmount), Integer.parseInt(maxAmount));

		// get Prices
		List<Price> priceList = servicePrice.getMaxDateAllPrice();
		Map<Integer, Float> priceMap = new HashMap<Integer, Float>();
		for (Price price : priceList) {
			priceMap.put(price.getGoodId(), price.getValue());
		}

		List<GoodFull> goodsPrice = new ArrayList<GoodFull>(goodList.size());
		GoodFull goodPrice;
		float priceValue;
		for (Good good : goodList) {
			if (priceMap.get(good.getId()) != null)
				priceValue = priceMap.get(good.getId());
			else
				priceValue = 0;
			goodPrice = new GoodFull(good, priceValue);
			goodsPrice.add(goodPrice);
		}
		goods.setGoods(goodsPrice);

		return goods;
	}

	@RequestMapping("newGood")
	public ModelAndView newGood(Model model) {
		List<Category> categoryList = serviceCategory.getCategorys();
		Map<Integer, String> categoryMap = new HashMap<Integer, String>();
		for (Category category : categoryList) {
			categoryMap.put(category.getId(), category.getName());
		}
		model.addAttribute("categoryMap", categoryMap);

		List<Manufacturer> manufacturerList = serviceManufacturer
				.getManufacturers();
		Map<Integer, String> manufacturerMap = new HashMap<Integer, String>();
		for (Manufacturer manufacturer : manufacturerList) {
			manufacturerMap.put(manufacturer.getId(), manufacturer.getName());
		}
		model.addAttribute("manufacturerMap", manufacturerMap);

		List<Unit> unitList = serviceUnit.getUnits();
		Map<Integer, String> unitMap = new HashMap<Integer, String>();
		for (Unit unit : unitList) {
			unitMap.put(unit.getId(), unit.getName());
		}
		model.addAttribute("unitMap", unitMap);
		return new ModelAndView("newGood");
	}

	@RequestMapping(value = "/addGood", method = RequestMethod.POST)
	public @ResponseBody
	String addGood(@RequestParam String categoryGood,
			@RequestParam String manufacturerGood,
			@RequestParam String unitGood, @RequestParam String nameGood,
			@RequestParam String amountGood, @RequestParam String priceGood,
			@RequestParam String descriptionGood,
			@RequestParam String fullDescriptionGood) {
		float amount;
		if (amountGood.equals(""))
			amount = 0;
		else
			amount = Float.parseFloat(amountGood);

		Good good = new Good(0, nameGood, descriptionGood,
				Integer.parseInt(categoryGood),
				Integer.parseInt(manufacturerGood), amount,
				Integer.parseInt(unitGood));
		int good_id = serviceGood.addGood(good);
		if (!priceGood.equals("")) {
			float priceValue;
			priceValue = Float.parseFloat(priceGood);
			Price price = new Price(good_id, priceValue);
			servicePrice.addPrice(price);
		}

		if (!fullDescriptionGood.equals("")) {
			serviceGood.setLongDescription(good_id, fullDescriptionGood);
		}

		return "1";
	}

	@RequestMapping(value = "/deleteGood", method = RequestMethod.POST)
	public @ResponseBody
	String delGood(@RequestParam String id) {
		Integer confirm = serviceGood.removeGood(Integer.parseInt(id));
		return confirm.toString();
	}

	@RequestMapping(value = "/editGood", method = RequestMethod.POST)
	public ModelAndView editGood(Model model, @RequestParam String id) {
		int idGood = Integer.parseInt(id);
		Good good = serviceGood.getGood(idGood);
		String longDescroption = serviceGood.getLongDescription(idGood);
		Price price = servicePrice.getMaxDatePriceByOneGood(idGood);
		GoodFull goodFull = new GoodFull(good, price.getValue(), longDescroption);
		model.addAttribute("good", goodFull);
		
		System.out.println(goodFull.getName()+goodFull.getPrice());

		return new ModelAndView("newGood");
	}

}
