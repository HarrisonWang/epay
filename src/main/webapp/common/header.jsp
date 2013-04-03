<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <s:a href="welcome.jsp" cssClass="brand">易点付后台管理系统</s:a>
                <%--<a class="brand" target="_blank" href="http://www.1dianpay.com/retail/introduce.jsp">易点付后台管理系统</a>--%>
                <div class="nav-collapse">
                    <p class="navbar-text pull-right">
                        <s:a href="user/profile.jsp" cssClass="btn btn-link"><i class="icon-user"></i> 个人资料</s:a>
                        <s:a href="user/password.jsp" cssClass="btn btn-link" cssStyle="color:#0088cc"><i class="icon-edit"></i> 修改密码</s:a>
                        <s:a action="logout" namespace="/user" title="Sign Out" cssClass="btn btn-link"><i class="icon-off"></i> 退出</s:a>
                    </p>
                </div>
            </div>
        </div>
    </div>