package com.algo.webshop.adminclient.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.algo.webshop.adminclient.order.Positions;
import com.algo.webshop.common.domain.Basket;
import com.algo.webshop.common.domain.Good;
import com.algo.webshop.adminclient.good.OrderFull;
import com.algo.webshop.common.domain.Order;
import com.algo.webshop.common.domain.Position;
import com.algo.webshop.common.domain.Price;
import com.algo.webshop.common.domainimpl.IGood;
import com.algo.webshop.common.domainimpl.IOrder;
import com.algo.webshop.common.domainimpl.IOrderGood;
import com.algo.webshop.common.domainimpl.IPrice;
import com.algo.webshop.common.domainimpl.IUser;

@Controller
public class OrderController {

	private IOrder serviceOrder;
	private IUser serviceUser;
	private IOrderGood serviceOrderGood;
	private IPrice servicePrice;
	private IGood serviceGood;

	@Autowired
	public void setUserService(@Qualifier("userService") IUser service) {
		this.serviceUser = service;
	}

	@Autowired
	public void setOrderService(@Qualifier("orderService") IOrder service) {
		this.serviceOrder = service;
	}

	@Autowired
	public void setOrderService(@Qualifier("userService") IUser service) {
		this.serviceUser = service;
	}

	@Autowired
	public void setOrderGoodService(
			@Qualifier("orderGoodService") IOrderGood service) {
		this.serviceOrderGood = service;
	}

	@Autowired
	public void setPriceService(@Qualifier("priceService") IPrice service) {
		this.servicePrice = service;
	}

	@Autowired
	public void setGoodService(@Qualifier("goodService") IGood service) {
		this.serviceGood = service;
	}

	@RequestMapping(value = "/order")
	public String showOrder() {
		return "order";
	}

	@RequestMapping(value = "/orders", method = RequestMethod.POST)
	public String showOrders(Model model, @RequestParam("date") int date,
			@RequestParam("confirm_status") int confirmStatus,
			@RequestParam("cansel_status") int canselStatus) {
		List<Order> orders;
		if (date == 1) {
			Calendar dateM = Calendar.getInstance();
			dateM.add(Calendar.MONTH, -1);
			orders = serviceOrder.getOrdersList(confirmStatus, canselStatus,
					dateM);
		} else {
			orders = serviceOrder.getOrders(confirmStatus, canselStatus);
		}
		List<OrderFull> orderList = new LinkedList<OrderFull>();
		for (Order order : orders) {
			int userId = order.getUsers_id();
			String userName = "";
			if (userId != 0) {
				userName = serviceUser.getUserName(userId);
			}
			orderList.add(new OrderFull(order, userName));

		}
		model.addAttribute("orderList", orderList);
		return "orders";
	}

	@RequestMapping(value = "/ordersForUser", method = RequestMethod.GET)
	public String showOrdersForUser(Model model, @RequestParam("id") int id) {
		List<Order> orders = serviceOrder.getOrdersByUserId(id);
		List<OrderFull> orderList = new LinkedList<OrderFull>();
		for (Order order : orders) {
			int userId = order.getUsers_id();
			String userName = "";
			if (userId != 0) {
				userName = serviceUser.getUserName(userId);
			}
			orderList.add(new OrderFull(order, userName));

		}
		model.addAttribute("orderList", orderList);
		return "orders";
	}

	@RequestMapping(value = "/orderFull", method = RequestMethod.GET)
	public ModelAndView showOrderFull(Model model,
			@RequestParam("order") String num) {
		int userId;
		String userName;
		String date_order;
		String date_pay;
		String date_release;
		int cansel_status;
		int confirm_status;
		List<Basket> basketList = new ArrayList<Basket>();
		List<Position> positionList;
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
		Order order = serviceOrder.getOrderByNumber(num);

		model.addAttribute("num", num);

		try {
			userId = order.getUsers_id();
			userName = serviceUser.getUserName(userId);
		} catch (Exception e) {
			userName = "No name";
		}
		model.addAttribute("userName", userName);

		date_order = formatter.format(order.getDate_order().getTime());
		model.addAttribute("date", date_order);

		try {
			date_pay = formatter.format(order.getDate_pay().getTime());
		} catch (Exception e) {
			date_pay = "�� ��������";
		}
		model.addAttribute("pay", date_pay);

		try {
			date_release = formatter.format(order.getDate_release().getTime());
		} catch (Exception e) {
			date_release = "�� ��������";
		}
		model.addAttribute("release", date_release);

		positionList = serviceOrderGood.getGoodList(order.getId());

		for (Position pos : positionList) {
			Basket basket = new Basket();
			Price price = servicePrice.getActualDatePrice(
					order.getDate_order(), pos.getGoods_id());
			Good good = serviceGood.getGood(pos.getGoods_id());
			basket.setGoodId(pos.getGoods_id());
			basket.setNameGood(good.getName());
			basket.setValue(pos.getAmount());
			basket.setPrice(price.getValue());
			basketList.add(basket);
		}
		Positions positions = new Positions();
		positions.setBasketList(basketList);

		model.addAttribute("position", positions);

		String cansel = "";
		cansel_status = order.getCansel_status();
		if (cansel_status == 2)
			cansel = "������� �������������";
		if (cansel_status == 3)
			cansel = "������� ��������";
		model.addAttribute("cansel", cansel);

		String confirm;
		confirm_status = order.getConfirm_status();
		if (confirm_status == 1)
			confirm = "����� ����������";
		else
			confirm = "����� �� ����������";
		model.addAttribute("confirm", confirm);

		return new ModelAndView("orderFull");
	}
}
