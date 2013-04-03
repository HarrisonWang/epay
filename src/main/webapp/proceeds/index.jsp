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
    <title>易点付后台管理系统-打款管理</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.css">
    <style type="text/css">
    #btns {
        margin-top: 24px;
    }
    </style>
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.1.custom.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/epay.js"></script>
    <script type="text/javascript">
    $(function() {
        $("#proceeds-export").click(function() {
            var url = $(this).attr("action") + "?proceeds.beginDate=" + $("#beginDate").val() + "&proceeds.endDate=" + $("#endDate").val() + "&proceeds.accountName=" + $("#accountName").val() + "&proceeds.bizType=" + $("#bizType").val();
            window.location.href = url;
        });
    });
    </script>
</head>
<body>
    <s:include value="/common/header.jsp" />
    <div class="container-fluid">
        <div class="row-fluid">
            <s:include value="/common/sidebar.jsp" />
            <div class="well span9">
                <s:form id="searchForm" namespace="/proceeds" action="search" theme="simple" cssClass="form-horizontal">

                    <div class="row-fluid">
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">开始时间</label>
                                <div class="controls">
                                    <input type="text" name="proceeds.beginDate" id="beginDate" class="input-meduim">
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">结束时间</label>
                                <div class="controls">
                                    <input type="text" name="proceeds.endDate" id="endDate" class="input-meduim">
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">账户名</label>
                                <div class="controls">
                                    <input type="text" id="accountName" name="proceeds.accountName">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span6">
                            <div class="control-group">
                                <label class="control-label">业务</label>
                                <div class="controls">
		                            <s:select id="bizType" name="proceeds.bizType" list="#{'-1': '所有', '0':'QQ币', '1':'黄金岛'}"/>
                                </div>
                            </div>
                        </div>
                        <div class="span6">
                            <div class="control-group">
                                <div class="controls pull-right">
		                            <button type="submit" class="btn btn-primary">查询</button>
		                            <button type="button" id="proceeds-export" action="proceeds/export.action" class="btn">导出</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </s:form>
                <div style="margin-bottom: 20px;">
                    <s:if test="#PROCEEDS_LIST.content.size != 0">
                        <span>当前打款总额：<strong><s:property value="#MONEY"/></strong> 元</span>
                        <span class="pull-right">共查询到 <strong><s:property value="#PROCEEDS_LIST.totalCount"/></strong> 条记录</span>
                    </s:if>
                </div>
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>新增日期</th>
                            <th>账户名</th>
                            <th>业务名称</th>
                            <th>打款金额</th>
                            <th>打款日期</th>
                            <!-- <th>操作</th> -->
                        </tr>
                    </thead>
                    <tbody>
                        <s:if test="#PROCEEDS_LIST.content.size == 0">
                            <tr>
                                <td colspan="6" style="font-weight: bold;color: red;text-align: center;">很遗憾，当前没有打款信息！</td>
                            </tr>
                        </s:if>
                        <s:iterator value="#PROCEEDS_LIST.content" status="stat">
                            <tr>
                                <td>
                                    <s:property value="#PROCEEDS_LIST.beginIndex + #stat.count" />
                                </td>
                                <td>
                                    <s:property value="createTime"/>
                                </td>
                                <td>
                                    <s:property value="accountName"/>
                                </td>
                                <td>
                                    <s:if test="bizType == 0"> QQ币 </s:if>
                                    <s:elseif test="bizType == 1">黄金岛</s:elseif>
                                </td>
                                <td>
                                    <s:property value="transferMoney"/>
                                </td>
                                <td>
                                    <s:property value="transferDate"/>
                                </td>
                                <!-- 
                                <td>
                                    <s:a action="edit?fee.areaCode=%{areaCode}" namespace="/fee" title="编辑">
                                        <i class="icon-edit"></i>
                                    </s:a>
                                    <a onclick="deleteFee('<s:property value="areaCode" />', '<s:property value="#session.LOGIN_USER.userId" />')" href="javascript:;" title="删除">
                                        <i class="icon-remove"></i>
                                    </a>
                                </td>
                                 -->
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
                <div class="pagination pagination-right">
                    <ul>
                        <%-- 上一页 --%>
                        <s:if test="#PROCEEDS_LIST.currentPage == #PROCEEDS_LIST.previousPage">
                            <li class="disabled">
                                <a>«</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/proceeds" action="index">
                                    <s:param name="page" value="#PROCEEDS_LIST.previousPage"/>«
                                </s:a>
                            </li>
                        </s:else>
                        <%-- 总页数不大于10页则全部显示 --%>
                        <s:if test="#PROCEEDS_LIST.totalPage <= 10">
                            <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                <s:param name="first" value="1" />
                                <s:param name="last" value="#PROCEEDS_LIST.totalPage" />
                                <s:iterator var="pageNumber">
                                    <s:if test="#pageNumber == #PROCEEDS_LIST.currentPage">
                                        <li class="active">
                                            <a><s:property /></a>
                                        </li>
                                    </s:if><s:else>
                                        <li>
                                            <s:a namespace="/proceeds" action="index">
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:else>
                                </s:iterator>
                            </s:bean>
                        </s:if><s:else>
                            <%-- 当前页处于前五处理开始--%>
                            <s:if test="#PROCEEDS_LIST.currentPage <= 5">
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="5" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #PROCEEDS_LIST.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/proceeds" action="index">
                                                    <s:param name="page" value="#pageNumber"/>
                                                    <s:property />
                                                </s:a>
                                            </li>
                                        </s:else>
                                    </s:iterator>
                                    <s:if test="#PROCEEDS_LIST.currentPage == 5">
                                        <li>
                                            <s:a namespace="/proceeds" action="index">
                                                <s:param name="page" value="#PROCEEDS_LIST.currentPage+1"/>
                                                <s:property value="#PROCEEDS_LIST.currentPage+1"/>
                                            </s:a>
                                        </li>
                                    </s:if>
                                </s:bean>
                                <li>
                                    <a>...</a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#PROCEEDS_LIST.totalPage - 1" />
                                    <s:param name="last" value="#PROCEEDS_LIST.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/proceeds" action="index">
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                </s:bean>
                            </s:if>
                            <%-- 当前页处于前五处理结束 --%>
                            
                            <%-- 当前页处于前五与后五之间开始 --%>
                            <s:elseif test="#PROCEEDS_LIST.currentPage > 5 && #PROCEEDS_LIST.currentPage < #PROCEEDS_LIST.totalPage - 4">
                                <%-- 第一页和第二页页码 处理--%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="2" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/proceeds" action="index">
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
                                    <s:a namespace="/proceeds" action="index">
                                         <s:param name="page" value="#PROCEEDS_LIST.currentPage - 1"/>
                                         <s:property value="#PROCEEDS_LIST.currentPage - 1"/>
                                    </s:a>
                                </li>
                                <li class="active">
                                    <a><s:property value="#PROCEEDS_LIST.currentPage" /></a>
                                </li>
                                <%-- 添加当前页下一页页码 --%>
                                <li>
                                    <s:a namespace="/proceeds" action="index">
                                         <s:param name="page" value="#PROCEEDS_LIST.currentPage + 1"/>
                                         <s:property value="#PROCEEDS_LIST.currentPage + 1"/>
                                    </s:a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#PROCEEDS_LIST.totalPage - 1" />
                                    <s:param name="last" value="#PROCEEDS_LIST.totalPage" />
                                    <li>
                                        <a>...</a>
                                    </li>
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/proceeds" action="index">
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
                                            <s:a namespace="/proceeds" action="index">
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
                                <s:if test="#PROCEEDS_LIST.currentPage == #PROCEEDS_LIST.totalPage - 4">
                                    <li>
                                        <s:a namespace="/proceeds" action="index">
                                            <s:param name="page" value="#PROCEEDS_LIST.currentPage-1"/>
                                            <s:property value="#PROCEEDS_LIST.currentPage-1"/>
                                        </s:a>
                                    </li>
                                </s:if>
                                <%-- 最后五页处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#PROCEEDS_LIST.totalPage - 4" />
                                    <s:param name="last" value="#PROCEEDS_LIST.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #PROCEEDS_LIST.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/proceeds" action="index">
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
                        <s:if test="#PROCEEDS_LIST.totalCount == 0 || #PROCEEDS_LIST.currentPage == #PROCEEDS_LIST.nextPage">
                            <li class="disabled">
                                <a>»</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/proceeds" action="index">
                                    <s:param name="page" value="#PROCEEDS_LIST.nextPage"/>»
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
