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
    <title>易点付后台管理系统-限费管理</title>
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
    function deleteFee(areaCode, type, optionUser) {
        if (window.confirm("尊敬的" + optionUser + "用户，您好，您是否确认删除该条记录，点击确认后无法找回，谢谢！")) {
            location.href = "fee/delete.action?fee.areaCode=" + areaCode + "&fee.type=" + type;
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
                            <th>序号</th>
                            <th>业务名称</th>
<!-- 
                            <th>子业务名称</th>
 -->
                            <th>地市</th>
                            <th>区号</th>
<!-- 
                            <th>限费周期</th>
                            <th>限费金额</th>
                            <th>其他维度</th>
 -->
                            <th>限费金额</th>
<!-- 
                            <th>状态</th>
 -->
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:iterator value="#FEE_LIST.content" status="stat">
                            <tr>
                                <td>
                                    <s:property value="#FEE_LIST.beginIndex + #stat.count" />
                                </td>
                                <td>
                                    <s:if test="type == 0">QQ币</s:if>
                                    <s:elseif test="type == 1">黄金岛</s:elseif>
                                </td>
                                <td>
                                    <s:property value="city"/>
                                </td>
                                <td>
                                    <s:property value="areaCode"/>
                                </td>
                                <td> ￥<s:property value="sx"/> </td>
                                <td>
                                    <s:a action="edit?fee.areaCode=%{areaCode}&fee.type=%{type}" namespace="/fee" title="编辑">
                                        <i class="icon-edit"></i>
                                    </s:a>
                                    <a onclick="deleteFee('<s:property value="areaCode" />', '<s:property value="type" />', '<s:property value="#session.LOGIN_USER.userId" />')" href="javascript:;" title="删除">
                                        <i class="icon-remove"></i>
                                    </a>
                                </td>
<!-- 
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
 -->
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
                <div class="pagination pagination-right">
                    <ul>
                        <%-- 上一页 --%>
                        <s:if test="#FEE_LIST.currentPage == #FEE_LIST.previousPage">
                            <li class="disabled">
                                <a>«</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/fee" action="index">
                                    <s:param name="page" value="#FEE_LIST.previousPage"/>«
                                </s:a>
                            </li>
                        </s:else>
                        <%-- 总页数不大于10页则全部显示 --%>
                        <s:if test="#FEE_LIST.totalPage <= 10">
                            <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                <s:param name="first" value="1" />
                                <s:param name="last" value="#FEE_LIST.totalPage" />
                                <s:iterator var="pageNumber">
                                    <s:if test="#pageNumber == #FEE_LIST.currentPage">
                                        <li class="active">
                                            <a><s:property /></a>
                                        </li>
                                    </s:if><s:else>
                                        <li>
                                            <s:a namespace="/fee" action="index">
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:else>
                                </s:iterator>
                            </s:bean>
                        </s:if><s:else>
                            <%-- 当前页处于前五处理开始--%>
                            <s:if test="#FEE_LIST.currentPage <= 5">
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="5" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #FEE_LIST.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/fee" action="index">
                                                    <s:param name="page" value="#pageNumber"/>
                                                    <s:property />
                                                </s:a>
                                            </li>
                                        </s:else>
                                    </s:iterator>
                                    <s:if test="#FEE_LIST.currentPage == 5">
                                        <li>
                                            <s:a namespace="/fee" action="index">
                                                <s:param name="page" value="#FEE_LIST.currentPage+1"/>
                                                <s:property value="#FEE_LIST.currentPage+1"/>
                                            </s:a>
                                        </li>
                                    </s:if>
                                </s:bean>
                                <li>
                                    <a>...</a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#FEE_LIST.totalPage - 1" />
                                    <s:param name="last" value="#FEE_LIST.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/fee" action="index">
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                </s:bean>
                            </s:if>
                            <%-- 当前页处于前五处理结束 --%>
                            
                            <%-- 当前页处于前五与后五之间开始 --%>
                            <s:elseif test="#FEE_LIST.currentPage > 5 && #FEE_LIST.currentPage < #FEE_LIST.totalPage - 4">
                                <%-- 第一页和第二页页码 处理--%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="2" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/fee" action="index">
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
                                    <s:a namespace="/fee" action="index">
                                         <s:param name="page" value="#FEE_LIST.currentPage - 1"/>
                                         <s:property value="#FEE_LIST.currentPage - 1"/>
                                    </s:a>
                                </li>
                                <li class="active">
                                    <a><s:property value="#FEE_LIST.currentPage" /></a>
                                </li>
                                <%-- 添加当前页下一页页码 --%>
                                <li>
                                    <s:a namespace="/fee" action="index">
                                         <s:param name="page" value="#FEE_LIST.currentPage + 1"/>
                                         <s:property value="#FEE_LIST.currentPage + 1"/>
                                    </s:a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#FEE_LIST.totalPage - 1" />
                                    <s:param name="last" value="#FEE_LIST.totalPage" />
                                    <li>
                                        <a>...</a>
                                    </li>
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/fee" action="index">
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
                                            <s:a namespace="/fee" action="index">
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
                                <s:if test="#FEE_LIST.currentPage == #FEE_LIST.totalPage - 4">
                                    <li>
                                        <s:a namespace="/fee" action="index">
                                            <s:param name="page" value="#FEE_LIST.currentPage-1"/>
                                            <s:property value="#FEE_LIST.currentPage-1"/>
                                        </s:a>
                                    </li>
                                </s:if>
                                <%-- 最后五页处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#FEE_LIST.totalPage - 4" />
                                    <s:param name="last" value="#FEE_LIST.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #FEE_LIST.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/fee" action="index">
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
                        <s:if test="#FEE_LIST.totalCount == 0 || #FEE_LIST.currentPage == #FEE_LIST.nextPage">
                            <li class="disabled">
                                <a>»</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/fee" action="index">
                                    <s:param name="page" value="#FEE_LIST.nextPage"/>»
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
