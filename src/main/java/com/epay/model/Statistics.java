package com.epay.model;

import java.io.Serializable;

public class Statistics implements Serializable {

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	private static final long serialVersionUID = 1L;
	private int month;
	private double total;
}
