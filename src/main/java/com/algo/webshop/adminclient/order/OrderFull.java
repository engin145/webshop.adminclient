package com.algo.webshop.adminclient.order;

import java.util.List;

import com.algo.webshop.common.domain.Basket;

public class OrderFull  {
	private int id;
	private String number;
	private int users_id;
	private String phone;
	private String email;
	private String date_order;
	private String date_pay;
	private String date_release;
	private int cansel_status;
	private int confirm_status;
	private List<Basket> positionList;
	
	public OrderFull() {
		
	}
	
	public OrderFull(int id, String number, int users_id, String phone,
			String email, String date_order, String date_pay,
			String date_release, int cansel_status, int confirm_status) {
		super();
		this.id = id;
		this.number = number;
		this.users_id = users_id;
		this.phone = phone;
		this.email = email;
		this.date_order = date_order;
		this.date_pay = date_pay;
		this.date_release = date_release;
		this.cansel_status = cansel_status;
		this.confirm_status = confirm_status;
	}
	
	public OrderFull(int id, String number, int users_id, String phone,
			String email, String date_order, String date_pay,
			String date_release, int cansel_status, int confirm_status,
			List<Basket> positionList) {
		super();
		this.id = id;
		this.number = number;
		this.users_id = users_id;
		this.phone = phone;
		this.email = email;
		this.date_order = date_order;
		this.date_pay = date_pay;
		this.date_release = date_release;
		this.cansel_status = cansel_status;
		this.confirm_status = confirm_status;
		this.positionList = positionList;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public int getUsers_id() {
		return users_id;
	}

	public void setUsers_id(int users_id) {
		this.users_id = users_id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDate_order() {
		return date_order;
	}

	public void setDate_order(String date_order) {
		this.date_order = date_order;
	}

	public String getDate_pay() {
		return date_pay;
	}

	public void setDate_pay(String date_pay) {
		this.date_pay = date_pay;
	}

	public String getDate_release() {
		return date_release;
	}

	public void setDate_release(String date_release) {
		this.date_release = date_release;
	}

	public int getCansel_status() {
		return cansel_status;
	}

	public void setCansel_status(int cansel_status) {
		this.cansel_status = cansel_status;
	}

	public int getConfirm_status() {
		return confirm_status;
	}

	public void setConfirm_status(int confirm_status) {
		this.confirm_status = confirm_status;
	}

	public List<Basket> getPositionList() {
		return positionList;
	}

	public void setPositionList(List<Basket> positionList) {
		this.positionList = positionList;
	}
	
	
	
}
