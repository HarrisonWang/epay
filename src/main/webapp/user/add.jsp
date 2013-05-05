<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>易点付后台管理系统-用户新增</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.css">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.1.custom.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/epay.js"></script>
</head>
<body>
    <s:include value="/common/header.jsp" />
    <div class="container-fluid">
        <div class="row-fluid">
            <s:include value="/common/sidebar.jsp" />
            <div class="well span9">
                <s:form action="save" namespace="/user" theme="simple" method="post" cssClass="form-horizontal">
                    <s:if test="hasActionMessages()">
                        <div class="alert alert-success">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <s:property value="actionMessages[0]" />
                        </div>
                    </s:if>
                    <s:elseif test="hasActionErrors()">
                        <div class="alert alert-error">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <s:property value="actionErrors[0]" />
                        </div>
                    </s:elseif>
                    <s:elseif test="hasFieldErrors()">
                        <div class="alert alert-error">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <s:property value="fieldErrors[0]" />
                        </div>
                    </s:elseif>
                    <div class="control-group">
                        <label class="control-label">用户ID<span class="must">*</span></label>
                        <div class="controls">
                            <input type="text" class="input-meduim" name="user.userId">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">登录密码<span class="must">*</span></label>
                        <div class="controls">
                            <input type="password" class="input-meduim" name="user.password">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">重复密码<span class="must">*</span></label>
                        <div class="controls">
                            <input type="password" class="input-meduim" name="">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">绑定账户<span class="must">*</span></label>
                        <div class="controls">
                            <s:action var="list" name="list" namespace="/account" />
                            <s:select name="user.accountId" list="#list.accounts" listKey="id" listValue="accountNumber"/>
                        </div>
                    </div>
                    <div class="control-group">
                         <label class="control-label">业务类型<span class="must">*</span></label>
                         <label class="checkbox inline" style="width: 42px; padding-left: 40px;">
                             <input type="checkbox" name="bizType" value="1">QQ币
                         </label>
                         <label class="checkbox inline" style="width: 42px;padding-left: 10px;">
                             <input type="checkbox" name="bizType" value="2">黄金岛
                         </label>
                    </div>
                    <div class="control-group">
                        <label class="control-label">支付密码</label>
                        <div class="controls">
                            <input type="password" class="input-meduim" name="user.payPwd">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">用户类型<span class="must">*</span></label>
                        <div class="controls">
                            <select class="input-meduim" name="user.type">
	                            <s:if test="#session.LOGIN_USER.type == 1">
									<option value="1">管理员</option>
	                            </s:if>
								<option value="2">操作管理员</option>
								<option value="3">财务管理员</option>
								<option value="0" selected="selected">普通用户</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">状态<span class="must">*</span></label>
                        <div class="controls">
                            <select class="input-meduim" name="user.valid">
								<option value="0" selected="selected">有效</option>
								<option value="1">无效</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">地市<span class="must">*</span></label>
                        <div class="controls">
                            <s:select name="user.areaCode" list="#{'0731':'长沙市', '0733':'株洲市','0732':'湘潭市', '0734':'衡阳市','0739':'邵阳市', '0730':'岳阳市',  '0736':'常德市', '0744':'张家界','0737':'益阳市','0735':'郴州市', '0746':'永州市', '0745':'怀化市', '0738':'娄底市', '0743':'湘西州'}" value="user.areaCode" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">姓名</label>
                        <div class="controls">
                            <input type="text" class="input-meduim" name="user.userName">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">联系电话</label>
                        <div class="controls">
                            <input type="text" class="input-xlarge" name="user.phone">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">身份证号<span class="must">*</span></label>
                        <div class="controls">
                            <input type="text" class="input-xxlarge" name="user.identityCard">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">MAC</label>
                        <div class="controls">
                            <input type="text" class="input-xxlarge" name="user.userMac">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">描述</label>
                        <div class="controls">
                            <textarea rows="3" class="input-xxlarge" name="user.description"></textarea>
                        </div>
                    </div>
                    <div class="control-group">
	                    <div class="controls controls-row">
	                        <button type="submit" class="btn btn-primary">保存</button>
		                    <button type="button" class="btn" id="btn-back">返回</button>
	                    </div>
                    </div>
                </s:form>
            </div>
        </div>
        <s:include value="/common/footer.jsp" />
    </div>
</body>
</html>
