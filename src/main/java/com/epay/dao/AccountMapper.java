package com.epay.dao;

import java.util.List;
import java.util.Map;

import com.epay.model.Account;
import com.epay.model.AccountType;
import com.epay.model.Page;
import com.epay.model.RefillLog;

public interface AccountMapper {

	public int save(Account account);

	public int saveAccountType(AccountType accounttype);

	public int delete(Account account);

	public int update(Account account);
	
	public int update4hjd(Account account);

	public int updateAccountType(AccountType accounttype);

	public int count();

	public List<Account> list();

	public List<Account> listByPage(Page page);

	public Account find(Account account);

    public Account findByNumber(String accountNumber);

	public AccountType findAccountType(AccountType accounttype);

	public int saveFillLog(RefillLog filllog);

	public List<RefillLog> findFillLogs(Map map);

	public int countFillLogs(Map<String, Object> params);
}
