package com.algo.webshop.adminclient.good;

import com.algo.webshop.common.domain.Good;

@SuppressWarnings("serial")
public class GoodFull extends Good {
	private float price;
	private String longDescription;
	
	public GoodFull() {
		
	}

	public GoodFull(Good good, float price) {
		super(good.getId(), good.getName(), good.getDescription(), good
				.getCategory_id(), good.getManufacturers_id(),
				good.getAmount(), good.getUnits_id());
		this.price = price;
	}

	public GoodFull(Good good, float price, String longDescription) {
		super(good.getId(), good.getName(), good.getDescription(), good
				.getCategory_id(), good.getManufacturers_id(),
				good.getAmount(), good.getUnits_id());
		this.price = price;
		this.longDescription = longDescription;
	}

	public String getLongDescription() {
		return longDescription;
	}

	public void setLongDescription(String longDescription) {
		this.longDescription = longDescription;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}
}
