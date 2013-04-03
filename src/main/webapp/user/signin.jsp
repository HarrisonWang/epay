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
    <title>易点付后台管理系统-用户登录</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <style type="text/css">
      html {
        height: 100%;
      }
    
      body {
        background-color: #f5f5f5;
        height: 100%;
        margin: 0;
      }
      
      .container {
        min-height: 100%;
        height: auto;
        position: relative;
      }
      
      .header {
        height: 40px;
      }
      
      .content {
        position: relative;
      }
      
      footer {
        position: absolute;
        bottom: 0;
        width: 100%;
        padding: 10px 0;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }

	#kaptcha {
	    cursor: pointer;
	}
    </style>
    <link rel="stylesheet" href="css/bootstrap-responsive.css">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.1.custom.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/epay.js"></script>
</head>
<body>
    <div class="container">
        <div class="header"></div>
        <div class="content">
	        <s:form action="login" namespace="/user" method="post" theme="simple" cssClass="form-signin">
	            <s:if test="hasActionErrors()">
	                <div class="alert alert-error">
	                    <button type="button" class="close" data-dismiss="alert">×</button>
	                    <s:property value="actionErrors[0]" />
	                </div>
	            </s:if>
                <s:if test="hasActionMessages()">
                    <div class="alert alert-error">
                        <button type="button" class="close" data-dismiss="alert">×</button>
                        <s:property value="actionMessages[0]" />
                    </div>
                </s:if>
	            <h3 class="form-signin-heading">易点付后台管理系统</h3>
	            <input type="text" name="user.userId" class="input-block-level" placeholder="用户名">
	            <input type="password" name="user.password" class="input-block-level" placeholder="密码">
	            <input type="text" name="kaptchaField" class="input-block-level" placeholder="看不清楚？单击图片刷新！">
	            <div class="popover fade right in" style="top: 161.5px; left: 735px; display: block;">
	               <div class="arrow"></div>
	               <div class="popover-inner">
	                   <h3 class="popover-title">请输入下方的验证码</h3>
	                   <div class="popover-content">
	                       <p><img id="kaptcha" title="点我刷新" src="Kaptcha.jpg"></p>
	                   </div>
	               </div>
	            </div>
	            <label class="checkbox">
	                <input type="checkbox" value="下次自动登录"> 下次自动登录
	            </label>
	            <button id="login-btn" class="btn btn-large btn-primary" data-loading-text="登录中..." type="submit">登录</button>
	        </s:form>
        </div>
	    <s:include value="/common/footer.jsp" />
    </div>
</body>
</html>