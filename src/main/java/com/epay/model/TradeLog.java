package com.epay.model;

import java.io.Serializable;
import java.util.Date;

public class TradeLog implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String userId;
	private String tradeNumber;
	private int numberType;
	private double tradeAmount;
	private int fillType;
	private int tradeResult;
	private String failMsg;
	private Date tradeTime;
	private String tradeAccount;
    private String accountNumber;
	private String tradePhone;
	private String taskId;
	private String areaCode;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTradeNumber() {
		return tradeNumber;
	}

	public void setTradeNumber(String tradeNumber) {
		this.tradeNumber = tradeNumber;
	}

	public int getNumberType() {
		return numberType;
	}

	public void setNumberType(int numberType) {
		this.numberType = numberType;
	}

	public double getTradeAmount() {
		return tradeAmount;
	}

	public void setTradeAmount(double tradeAmount) {
		this.tradeAmount = tradeAmount;
	}

	public int getFillType() {
		return fillType;
	}

	public void setFillType(int fillType) {
		this.fillType = fillType;
	}

	public int getTradeResult() {
		return tradeResult;
	}

	public void setTradeResult(int tradeResult) {
		this.tradeResult = tradeResult;
	}

	public String getFailMsg() {
		return failMsg;
	}

	public void setFailMsg(String failMsg) {
		this.failMsg = failMsg;
	}

	public Date getTradeTime() {
		return tradeTime;
	}

	public void setTradeTime(Date tradeTime) {
		this.tradeTime = tradeTime;
	}

	public String getTradeAccount() {
		return tradeAccount;
	}

	public void setTradeAccount(String tradeAccount) {
		this.tradeAccount = tradeAccount;
	}

	public String getTradePhone() {
		return tradePhone;
	}

	public void setTradePhone(String tradePhone) {
		this.tradePhone = tradePhone;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
}
