package com.epay.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.epay.dao.AccountMapper;
import com.epay.model.Account;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.epay.dao.UserMapper;
import com.epay.model.Page;
import com.epay.model.User;
import com.epay.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
	@Autowired
	private UserMapper userMapper;
    @Autowired
    private AccountMapper accountMapper;
	
	public boolean add(User newUser) {
		int i = userMapper.save(newUser);
		if (i == 1) {
			logger.info("新增用户" + newUser.toString() + "成功");
			return true;
		}
		logger.info("新增用户" + newUser.toString() + "失败");
		return false;
	}
	
	public boolean delete(String userId) {
		User user = this.get(userId);
		return this.delete(user);
	}
	
	public boolean delete(final User user) {
		User instance = get(user);
		// 禁用当前用户
//		instance.setValid(1);
//		int i = userMapper.update(instance);
		int i = userMapper.delete(instance);
		if (i == 1) {
			logger.info("删除用户" + user.toString() + "成功");
			return true;
		}
		logger.info("删除用户" + user.toString() + "失败");
		return false;
	}
	
	public boolean update(String userId) {
		User instance = this.get(userId);
		return this.update(instance);
	}
	
	public boolean update(final User user) {
		int i = userMapper.update(user);
		if (i == 1) {
			logger.info("更新用户" + user.toString() + "成功");
			return true;
		}
		logger.info("更新用户" + user.toString() + "失败");
		return false;
	}
	
	public User get(String userId) {
		User user = new User();
		user.setUserId(userId);
		return this.get(user);
	}

	public User get(User user) {
		User instance = userMapper.find(user);
		if (instance == null) {
			logger.info("用户" + user.toString() + "不存在");
		}
		return instance;
	}
	
	public User logIn(User user) throws Exception {
		User instance = null;
		instance = userMapper.find(user);
		if (instance == null) {
			logger.info("用户" + user.toString() + "登录失败，用户ID或密码错误");
		}
		return instance;
	}
	
	public User logIn(String userId, String password) throws Exception {
		User loginUser = new User();
		loginUser.setUserId(userId);
		loginUser.setPassword(password);
		return this.logIn(loginUser);
	}

	public Page<User> getAll(int currentPage, int pageSize) {
		int totalCount = userMapper.count();
		Page<User> page = new Page<User>(currentPage, pageSize, totalCount);
		List<User> users = userMapper.list(page);
		if (users.size() == 0) {
			logger.info("找不到相关用户列表");
		}
		page.setContent(users);
		return page;
	}

    public Page<User> getAll(int page, int pageSize, User loginUser, User user) {
		Map<String, Object> params = new HashMap<String, Object>();
        Page<User> instance = null;
        if (loginUser.isSuperAdmin()) {
            if (user != null) {
                if (StringUtils.isNotEmpty(user.getAccountNumber())) {
                    Account account = accountMapper.findByNumber(user.getAccountNumber());
                    params.put("accountId", account.getId());
                }
                params.put("userId", user.getUserId());
                params.put("areaCode", user.getAreaCode());
                if (user.getCreateTime() != null) {
                    params.put("createTime", DateFormatUtils.format(user.getCreateTime(), "yyyy-MM-dd"));
                }
                params.put("type", user.getType());
                if (StringUtils.isNotEmpty(user.getBizType())) {
            		params.put("bizType", user.getBizType());
                }
            }
            int totalCount = userMapper.countByParams(params);
            instance = new Page<User>(page, pageSize, totalCount);
		    params.put("beginIndex", instance.getBeginIndex());
		    params.put("pageSize", instance.getPageSize());
            List<User> users = userMapper.listByParams(params);
            instance.setContent(users);
        } else if (loginUser.isOperationAdmin()) {
            if (user != null) {
                if (StringUtils.isNotEmpty(user.getAccountNumber())) {
                    Account account = accountMapper.findByNumber(user.getAccountNumber());
                    params.put("accountId", account.getId());
                }
                params.put("userId", user.getUserId());
                params.put("areaCode", user.getAreaCode());
                if (user.getCreateTime() != null) {
                    params.put("createTime", DateFormatUtils.format(user.getCreateTime(), "yyyy-MM-dd"));
                }
                params.put("type", user.getType());
                if (StringUtils.isNotEmpty(user.getBizType())) {
                	params.put("bizType", user.getBizType());
                }
            }
            int totalCount = userMapper.countForOperationAdmin(params);
            instance = new Page<User>(page, pageSize, totalCount);
		    params.put("beginIndex", instance.getBeginIndex());
		    params.put("pageSize", instance.getPageSize());
            List<User> users = userMapper.listForOperationAdmin(params);
            instance.setContent(users);
        } else if (loginUser.isFinanceAdmin()) {
             // TODO:
        }
        return instance;
    }

}
