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
    <title>易点付后台管理系统-账户查询</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.css">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.1.custom.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/epay.js"></script>
    <script type="text/javascript">
    function deleteAccount(ele, optionUser) {
        if (window.confirm("尊敬的" + optionUser + "用户，您好，您是否确认删除该条记录，点击确认后无法找回，谢谢！")) {
            location.href = "account/delete.action?account.id=" + ele;
            return true;
        }
        return false;
    }
    </script>
</head>
<body>
    <s:include value="/common/header.jsp" />
    <div class="container-fluid">
        <div class="row-fluid">
            <s:include value="/common/sidebar.jsp" />
            <div class="well span9">
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th rowspan="2">序号</th>
                            <th rowspan="2">账户</th>
                            <th colspan="3">QQ币</th>
                            <th colspan="3">黄金岛</th>
                            <th rowspan="2">创建时间</th>
                            <th rowspan="2">操作</th>
                        </tr>
                        <tr>
                            <th>总金额</th>
                            <th>已用</th>
                            <th>余额</th>
                            <th>总金额</th>
                            <th>已用</th>
                            <th>余额</th>
                        </tr>
                    </thead>
                    <tbody>
						<s:iterator value="#LIST_ACCOUNT.content" status="stat">
							<tr>
								<td>
                                    <s:property value="#LIST_ACCOUNT.beginIndex + #stat.count" />
								</td>
								<td><s:property value="accountNumber" /></td>
                                <td>￥<s:property value="amount" /></td>
                                <td>￥<s:property value="useAmount" /></td>
                                <td>￥<s:property value="balance" /></td>
                                <td>￥<s:property value="account_amount_hjd" /></td>
                                <td>￥<s:property value="account_useamount_hjd" /></td>
                                <td>￥<s:property value="account_balance_hjd" /></td>
								<td><s:property value="createTime"/></td>
								<td>
									<s:a action="edit?account.id=%{id}" namespace="/account" title="编辑">
                                        <i class="icon-edit"></i>
									</s:a>
									<a href="charge/recharge.jsp?accountId=<s:property value='id' />" title="账户充值">
                                        <i class="icon-hand-left"></i>
									</a>
									<a onclick="deleteAccount('<s:property value="id" />', '<s:property value="#session.LOGIN_USER.userId" />')" href="javascript:;" title="删除">
                                        <i class="icon-remove"></i>
									</a>
								</td>
							</tr>
						</s:iterator>
                    </tbody>
                </table>
                <div class="pagination pagination-right">
                    <ul>
                        <%-- 上一页 --%>
                        <s:if test="#LIST_ACCOUNT.currentPage == #LIST_ACCOUNT.previousPage">
                            <li class="disabled">
                                <a>«</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/account" action="index">
                                    <s:param name="page" value="#LIST_ACCOUNT.previousPage"/>«
                                </s:a>
                            </li>
                        </s:else>
                        <%-- 总页数不大于10页则全部显示 --%>
                        <s:if test="#LIST_ACCOUNT.totalPage <= 10">
                            <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                <s:param name="first" value="1" />
                                <s:param name="last" value="#LIST_ACCOUNT.totalPage" />
                                <s:iterator var="pageNumber">
                                    <s:if test="#pageNumber == #LIST_ACCOUNT.currentPage">
                                        <li class="active">
                                            <a><s:property /></a>
                                        </li>
                                    </s:if><s:else>
                                        <li>
                                            <s:a namespace="/account" action="index">
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:else>
                                </s:iterator>
                            </s:bean>
                        </s:if><s:else>
                            <%-- 当前页处于前五处理开始--%>
                            <s:if test="#LIST_ACCOUNT.currentPage <= 5">
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="5" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #LIST_ACCOUNT.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/account" action="index">
                                                    <s:param name="page" value="#pageNumber"/>
                                                    <s:property />
                                                </s:a>
                                            </li>
                                        </s:else>
                                    </s:iterator>
                                    <s:if test="#LIST_ACCOUNT.currentPage == 5">
                                        <li>
                                            <s:a namespace="/account" action="index">
                                                <s:param name="page" value="#LIST_ACCOUNT.currentPage+1"/>
                                                <s:property value="#LIST_ACCOUNT.currentPage+1"/>
                                            </s:a>
                                        </li>
                                    </s:if>
                                </s:bean>
                                <li>
                                    <a>...</a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_ACCOUNT.totalPage - 1" />
                                    <s:param name="last" value="#LIST_ACCOUNT.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/account" action="index">
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                </s:bean>
                            </s:if>
                            <%-- 当前页处于前五处理结束 --%>
                            
                            <%-- 当前页处于前五与后五之间开始 --%>
                            <s:elseif test="#LIST_ACCOUNT.currentPage > 5 && #LIST_ACCOUNT.currentPage < #LIST_ACCOUNT.totalPage - 4">
                                <%-- 第一页和第二页页码 处理--%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="2" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/account" action="index">
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
                                    <s:a namespace="/account" action="index">
                                         <s:param name="page" value="#LIST_ACCOUNT.currentPage - 1"/>
                                         <s:property value="#LIST_ACCOUNT.currentPage - 1"/>
                                    </s:a>
                                </li>
                                <li class="active">
                                    <a><s:property value="#LIST_ACCOUNT.currentPage" /></a>
                                </li>
                                <%-- 添加当前页下一页页码 --%>
                                <li>
                                    <s:a namespace="/account" action="index">
                                         <s:param name="page" value="#LIST_ACCOUNT.currentPage + 1"/>
                                         <s:property value="#LIST_ACCOUNT.currentPage + 1"/>
                                    </s:a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_ACCOUNT.totalPage - 1" />
                                    <s:param name="last" value="#LIST_ACCOUNT.totalPage" />
                                    <li>
                                        <a>...</a>
                                    </li>
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/account" action="index">
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
                                            <s:a namespace="/account" action="index">
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
                                <s:if test="#LIST_ACCOUNT.currentPage == #LIST_ACCOUNT.totalPage - 4">
                                    <li>
                                        <s:a namespace="/account" action="index">
                                            <s:param name="page" value="#LIST_ACCOUNT.currentPage-1"/>
                                            <s:property value="#LIST_ACCOUNT.currentPage-1"/>
                                        </s:a>
                                    </li>
                                </s:if>
                                <%-- 最后五页处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_ACCOUNT.totalPage - 4" />
                                    <s:param name="last" value="#LIST_ACCOUNT.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #LIST_ACCOUNT.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/account" action="index">
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
                        <s:if test="#LIST_ACCOUNT.totalCount == 0 || #LIST_ACCOUNT.currentPage == #LIST_ACCOUNT.nextPage">
                            <li class="disabled">
                                <a>»</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/account" action="index">
                                    <s:param name="page" value="#LIST_ACCOUNT.nextPage"/>»
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
