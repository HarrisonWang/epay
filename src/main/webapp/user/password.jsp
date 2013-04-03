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
    <title>易点付后台管理系统-密码修改</title>
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
                <s:form action="password" namespace="/user" theme="simple" method="post" cssClass="form-horizontal">
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
                        <label class="control-label">旧密码</label>
                        <div class="controls">
                            <input type="password" class="input-meduim" name="password">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">新密码</label>
                        <div class="controls">
                            <input type="password" class="input-meduim" name="user.password">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">再次输入</label>
                        <div class="controls">
                            <input type="password" class="input-meduim" name="">
                            <input type="hidden" name="user.userId" value="<s:property value='#session.LOGIN_USER.userId' />">
                            <input type="hidden" name="user.accountId" value="<s:property value='#session.LOGIN_USER.accountId' />">
                            <input type="hidden" name="user.payPwd" value="<s:property value='#session.LOGIN_USER.payPwd' />">
                            <input type="hidden" name="user.type" value="<s:property value='#session.LOGIN_USER.type' />">
                            <input type="hidden" name="user.valid" value="<s:property value='#session.LOGIN_USER.valid' />">
                            <input type="hidden" name="user.areaCode" value="<s:property value='#session.LOGIN_USER.areaCode' />">
                            <input type="hidden" name="user.userName" value="<s:property value='#session.LOGIN_USER.userName' />">
                            <input type="hidden" name="user.phone" value="<s:property value='#session.LOGIN_USER.phone' />">
                            <input type="hidden" name="user.identityCard" value="<s:property value='#session.LOGIN_USER.identityCard' />">
                            <input type="hidden" name="user.userMac" value="<s:property value='#session.LOGIN_USER.userMac' />">
                            <input type="hidden" name="user.description" value="<s:property value='#session.LOGIN_USER.description' />">
                            <input type="hidden" name="updateType" value="1">
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
