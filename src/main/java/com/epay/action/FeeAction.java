package com.epay.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.epay.model.Fee;
import com.epay.model.Page;
import com.epay.service.FeeService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class FeeAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	@Autowired
	private FeeService feeService;
	private int page;
	private int pageSize;
	private Fee fee;
	
	@Override
	public String execute() throws Exception {
		Page<Fee> content = feeService.find(page, pageSize);
		ActionContext.getContext().put("FEE_LIST", content);
		return SUCCESS;
	}
	
	public String save() throws Exception {
		boolean flag = feeService.save(fee);
		if (flag) {
			this.addActionMessage("新增地市[" + fee.getAreaCode() + "]限费信息成功！");
			return SUCCESS;
		} else {
			this.addActionError("新增地市[" + fee.getAreaCode() + "]限费信息失败！");
			return ERROR;
		}
	}
	
	public String edit() throws Exception {
		fee = feeService.get(fee.getAreaCode(), fee.getType());
		return SUCCESS;
	}
	
	public String update() throws Exception {
		boolean flag = feeService.update(fee);
		if (flag) {
			this.addActionMessage("更新地市[" + fee.getAreaCode() + "]限费信息成功！");
			return SUCCESS;
		}
		this.addActionError("更新地市[" + fee.getAreaCode() + "]限费信息失败！");
		return ERROR;
	}
	
	public String delete() throws Exception {
		boolean flag = feeService.delete(fee);
		if (flag) {
			this.addActionMessage("删除地市[" + fee.getAreaCode() + "]限费信息成功！");
			return SUCCESS;
		}
		this.addActionError("删除地市[" + fee.getAreaCode() + "]限费信息失败！");
		return ERROR;
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

	public Fee getFee() {
		return fee;
	}

	public void setFee(Fee fee) {
		this.fee = fee;
	}

}
