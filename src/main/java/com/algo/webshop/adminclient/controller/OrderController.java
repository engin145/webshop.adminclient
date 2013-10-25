package com.algo.webshop.adminclient.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.algo.webshop.common.domain.Order;
import com.algo.webshop.common.domainimpl.IOrder;

@Controller
public class OrderController {

	private IOrder serviceOrder;

	@Autowired
	public void setOrderService(@Qualifier("orderService") IOrder service) {
		this.serviceOrder = service;
	}

	@RequestMapping(value = "/order")
	public String showOrder() {
		return "order";
	}

	@RequestMapping(value = "/orders")
	public String showOrders(Model model, @RequestParam("date") int date,
			@RequestParam("confirm_status") int confirmStatus,
			@RequestParam("cansel_status") int canselStatus) {
		List<Order> list = serviceOrder.getOrders(confirmStatus, canselStatus);
		System.out.println(list);
		return "orders";
	}
}
