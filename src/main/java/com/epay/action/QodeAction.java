package com.epay.action;

import java.io.File;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.epay.model.Page;
import com.epay.model.Qode;
import com.epay.service.QodeService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class QodeAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private File myDoc;
	private String myDocFileName;
	private String myDocContentType;
	private Qode qode;
	private int page;
	private int pageSize;
	
	@Autowired
	private QodeService qodeService;

	public String save() throws Exception {
		
		if (StringUtils.isNotEmpty(qode.getAreaCode()) && qode.getType() != null && myDoc != null) {
			String realPath = ServletActionContext.getServletContext().getRealPath("/");
			File saveFile = new File(new File(realPath), myDocFileName);
			if (!saveFile.getParentFile().exists()) {
				saveFile.getParentFile().mkdirs();
			}
			FileUtils.copyFile(myDoc, saveFile);
			qode.setValid("0");
			boolean result = qodeService.save(saveFile.getPath(), qode);
			if (result) {
				this.addActionMessage("导入字符串成功！");
				return SUCCESS;
			}
		}
		this.addActionError("导入字符串失败！");
		return ERROR;
	}
	
	@Override
	public String execute() throws Exception {
		Page<Qode> qodes = qodeService.find(null, page, pageSize);
		double totalMoney = qodeService.sumMoney(null);
		ActionContext.getContext().put("QODE_LIST", qodes);
		ActionContext.getContext().put("MONEY", totalMoney);
		return SUCCESS;
	}
	
	public String search() throws Exception {
		Page<Qode> qodes = qodeService.find(qode, page, pageSize);
		double totalMoney = qodeService.sumMoney(qode);
		ActionContext.getContext().put("QODE_LIST", qodes);
		ActionContext.getContext().put("MONEY", totalMoney);
		return SUCCESS;
	}

	public File getMyDoc() {
		return myDoc;
	}

	public void setMyDoc(File myDoc) {
		this.myDoc = myDoc;
	}

	public String getMyDocFileName() {
		return myDocFileName;
	}

	public void setMyDocFileName(String fileName) {
		this.myDocFileName = fileName;
	}

	public String getMyDocContentType() {
		return myDocContentType;
	}

	public void setMyDocContentType(String contentType) {
		this.myDocContentType = contentType;
	}

	public Qode getQode() {
		return qode;
	}

	public void setQode(Qode qode) {
		this.qode = qode;
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
