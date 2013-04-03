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
    <title>易点付后台管理系统-预付款充值</title>
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
                <s:form action="recharge" namespace="/charge" theme="simple" method="post" cssClass="form-horizontal">
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
                        <s:action var="list" name="list" namespace="/account" />
                        <label class="control-label">选择账户</label>
                        <div class="controls">
                            <s:if test="#parameters.accountId[0].equals('')">
                                <s:select name="account.id" list="#list.accounts" listKey="id" listValue="accountNumber" />
                            </s:if><s:else>
                                <s:select name="account.id" list="#list.accounts" listKey="id" listValue="accountNumber" value="#parameters.accountId[0]" />
                            </s:else>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">业务类型</label>
                        <div class="controls">
                            <select name="bizType">
                                <option value="0">QQ币</option>
                                <option value="1">黄金岛</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">充值金额</label>
                        <div class="controls">
                            <input class="input-meduim" type="text" name="amount" placeholder=""/>
                            <p class="help-block">扣款请输入负数（如：-99）</p>
                        </div>
                    </div>
                    <div class="control-group">
	                    <div class="controls controls-row">
	                        <button type="submit" class="btn btn-primary">充值</button>
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
