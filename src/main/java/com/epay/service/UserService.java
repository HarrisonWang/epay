package com.epay.service;

import com.epay.model.Page;
import com.epay.model.User;

/**
 * 用户服务接口，包含常用的新增、删除、更新、查询等用户操作
 * @author Harrison Wang
 *
 */
public interface UserService {

	/**
	 * 新增用户
	 * @param newUser 新用户
	 * @return true成功，false失败
	 */
	public boolean add(User newUser);
	
	/**
	 * 删除用户
	 * @param userId 待删除用户userId
	 * @return true成功，false失败
	 */
	public boolean delete(String userId);
	
	/**
	 * 删除用户
	 * @param user 待删除用户
	 * @return true成功，false失败
	 */
	public boolean delete(final User user);
	
	/**
	 * 更新用户
	 * @param userId 待更新用户userId
	 * @return true成功，false失败
	 */
	public boolean update(String userId);
	
	/**
	 * 更新用户
	 * @param user 待更新用户
	 * @return true成功，false失败
	 */
	public boolean update(final User user);
	
	/**
	 * 获取指定用户的用户信息
	 * @param userName 待查询的用户
	 * @return 指定用户的用户信息
	 */
	public User get(String userName);
	
	/**
	 * 获取指定用户的用户信息
	 * @param user 待查询的用户
	 * @return 指定用户的用户信息
	 */
	public User get(User user);
	
	/**
	 * 根据待查询页和查询记录数获取用户列表
	 * @param page 待查询页
	 * @param pageSize 待查询页查询记录数
	 * @return 用户列表
	 */
	public Page<User> getAll(int page, int pageSize);

    /**
     * 根据当前登录用户所具有的权限获取用户列表
     * @param page 页码
     * @param pageSize 每页显示记录数
     * @param loginUser 当前登录用户
     * @param params 查询参数
     * @return 用户列表
     */
    public Page<User> getAll(int page, int pageSize, User loginUser, User params);
	
	/**
	 * 用户登录
	 * @param user 登录用户
	 * @return 当前登录用户信息
	 */
	public User logIn(User user) throws Exception;
	
	/**
	 * 用户登录
	 * @param userName 登录用户名
	 * @param password 登录密码
	 * @return 当前登录用户信息
	 */
	public User logIn(String userName, String password) throws Exception;
	
}
