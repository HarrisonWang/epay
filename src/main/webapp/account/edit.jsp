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
    <title>易点付后台管理系统-编辑账户</title>
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
                <s:form action="update" namespace="/account" theme="simple" method="post" cssClass="form-horizontal">
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
                        <label class="control-label">账户名</label>
                        <div class="controls">
                            <input type="text" name="account.accountNumber" value="<s:property value='account.accountNumber' />" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">账户总金额</label>
                        <div class="controls">
                            ￥<s:property value='account.amount' />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">已用金额</label>
                        <div class="controls">
                            ￥<s:property value='account.useAmount' />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">余额</label>
                        <div class="controls">
                            ￥<s:property value='account.balance' />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">账户级别（游戏）</label>
                        <div class="controls">
                            <s:select label="账户级别（游戏）"
                                name="account.game.level"
                                list="#{'1':'1级', '2':'2级', '3':'3级'}"
                                value="account.game.level" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">账户级别（话费）</label>
                        <div class="controls">
                            <s:select label="账户级别（话费）"
                                name="account.telephoneCharge.level"
                                list="#{'1':'1级', '2':'2级', '3':'3级'}"
                                value="account.telephoneCharge.level" />
                            <s:hidden name="account.id" />
                            <s:hidden name="account.balance" />
                            <s:hidden name="account.useAmount" />
                            <s:hidden name="account.amount" />
				            <s:hidden name="account.game.type" />
				            <s:hidden name="account.game.accountId" value="%{account.id}" />
				            <s:hidden name="account.telephoneCharge.type"/>
				            <s:hidden name="account.telephoneCharge.accountId" value="%{account.id}"/>
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
