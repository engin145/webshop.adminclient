package com.algo.webshop.adminclient.controller;

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

import com.algo.webshop.adminclient.good.OrderFull;
import com.algo.webshop.common.domain.Order;
import com.algo.webshop.common.domainimpl.IOrder;
import com.algo.webshop.common.domainimpl.IOrderGood;
import com.algo.webshop.common.domainimpl.IPrice;
import com.algo.webshop.common.domainimpl.IUser;

@Controller
public class OrderController {

	private IOrder serviceOrder;
	private IOrderGood serviceOrderGood;
	private IPrice servicePrice;
	private IUser serviceUser;

	@Autowired
	public void setUserService(@Qualifier("userService") IUser service) {
		this.serviceUser = service;
	}

	@Autowired
	public void setOrderService(@Qualifier("orderService") IOrder service) {
		this.serviceOrder = service;
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
}
