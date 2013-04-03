package com.epay.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import com.epay.model.Page;
import com.epay.model.Proceeds;
import com.epay.service.LogService;
import com.epay.service.ProceedsService;
import com.epay.util.ExcelUtils;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ProceedsAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	
	private Proceeds proceeds;
	private int page;
	private int pageSize;
	private InputStream excelFile;
	private String downloadFileName;
	
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

	@Autowired
	private ProceedsService proceedsService;

	public Proceeds getProceeds() {
		return proceeds;
	}

	public void setProceeds(Proceeds proceeds) {
		this.proceeds = proceeds;
	}

	@Override
	public String execute() throws Exception {
		Page<Proceeds> content = proceedsService.find(page, pageSize);
		double totalMoney = proceedsService.sumMoney(proceeds);
		ActionContext.getContext().put("MONEY", totalMoney);
		ActionContext.getContext().put("PROCEEDS_LIST", content);
		return SUCCESS;
	}
	
	public String save() throws Exception {
		boolean result = proceedsService.add(proceeds);
		if (result) {
			addActionMessage("新增打款信息成功！");
			return SUCCESS;
		} else {
			addActionError("新增打款信息失败！");
			return ERROR;
		}
	}
	
	public String search() throws Exception {
		Page<Proceeds> p = proceedsService.search(proceeds, page, pageSize); 
		double totalMoney = proceedsService.sumMoney(proceeds);
		ActionContext.getContext().put("MONEY", totalMoney);
		ActionContext.getContext().put("PROCEEDS_LIST", p);
		return SUCCESS;
	}
	
	public String export() throws Exception {
		Page<Proceeds> p = proceedsService.search(proceeds, page, 10000);
		HSSFWorkbook workbook = ExcelUtils.export(p.getContent(), LogService.PROCEEDS_TYPE);
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		workbook.write(output);
		byte[] ba = output.toByteArray();  
        ByteArrayInputStream bais = new ByteArrayInputStream(ba);
        this.setExcelFile(bais);
		return SUCCESS;
	}

	public String getDownloadFileName() {
		String downloadFileName = (DateFormatUtils.format(Calendar.getInstance(), "yyyy-MM-dd")) + "打款记录.xls";
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
