package com.epay.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import com.epay.model.Account;
import com.epay.model.Page;
import com.epay.model.RefillLog;
import com.epay.model.User;
import com.epay.service.AccountService;
import com.epay.service.LogService;
import com.epay.util.ExcelUtils;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class RechargeAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	private String beginDate;
	private String endDate;
	private String status = "-1";
	private User user;
	private int page;
	private int pageSize;
	private InputStream excelFile;
	private String downloadFileName;
	private Account account;
	private double amount;
	private String bizType = "-1";

	public String getBizType() {
		return bizType;
	}

	public void setBizType(String bizType) {
		this.bizType = bizType;
	}

	@Autowired
	private LogService logService;
	
	@Autowired
	private AccountService accountService;

	@Override
	public String execute() throws Exception {
		Page<RefillLog> refillLogs = logService.get(LogService.REFILL_LOG, user, page, pageSize); ActionContext.getContext().put("LIST_FILL_LOGS", refillLogs);
		Map<String, String> results = logService.sumMoney(LogService.REFILL_LOG, -1, null, beginDate, endDate, -1);
		if (results != null && !results.isEmpty()) {
			ActionContext.getContext().put("MONEY", results.get("money"));
		}
		return SUCCESS;
	}

	public String search() throws Exception {
		Page<RefillLog> refillLogs = logService.find(LogService.REFILL_LOG, Integer.parseInt(bizType), user, beginDate, endDate, Integer.parseInt(status), page, pageSize);
		ActionContext.getContext().put("LIST_FILL_LOGS", refillLogs);
		Map<String, String> results = logService.sumMoney(LogService.REFILL_LOG, Integer.parseInt(bizType), user, beginDate, endDate, Integer.parseInt(status));
		if (results != null && !results.isEmpty()) {
			ActionContext.getContext().put("MONEY", results.get("money"));
		}
		return SUCCESS;
	}

	public String export() throws Exception {
		Page<RefillLog> refillLogs = logService.find(LogService.REFILL_LOG, Integer.parseInt(bizType), user, beginDate, endDate, Integer.parseInt(status), page, 10000);
		HSSFWorkbook workbook = ExcelUtils.export(refillLogs.getContent(), LogService.REFILL_LOG);
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		workbook.write(output);
		byte[] ba = output.toByteArray();  
        ByteArrayInputStream bais = new ByteArrayInputStream(ba);
        this.setExcelFile(bais);
		return SUCCESS;
	}
	
	public String recharge() throws Exception {
		account = accountService.get(account);
		User currentUser = (User) ActionContext.getContext().getSession().get( "LOGIN_USER");
		boolean isSuccess = accountService.refill(account, amount, Integer.valueOf(bizType), currentUser);
		if (isSuccess) {
			addActionMessage("充值成功");
			return SUCCESS;
		} else {
			addActionError("充值失败");
			return ERROR;
		}
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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

	public String getDownloadFileName() {
		String downloadFileName = (DateFormatUtils.format(Calendar.getInstance(), "yyyy-MM-dd")) + "预付款信息.xls";
		try {
			downloadFileName = new String(downloadFileName.getBytes(), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return downloadFileName;
	}

	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}

	public InputStream getExcelFile() {
		return excelFile;
	}

	public void setExcelFile(InputStream excelFile) {
		this.excelFile = excelFile;
	}
	
	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

}
