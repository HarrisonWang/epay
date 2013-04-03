package com.epay.model;

import java.io.Serializable;

public class AccountType implements Serializable {

	private static final long serialVersionUID = 1L;
	private int accountId;
	private int level;
	private int type;
	
	public int getAccountId() {
		return accountId;
	}

	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String toString() {
		return "[accountId=" + accountId + ", type=" + type + ", level=" + level + "]";
	}
}
