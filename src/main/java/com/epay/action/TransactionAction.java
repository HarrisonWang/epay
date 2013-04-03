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

import com.epay.model.Page;
import com.epay.model.TradeLog;
import com.epay.model.User;
import com.epay.service.LogService;
import com.epay.util.ExcelUtils;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TransactionAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private String beginDate;
	private String endDate;
	private String status;
	private User user;
	private int page;
	private int pageSize;
	private InputStream excelFile;
	private String downloadFileName;
    @Autowired
    private LogService logService;
	
	@Override
	public String execute() throws Exception {
		Page<TradeLog> instance = logService.get(LogService.TRADE_LOG, new User(), page, pageSize);
		ActionContext.getContext().put("TRADE_LOGS", instance);
		Map<String, String> results = logService.sumMoney(LogService.TRADE_LOG, -1, null, beginDate, endDate, -1);
		if (results != null && !results.isEmpty()) {
			ActionContext.getContext().put("SUCCESS_MONEY", results.get("success"));
			ActionContext.getContext().put("FAILURE_MONEY", results.get("failure"));
		}
		return SUCCESS;
	}
	
	public String search() throws Exception {
		Page<TradeLog> tradeLogs = logService.find(LogService.TRADE_LOG, -1, user, beginDate, endDate, Integer.parseInt(status), page, pageSize);
		ActionContext.getContext().put("TRADE_LOGS", tradeLogs);
		Map<String, String> results = logService.sumMoney(LogService.TRADE_LOG, -1, user, beginDate, endDate, Integer.parseInt(status));
		if (results != null && !results.isEmpty()) {
			ActionContext.getContext().put("SUCCESS_MONEY", results.get("success"));
			ActionContext.getContext().put("FAILURE_MONEY", results.get("failure"));
		}
		return SUCCESS;
	}
	
	public String export() throws Exception {
		Page<TradeLog> tradeLogs = logService.find(LogService.TRADE_LOG, -1, user, beginDate, endDate, Integer.parseInt(status), page, 10000);
		HSSFWorkbook workbook = ExcelUtils.export(tradeLogs.getContent(), LogService.TRADE_LOG);
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		workbook.write(output);
		byte[] ba = output.toByteArray();  
        ByteArrayInputStream bais = new ByteArrayInputStream(ba);
        this.setExcelFile(bais);
		return SUCCESS;
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
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getDownloadFileName() {
		String downloadFileName = (DateFormatUtils.format(Calendar.getInstance(), "yyyy-MM-dd")) + "交易记录.xls";
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
}
