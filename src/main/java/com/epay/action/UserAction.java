package com.epay.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;

import com.epay.model.Page;
import com.epay.model.User;
import com.epay.service.LogService;
import com.epay.service.UserService;
import com.epay.util.ExcelUtils;
import com.google.code.kaptcha.Constants;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UserAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private User user;
	private String userName;
	private String beginDate;
	private List<String> userTypes;
	private String areaCode;
	private int page;
	private int pageSize;
	@Autowired
	private UserService userService;
	private InputStream excelFile;
	private String downloadFileName;
	private String kaptchaField;
	
	private List<String> bizType;

    public List<String> getBizType() {
		return bizType;
	}

	public void setBizType(List<String> bizType) {
		this.bizType = bizType;
	}

	public String save() throws Exception {
		if (StringUtils.isNotEmpty(user.getUserId())
				&& StringUtils.isNotEmpty(user.getPassword())
				&& StringUtils.isNotEmpty(user.getAreaCode())
				&& StringUtils.isNotEmpty(user.getIdentityCard())) {
			user.setCreateTime(new Date());
	        String bizTypeString = "";
	        for (int i = 0; i < bizType.size(); i++) {
	        	if (i < bizType.size() - 1) {
	        		bizTypeString += bizType.get(i) + "|";
	        	} else {
	        		bizTypeString += bizType.get(i);
	        	}
	        }
	        user.setBizType(bizTypeString);
			boolean isSuccess = userService.add(user);
			if (isSuccess) {
				addActionMessage("新增用户" + user.toString() + "成功");
				return SUCCESS;
			}
			addActionError("新增用户" + user.toString() + "失败");
		}
		return INPUT;
	}

	public String delete() throws Exception {
		boolean isSuccess = userService.delete(user);
		if (isSuccess) {
			addActionMessage("删除用户" + user.toString() + "成功");
			return SUCCESS;
		} else {
			return ERROR;
		}
	}

    public String changePassword() throws Exception {
        User loginUser = (User) ActionContext.getContext().getSession().get("LOGIN_USER");
		if (StringUtils.isNotEmpty(user.getPassword())) {
			loginUser.setPassword(user.getPassword());
			boolean isSuccess = userService.update(loginUser);
			if (isSuccess) {
                addActionMessage("修改密码成功！");
                return SUCCESS;
			} else {
				addActionError("修改密码失败！");
				return ERROR;
			}
		}
        return INPUT;
    }

    public String editProfile() throws Exception {
        User loginUser = (User) ActionContext.getContext().getSession().get("LOGIN_USER");
        user = userService.get(loginUser);
        return SUCCESS;
    }

    public  String updateProfile() throws Exception {
		if (StringUtils.isNotEmpty(user.getAreaCode())
				&& StringUtils.isNotEmpty(user.getIdentityCard())
				&& StringUtils.isNotEmpty(user.getUserName())) {
            Map<String, Object> session = ActionContext.getContext().getSession();
            User loginUser = (User) session.get("LOGIN_USER");
            loginUser.setAreaCode(user.getAreaCode());
            loginUser.setUserName(user.getUserName());
            loginUser.setPhone(user.getPhone());
            loginUser.setIdentityCard(user.getIdentityCard());
            loginUser.setUserMac(user.getUserMac());
            loginUser.setDescription(user.getDescription());
			boolean isSuccess = userService.update(loginUser);
			if (isSuccess) {
                session.put("LOGIN_USER", loginUser);
                addActionMessage("修改个人资料成功！");
                return SUCCESS;
			} else {
				addActionError("修改个人资料失败！");
				return ERROR;
			}
		}
        return INPUT;
    }

	public String update() throws Exception {
		if (StringUtils.isNotEmpty(user.getPassword())
				&& StringUtils.isNotEmpty(user.getAreaCode())
				&& StringUtils.isNotEmpty(user.getIdentityCard())
				&& StringUtils.isNotEmpty(user.getUserName())) {
	        String bizTypeString = "";
	        for (int i = 0; i < bizType.size(); i++) {
	        	if (i < bizType.size() - 1) {
	        		bizTypeString += bizType.get(i) + "|";
	        	} else {
	        		bizTypeString += bizType.get(i);
	        	}
	        }
	        user.setBizType(bizTypeString);
			boolean isSuccess = userService.update(user);
			if (isSuccess) {
                addActionMessage("更新用户" + user.toString() + "成功");
                return SUCCESS;
			} else {
				addActionError("更新用户" + user.toString() + "失败");
				return ERROR;
			}
		} else {
			return INPUT;
		}
	}

	public String edit() throws Exception {
		User currentUser = (User) ActionContext.getContext().getSession().get("LOGIN_USER");
		if (currentUser.getUserId().equals(user.getUserId()) || currentUser.isSuperAdmin() || currentUser.isOperationAdmin()) {
			user = userService.get(user);
			if (StringUtils.isNotEmpty(user.getBizType())) {
				String t = user.getBizType();
				this.bizType = new ArrayList<String>();
				if (t.indexOf("|") == -1) {
					this.bizType.add(t);
				} else {
					String[] temp = t.split("\\|");
					for (String s : temp) {
						this.bizType.add(s);
					}
				}
			}
			return SUCCESS;
		}
		return ERROR;
	}

	@Override
	public String execute() throws Exception {
        User loginUser = (User) ActionContext.getContext().getSession().get("LOGIN_USER");
		Page<User> instance = userService.getAll(page, pageSize, loginUser, user);
		ActionContext.getContext().put("LIST_USER", instance);
		return SUCCESS;
	}

	public String search() throws Exception {
        User loginUser = (User) ActionContext.getContext().getSession().get("LOGIN_USER");
        String bizTypeString = "";
        if (bizType != null && bizType.size() > 0) {
        	for (int i = 0; i < bizType.size(); i++) {
        		if (i < bizType.size() - 1) {
        			bizTypeString += bizType.get(i) + "|";
        		} else {
        			bizTypeString += bizType.get(i);
        		}
        	}
        }
        user.setBizType(bizTypeString);
        Page<User> instance = userService.getAll(page, pageSize, loginUser, user);
		ActionContext.getContext().put("LIST_USER", instance);
		return SUCCESS;
	}
	
	public String export() throws Exception {
		if (StringUtils.isNotEmpty(beginDate)) {
			user.setCreateTime(DateUtils.parseDate(beginDate, "yyyy-MM-dd"));
		}
        User loginUser = (User) ActionContext.getContext().getSession().get("LOGIN_USER");
        String bizTypeString = "";
        if (bizType != null && bizType.size() > 0) {
        	for (int i = 0; i < bizType.size(); i++) {
        		if (i < bizType.size() - 1) {
        			bizTypeString += bizType.get(i) + "|";
        		} else {
        			bizTypeString += bizType.get(i);
        		}
        	}
        }
        user.setBizType(bizTypeString);
        Page<User> instance = userService.getAll(page, 10000, loginUser, user);
		HSSFWorkbook workbook = ExcelUtils.export(instance.getContent(), LogService.USER_TYPE);
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		workbook.write(output);
		byte[] ba = output.toByteArray();  
        ByteArrayInputStream bais = new ByteArrayInputStream(ba);
        this.setExcelFile(bais);
		return SUCCESS;
	}

	public String login() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		String kaptcha = (String) session.get(Constants.KAPTCHA_SESSION_KEY);
		if (StringUtils.isBlank(user.getUserId())) {
			addActionError("用户名不能为空");
		} else if (StringUtils.isEmpty(user.getPassword())) {
			addActionError("密码不能为空");
		} else if (StringUtils.isEmpty(kaptchaField)) {
			addActionError("请输入验证码");
		} else if (StringUtils.isNotEmpty(kaptchaField) && !kaptchaField.equalsIgnoreCase(kaptcha)) {
			addActionError("验证码错误");
		} else {
			try {
				user = userService.logIn(user);
			} catch (Exception e) {
				this.addActionError(e.getMessage());
				return ERROR;
			}
			if (user == null) {
				addActionError("用户名或密码错误");
			} else if (user.isDefaultUser()){
				this.addActionMessage("抱歉，您没有操作权限！");
			} else {
				session.put("LOGIN_USER", user);
				return SUCCESS;
			}
		}
		return INPUT;
	}

	public String logout() throws Exception {
		ActionContext.getContext().getSession().remove("LOGIN_USER");
		return SUCCESS;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
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
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public List<String> getUserTypes() {
		return userTypes;
	}

	public void setUserTypes(List<String> userTypes) {
		this.userTypes = userTypes;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	
	public String getDownloadFileName() {
		String downloadFileName = (DateFormatUtils.format(Calendar.getInstance(), "yyyy-MM-dd")) + "用户列表.xls";
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

	public String getKaptchaField() {
		return kaptchaField;
	}

	public void setKaptchaField(String kaptchaField) {
		this.kaptchaField = kaptchaField;
	}
	
}
