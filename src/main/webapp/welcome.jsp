<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>易点付后台管理系统-预付款查询</title>
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
            <div class="span9">
                <div class="hero-unit">
                    <h3>尊敬的用户<s:property value="#session.LOGIN_USER.userId"/>你好，欢迎登录易点付后台管理系统！ </h3>
                    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;易点付平台是应用于游戏运营、话费充值等多项业务的在线支付充值平台，采用最简单便捷的接入方式，一点击即自动完成兑换游戏里虚拟货币、一点击即可自动完成话费充值等操作的新一代自动化充值平台。 </p>
                    <p><a class="btn btn-primary btn-large" target="_blank" href="http://www.1dianpay.com/retail/introduce.jsp">了解更多 »</a></p>
                </div>
            </div>
        </div>
    <s:include value="/common/footer.jsp" />
    </div>
</body>
</html>
