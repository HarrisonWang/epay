package com.epay.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.epay.model.Account;
import com.epay.model.Page;
import com.epay.model.User;
import com.epay.service.AccountService;
import com.epay.service.UserService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

public class AccountAction extends ActionSupport implements Preparable {

    private static final long serialVersionUID = 1L;
    private double amount;
    private User user;
    private Account account;
    private List<Account> accounts;
    private int page;
    private int pageSize;
    @Autowired
    private UserService userService;
    @Autowired
    private AccountService accountService;
    
    public String execute() throws Exception {
    	Page<Account> data = accountService.getAll(page, pageSize);
        ActionContext.getContext().put("LIST_ACCOUNT", data);
        return SUCCESS;
    }

    public String save() throws Exception {
        boolean result = accountService.add(account);
        if(result) {
            addActionMessage("新增账户" + account.toString() + "成功");
            return SUCCESS;
        } else {
            addActionError("新增账户" + account.toString() + "失败");
            return ERROR;
        }
    }

    public String edit() throws Exception {
    	account = accountService.get(account);
        return SUCCESS;
    }

    public String update() throws Exception {
    	boolean isSuccess = accountService.update(account);
        if(isSuccess) {
            addActionMessage("更新账户" + account.toString() + "成功");
            return SUCCESS;
        } else {
            addActionMessage("更新账户" + account.toString() + "失败");
            return ERROR;
        }
    }

    public String list() throws Exception {
        accounts = accountService.getAll();
        return SUCCESS;
    }

    public String delete() throws Exception {
        boolean result = accountService.delete(account);
        if (result) {
        	addActionMessage("删除账户" + account.toString() + "成功！");
        	return SUCCESS;
        }
        addActionMessage("删除账户" + account.toString() + "失败！");
        return ERROR;
    }

    public void prepare() throws Exception {
        Page<User> users = userService.getAll(page, pageSize);
        ActionContext.getContext().put("LIST_USER", users);
    }
    
	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public List<Account> getAccounts() {
		return accounts;
	}

	public void setAccounts(List<Account> accounts) {
		this.accounts = accounts;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

}
