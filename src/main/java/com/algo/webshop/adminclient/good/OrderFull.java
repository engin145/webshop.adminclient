package com.algo.webshop.adminclient.good;

import com.algo.webshop.common.domain.Order;

@SuppressWarnings("serial")
public class OrderFull extends Order {
	private String userName;

	public OrderFull(Order order, String userName) {
		this.setId(order.getId());
		this.setCansel_status(order.getCansel_status());
		this.setConfirm_status(order.getConfirm_status());
		this.setDate_order(order.getDate_order());
		this.setDate_pay(order.getDate_pay());
		this.setDate_release(order.getDate_release());
		this.setEmail(order.getEmail());
		this.setPhone(order.getPhone());
		this.setNumber(order.getNumber());
		this.setUsers_id(order.getUsers_id());
		this.setUserName(userName);
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
