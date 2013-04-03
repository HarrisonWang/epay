<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
            <div class="well span3">
                <div class="sidebar-nav">
                    <ul id="sidebar" class="nav nav-list">
                        <s:if test="#session.LOGIN_USER.type == 1 || #session.LOGIN_USER.type == 2">
	                        <li class="nav-header">用户管理</li>
	                        <li>
	                            <s:a namespace="/user" action="index">用户列表</s:a>
	                        </li>
	                        <li>
	                            <a href="user/add.jsp">新增用户</a>
	                        </li>
	                    </s:if>
	                    <s:if test="#session.LOGIN_USER.type == 1 || #session.LOGIN_USER.type == 2">
	                        <li class="nav-header">账户管理</li>
	                        <li>
	                            <s:a action="index" namespace="/account">账户列表</s:a>
	                        </li>
	                        <li>
	                            <a href="account/add.jsp">新增账户</a>
	                        </li>
	                    </s:if>
	                    <s:if test="#session.LOGIN_USER.type == 1 || #session.LOGIN_USER.type == 3">
	                        <li class="nav-header">预付款管理</li>
	                        <li>
	                            <a href="charge/recharge.jsp">预付款充值</a>
	                        </li>
	                        <li>
	                            <s:a namespace="/charge" action="index">预付款查询</s:a>
	                        </li>
	                    </s:if>
	                    <s:if test="#session.LOGIN_USER.type == 1 || #session.LOGIN_USER.type == 3">
                            <li class="nav-header">打款管理</li>
                            <li>
                                <a href="proceeds/add.jsp">新增打款</a>
                            </li>
                            <li>
                                <s:a namespace="proceeds" action="index">打款查询</s:a>
                            </li>
                        </s:if>
	                    <s:if test="#session.LOGIN_USER.type == 1 || #session.LOGIN_USER.type == 2 || #session.LOGIN_USER.type == 3">
	                        <li class="nav-header">交易管理</li>
	                        <li>
	                            <s:a namespace="/transaction" action="index">交易查询</s:a>
	                        </li>
	                        <li>
	                            <a href="transaction/statistics.jsp">交易统计</a> 
	                        </li>
                        </s:if>
                        
                        <s:if test="#session.LOGIN_USER.type == 1">
	                        <li class="nav-header">字符串管理</li>
	                        <li>
	                            <a href="qode/import.jsp">字符串导入</a>
	                        </li>
	                        <li>
	                            <s:a namespace="/qode" action="index">字符串查询</s:a>
	                        </li>
	                        <li class="nav-header">限费管理</li>
	                        <li>
	                            <s:a namespace="/fee" action="index">限费列表</s:a>
	                        </li>
	                        <li>
	                            <a href="fee/add.jsp">限费新增</a>
	                        </li>
                        </s:if>
                        
                        
                    </ul>
                </div>
            </div>