package com.epay.model;

import java.io.Serializable;

public class Fee implements Serializable {

	private static final long serialVersionUID = 1L;

	private String areaCode; // 限费地市编号
	private String sx; // 限费
	private String city; // 地市
	private String type; // 业务

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getSx() {
		return sx;
	}

	public void setSx(String sx) {
		this.sx = sx;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "[areaCode=" + areaCode + "]";
	}

}
