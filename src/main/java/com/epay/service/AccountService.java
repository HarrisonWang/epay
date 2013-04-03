package com.epay.service;

import java.util.List;

import com.epay.model.Account;
import com.epay.model.Page;
import com.epay.model.User;

/**
 * 账户信息操作业务接口，包含新增、删除、更新、查询、充值等常用账户操作。
 * @author Harrison Wang
 */
public interface AccountService {

	/**
	 * 新增一个账户
	 * @param newAccount 新账户
	 * @return true成功，false失败
	 */
	public boolean add(Account newAccount);
	
	/**
	 * 删除指定的账户
	 * @param account 待删除账户
	 * @return true成功，false失败
	 */
	public boolean delete(Account account);
	
	/**
	 * 更新指定的账户
	 * @param account 待更新的账户
	 * @return true成功，false失败
	 */
	public boolean update(Account account);
	
	/**
	 * 获取指定账户的账户信息
	 * @param account 待查询的账户
	 * @return 指定账户的账户信息
	 */
	public Account get(Account account);
	
	/**
	 * 获取所有账户列表
	 * @return 账户列表
	 */
	public List<Account> getAll();
	
	/**
	 * 根据指定页和记录数获取账户列表
	 * @param page 待查询页
	 * @param pageSize 待查询页查询记录数
	 * @return 待查询账户列表
	 */
	public Page<Account> getAll(int page, int pageSize);
	
	/**
	 * 给指定账户充值
	 * @param account 待充值账户
	 * @param amount 待充值的金额
	 * @param currentUser 当前操作用户
	 * @return true成功，false失败
	 */
	public boolean refill(Account account, double amount, int refillType, User currentUser);
	
}
