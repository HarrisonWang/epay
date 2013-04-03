package com.epay.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.epay.dao.AccountMapper;
import com.epay.model.Account;
import com.epay.model.AccountType;
import com.epay.model.Page;
import com.epay.model.RefillLog;
import com.epay.model.User;
import com.epay.service.AccountService;
import com.epay.service.LogService;

@Service
public class AccountServiceImpl implements AccountService {
	
	private static final Logger logger = Logger.getLogger(AccountServiceImpl.class);

	@Autowired
	private AccountMapper accountMapper;
	
	@Autowired
	private LogService logService;
	
	@Transactional
	public boolean add(Account newAccount) {
		newAccount.setCreateTime(DateFormatUtils.format(Calendar.getInstance(), "yyyy-MM-dd HH:mm:ss"));
		newAccount.setUseAmount(0.0D);
		newAccount.setAmount(newAccount.getBalance());
		newAccount.setAccount_amount_hjd(newAccount.getBalance());
		newAccount.setAccount_useamount_hjd(0D);
		int i = accountMapper.save(newAccount);
		if (i == 1) {
			newAccount.getTelephoneCharge().setAccountId(newAccount.getId());
			addType(newAccount.getTelephoneCharge());
			newAccount.getGame().setAccountId(newAccount.getId());
			addType(newAccount.getGame());
			return true;
		}
		logger.info("新增账户" + newAccount.toString() + "失败");
		return false;
	}
	
	protected boolean addType(AccountType type) {
		int i = accountMapper.saveAccountType(type);
		if (i == 1) {
			logger.info("新增账户类型" + type.toString() + "成功");
			return true;
		}
		logger.info("新增账户类型" + type.toString() + "失败");
		return false;
	}

	public boolean delete(Account instance) {
		int i = accountMapper.delete(instance);
		if (i == 1) {
			logger.info("删除账户" + instance.toString() + "成功");
			return true;
		}
		logger.info("删除账户" + instance.toString() + "失败");
		return false;
	}

	public Account get(Account account) {
		Account instance = accountMapper.find(account);
		if (instance != null) {
			// 游戏账户
			AccountType game = new AccountType();
			game.setAccountId(instance.getId());
			game.setType(0);
			// 话费账户
			AccountType telephoneCharge = new AccountType();
			telephoneCharge.setAccountId(instance.getId());
			telephoneCharge.setType(1);
			
			game = getType(game);
			instance.setGame(game);
			
			telephoneCharge = getType(telephoneCharge);
			instance.setTelephoneCharge(telephoneCharge);
		} else {
			logger.info("账户" + account.toString() + "不存在");
		}
		return instance;
	}
	
	protected AccountType getType(AccountType type) {
		AccountType instance = accountMapper.findAccountType(type);
		if (instance == null) {
			logger.info("找不到账户" + type.getAccountId() + "的账户类型信息");
		}
		return instance;
	}

	public List<Account> getAll() {
		List<Account> accounts = accountMapper.list();
		return accounts;
	}

	public Page<Account> getAll(int page, int pageSize) {
		int totalCount = accountMapper.count();
		Page<Account> instance = new Page<Account>(page, pageSize, totalCount);
		List<Account> accounts = accountMapper.listByPage(instance);
		instance.setContent(accounts);
		if (accounts.size() == 0) {
			logger.info("账户列表为空");
		}
		return instance;
	}

	@Transactional
	public boolean refill(Account account, double amount, int refillType, User currentUser) {
		int i = 0;
		if (refillType == 0) {
			account.setBalance(account.getBalance() + amount);
			account.setAmount(account.getAmount() + amount);
			i = accountMapper.update(account);
		} else if (refillType == 1) {
			account.setAccount_balance_hjd(account.getAccount_balance_hjd() + amount);
			account.setAccount_amount_hjd(account.getAccount_amount_hjd() + amount);
			account.setBizType(refillType);
			i = accountMapper.update4hjd(account);
		}
		if (i != 1) {
			logger.info("更新账户" + account.toString() + "失败");
			return false;
		}
		RefillLog refillLog = new RefillLog();
		refillLog.setAmount(amount);
		refillLog.setTime(new Date());
		refillLog.setUserId(currentUser.getUserId());
		refillLog.setAccountId(account.getId());
		refillLog.setResult(0);
		refillLog.setFillType(account.getBizType());
		refillLog.setMsg("充值成功！");
		boolean result = logService.add(refillLog);
		if (!result) {
			logger.info("新增账户充值记录失败！");
		} else {
			logger.info("新增账户充值记录成功！");
		}
		return true;
	}

	public boolean update(Account account) {
		accountMapper.update(account);
		accountMapper.updateAccountType(account.getGame());
		accountMapper.updateAccountType(account.getTelephoneCharge());
		return true;
	}

}
