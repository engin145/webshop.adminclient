package com.algo.webshop.adminclient.user;

import com.algo.webshop.common.domain.User;

@SuppressWarnings("serial")
public class UserFull extends User {
	private float buy;

	public UserFull() {
		
	}
	
	public UserFull(int id, String name, String email, String phone, String login,
			String pass, float buy) {
		super(name, email, phone, login, pass);
		this.setId(id);
		this.buy = buy;
	}

	public float getBuy() {
		return buy;
	}

	public void setBuy(float buy) {
		this.buy = buy;
	}
	
}
