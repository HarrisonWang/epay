package com.epay.model;

import java.io.Serializable;

public class Account implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String accountNumber;
	private double amount;
	private double useAmount;
	private double balance;
	
	private double account_balance_hjd;
	private double account_amount_hjd;
	private double account_useamount_hjd;
	
	private String createTime;
	private AccountType telephoneCharge;
	private AccountType game;
	
	private int bizType;

	public int getBizType() {
		return bizType;
	}

	public void setBizType(int bizType) {
		this.bizType = bizType;
	}

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

    public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getUseAmount() {
		return useAmount;
	}

	public void setUseAmount(double useAmount) {
		this.useAmount = useAmount;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}
	
	public double getAccount_balance_hjd() {
		return account_balance_hjd;
	}

	public void setAccount_balance_hjd(double accountBalanceHjd) {
		account_balance_hjd = accountBalanceHjd;
	}

	public double getAccount_amount_hjd() {
		return account_amount_hjd;
	}

	public void setAccount_amount_hjd(double accountAmountHjd) {
		account_amount_hjd = accountAmountHjd;
	}

	public double getAccount_useamount_hjd() {
		return account_useamount_hjd;
	}

	public void setAccount_useamount_hjd(double accountUseamountHjd) {
		account_useamount_hjd = accountUseamountHjd;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public AccountType getTelephoneCharge() {
		return telephoneCharge;
	}

	public void setTelephoneCharge(AccountType telephoneCharge) {
		this.telephoneCharge = telephoneCharge;
	}

	public AccountType getGame() {
		return game;
	}

	public void setGame(AccountType game) {
		this.game = game;
	}

	@Override
	public String toString() {
		return "[accountNumber=" + accountNumber + "]";
	}
	
}
