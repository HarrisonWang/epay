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
            <div class="well span9">
                <s:form namespace="/charge" action="search" theme="simple" id="searchForm" cssClass="form-horizontal">
	                <div class="row-fluid">
	                    <div class="span4">
                            <div class="control-group">
                                <label class="control-label">开始日期</label>
                                <div class="controls">
                                    <input type="text" name="beginDate" class="input-meduim" value="<s:property value='beginDate'/>" id="beginDate">
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">结束日期</label>
                                <div class="controls">
                                    <input type="text" name="endDate" class="input-meduim" value="<s:property value='endDate'/>" id="endDate">
                                </div>
                            </div>
                        </div>
	                    <div class="span4">
                            <div class="control-group">
                                <label class="control-label">操作用户</label>
                                <div class="controls">
                                    <input type="text" id="userId" name="user.userId" class="input-meduim" value="<s:property value='user.userId'/>">
                                </div>
                            </div>
                        </div>
                    </div>
	                <div class="row-fluid">
	                    <div class="span4">
                            <div class="control-group">
                                <label class="control-label">充值账户</label>
                                <div class="controls">
                                    <input type="text" id="accountNumber" name="user.accountNumber" class="input-meduim" value="<s:property value='user.accountNumber'/>">
                                </div>
                            </div>
                        </div>
	                    <div class="span4">
                            <div class="control-group">
                                <label class="control-label">充值结果</label>
                                <div class="controls">
                                    <s:select id="status" name="status" cssClass="input-meduim" list="#{'-1':'所有', '0':'成功', '1':'失败'}" value="status" />
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">充值类型</label>
                                <div class="controls">
                                    <s:select id="bizType" name="bizType" cssClass="input-meduim" list="#{'-1':'所有', '0':'QQ币', '1':'黄金岛'}" value="bizType" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="pull-right">
                                <button type="submit" class="btn btn-primary">查询</button>
                                <button type="button" class="btn" id="btn-export" action="charge/export.action">导出</button>
                            </div>
                        </div>
                    </div>
                </s:form>
                <div style="margin-bottom: 20px;">
                    <s:if test="#LIST_FILL_LOGS.content.size != 0">
                        <span>当前预付款总额： <strong><s:property value="#MONEY"/></strong> 元</span>
                        <span class="pull-right">共查询到 <strong><s:property value="#LIST_FILL_LOGS.totalCount"/></strong> 条记录</span>
                    </s:if>
                </div>
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>账户ID</th>
                            <th>充值类型</th>
                            <th>充值金额</th>
                            <th>充值时间</th>
                            <th>充值结果</th>
                            <th>日志</th><!--
                            <th>操作用户</th>
                            <th>地市</th>
                        --></tr>
                    </thead>
                    <tbody>
                        <s:if test="#LIST_FILL_LOGS.content.size == 0">
                            <tr>
                                <td colspan="6" style="font-weight: bold;color: red;text-align: center;">很遗憾，没有找到您想要的，换个条件试试？</td>
                            </tr>
                        </s:if>
                        <s:iterator value="#LIST_FILL_LOGS.content" status="stat">
                            <tr>
                                <td><s:property value="#LIST_FILL_LOGS.beginIndex + #stat.count" /></td>
                                <td><s:property value="accountNumber" /></td>
                                <td>
                                    <s:if test="fillType == 0">QQ币</s:if>
                                    <s:elseif test="fillType == 1">黄金岛</s:elseif>
                                </td>
                                <td>￥<s:property value="amount" /></td>
                                <td><s:date name="time" format="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>
                                    <s:if test="result == 0">成功</s:if>
                                    <s:else>失败</s:else>
                                </td>
                                <td><s:property value="msg" /></td><!--
                                <td><s:property value="userId"/></td>
                                <td></td>
                            --></tr>
                        </s:iterator>
                    </tbody>
                </table>
                <div class="pagination pagination-right">
                    <ul>
                        <%-- 上一页 --%>
                        <s:if test="#LIST_FILL_LOGS.currentPage == #LIST_FILL_LOGS.previousPage">
                            <li class="disabled">
                                <a>«</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/charge" action="search">
                                    <s:param name="beginDate" value="beginDate"/>
                                    <s:param name="endDate" value="endDate"/>
                                    <s:param name="user.userId" value="user.userId"/>
                                    <s:param name="status" value="status"/>
                                    <s:param name="bizType" value="bizType"/>
                                    <s:param name="page" value="#LIST_FILL_LOGS.previousPage"/>«
                                </s:a>
                            </li>
                        </s:else>
                        <%-- 总页数不大于10页则全部显示 --%>
                        <s:if test="#LIST_FILL_LOGS.totalPage <= 10">
                            <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                <s:param name="first" value="1" />
                                <s:param name="last" value="#LIST_FILL_LOGS.totalPage" />
                                <s:iterator var="pageNumber">
                                    <s:if test="#pageNumber == #LIST_FILL_LOGS.currentPage">
                                        <li class="active">
                                            <a><s:property /></a>
                                        </li>
                                    </s:if><s:else>
                                        <li>
                                            <s:a namespace="/charge" action="search">
			                                    <s:param name="beginDate" value="beginDate"/>
			                                    <s:param name="endDate" value="endDate"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="status" value="status"/>
			                                    <s:param name="bizType" value="bizType"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:else>
                                </s:iterator>
                            </s:bean>
                        </s:if><s:else>
                            <%-- 当前页处于前五处理开始--%>
                            <s:if test="#LIST_FILL_LOGS.currentPage <= 5">
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="5" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #LIST_FILL_LOGS.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/charge" action="search">
				                                    <s:param name="beginDate" value="beginDate"/>
				                                    <s:param name="endDate" value="endDate"/>
				                                    <s:param name="user.userId" value="user.userId"/>
				                                    <s:param name="status" value="status"/>
				                                    <s:param name="bizType" value="bizType"/>
                                                    <s:param name="page" value="#pageNumber"/>
                                                    <s:property />
                                                </s:a>
                                            </li>
                                        </s:else>
                                    </s:iterator>
                                    <s:if test="#LIST_FILL_LOGS.currentPage == 5">
                                        <li>
                                            <s:a namespace="/charge" action="search">
			                                    <s:param name="beginDate" value="beginDate"/>
			                                    <s:param name="endDate" value="endDate"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="status" value="status"/>
			                                    <s:param name="bizType" value="bizType"/>
                                                <s:param name="page" value="#LIST_FILL_LOGS.currentPage+1"/>
                                                <s:property value="#LIST_FILL_LOGS.currentPage+1"/>
                                            </s:a>
                                        </li>
                                    </s:if>
                                </s:bean>
                                <li>
                                    <a>...</a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_FILL_LOGS.totalPage - 1" />
                                    <s:param name="last" value="#LIST_FILL_LOGS.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/charge" action="search">
			                                    <s:param name="beginDate" value="beginDate"/>
			                                    <s:param name="endDate" value="endDate"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="status" value="status"/>
			                                    <s:param name="bizType" value="bizType"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                </s:bean>
                            </s:if>
                            <%-- 当前页处于前五处理结束 --%>
                            
                            <%-- 当前页处于前五与后五之间开始 --%>
                            <s:elseif test="#LIST_FILL_LOGS.currentPage > 5 && #LIST_FILL_LOGS.currentPage < #LIST_FILL_LOGS.totalPage - 4">
                                <%-- 第一页和第二页页码 处理--%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="2" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/charge" action="search">
			                                    <s:param name="beginDate" value="beginDate"/>
			                                    <s:param name="endDate" value="endDate"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="status" value="status"/>
			                                    <s:param name="bizType" value="bizType"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                    <li>
                                        <a>...</a>
                                    </li>
                                </s:bean>
                                <%-- 添加当前页上一页页码 --%>
                                <li>
                                    <s:a namespace="/charge" action="search">
	                                    <s:param name="beginDate" value="beginDate"/>
	                                    <s:param name="endDate" value="endDate"/>
	                                    <s:param name="user.userId" value="user.userId"/>
	                                    <s:param name="status" value="status"/>
	                                    <s:param name="bizType" value="bizType"/>
                                         <s:param name="page" value="#LIST_FILL_LOGS.currentPage - 1"/>
                                         <s:property value="#LIST_FILL_LOGS.currentPage - 1"/>
                                    </s:a>
                                </li>
                                <li class="active">
                                    <a><s:property value="#LIST_FILL_LOGS.currentPage" /></a>
                                </li>
                                <%-- 添加当前页下一页页码 --%>
                                <li>
                                    <s:a namespace="/charge" action="search">
	                                    <s:param name="beginDate" value="beginDate"/>
	                                    <s:param name="endDate" value="endDate"/>
	                                    <s:param name="user.userId" value="user.userId"/>
	                                    <s:param name="status" value="status"/>
	                                    <s:param name="bizType" value="bizType"/>
                                         <s:param name="page" value="#LIST_FILL_LOGS.currentPage + 1"/>
                                         <s:property value="#LIST_FILL_LOGS.currentPage + 1"/>
                                    </s:a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_FILL_LOGS.totalPage - 1" />
                                    <s:param name="last" value="#LIST_FILL_LOGS.totalPage" />
                                    <li>
                                        <a>...</a>
                                    </li>
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/charge" action="search">
			                                    <s:param name="beginDate" value="beginDate"/>
			                                    <s:param name="endDate" value="endDate"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="status" value="status"/>
			                                    <s:param name="bizType" value="bizType"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                </s:bean>
                            </s:elseif>
                            <%-- 当前页处于前五与后五之间结束 --%>
                            
                            <%-- 当前页处于后五处理开始 --%>
                            <s:else>
                                <%-- 默认显示第一页和第二页页码 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="2" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/charge" action="search">
			                                    <s:param name="beginDate" value="beginDate"/>
			                                    <s:param name="endDate" value="endDate"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="status" value="status"/>
			                                    <s:param name="bizType" value="bizType"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                    <li>
                                        <a>...</a>
                                    </li>
                                </s:bean>
                                <%-- 处于倒数第五页页码处理，加入倒数第六页页码 --%>
                                <s:if test="#LIST_FILL_LOGS.currentPage == #LIST_FILL_LOGS.totalPage - 4">
                                    <li>
                                        <s:a namespace="/charge" action="search">
		                                    <s:param name="beginDate" value="beginDate"/>
		                                    <s:param name="endDate" value="endDate"/>
		                                    <s:param name="user.userId" value="user.userId"/>
		                                    <s:param name="status" value="status"/>
		                                    <s:param name="bizType" value="bizType"/>
                                            <s:param name="page" value="#LIST_FILL_LOGS.currentPage-1"/>
                                            <s:property value="#LIST_FILL_LOGS.currentPage-1"/>
                                        </s:a>
                                    </li>
                                </s:if>
                                <%-- 最后五页处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_FILL_LOGS.totalPage - 4" />
                                    <s:param name="last" value="#LIST_FILL_LOGS.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #LIST_FILL_LOGS.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/charge" action="search">
				                                    <s:param name="beginDate" value="beginDate"/>
				                                    <s:param name="endDate" value="endDate"/>
				                                    <s:param name="user.userId" value="user.userId"/>
				                                    <s:param name="status" value="status"/>
				                                    <s:param name="bizType" value="bizType"/>
                                                    <s:param name="page" value="#pageNumber"/>
                                                    <s:property />
                                                </s:a>
                                            </li>
                                        </s:else>
                                    </s:iterator>
                                </s:bean>
                            </s:else>
                            <%-- 当前页处于后五处理结束 --%>
                            
                        </s:else>
                        
                        <%-- 下一页开始 --%>
                        <s:if test="#LIST_FILL_LOGS.totalCount == 0 || #LIST_FILL_LOGS.currentPage == #LIST_FILL_LOGS.nextPage">
                            <li class="disabled">
                                <a>»</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/charge" action="search">
                                    <s:param name="beginDate" value="beginDate"/>
                                    <s:param name="endDate" value="endDate"/>
                                    <s:param name="user.userId" value="user.userId"/>
                                    <s:param name="status" value="status"/>
                                    <s:param name="bizType" value="bizType"/>
                                    <s:param name="page" value="#LIST_FILL_LOGS.nextPage"/>»
                                </s:a>
                            </li>
                        </s:else>
                        <%-- 下一页结束 --%>

                   </ul>
                </div>
            </div>
        </div>
    <s:include value="/common/footer.jsp" />
    </div>
</body>
</html>
