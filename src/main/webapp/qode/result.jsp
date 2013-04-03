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
    <title>易点付后台管理系统-字符串查询</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <style type="text/css">
    #btns {
        margin-top: 24px;
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
    <s:include value="/common/header.jsp" />
    <div class="container-fluid">
        <div class="row-fluid">
            <s:include value="/common/sidebar.jsp" />
            <div class="well span9">
                <s:form namespace="/qode" action="search" theme="simple" cssClass="form-inline">
                    <div class="row-fluid">
                        <div class="span3 lightblue">
                            <label>面额</label>
                            <input type="text" name="qode.type" class="input-meduim" value="<s:property value='qode.type' />">
                        </div>
                        <div class="span3 lightblue">
                            <label>状态</label>
                            <s:select name="qode.valid" list="#{'-1':'所有', '0':'未使用', '1':'已使用'}" value="qode.valid"/>
                        </div>
                        <div class="span3 lightblue">
                            <label>地市</label>
                            <s:select name="qode.areaCode" list="#{'-1': '所有', '0730':'岳阳市', '0731':'长沙市', '0732':'湘潭市', '0733':'株洲市', '0734':'衡阳市', '0735':'郴州市', '0736':'常德市', '0737':'益阳市', '0738':'娄底市', '0739':'邵阳市', '0743':'湘西州', '0744':'张家界', '0745':'怀化市', '0746':'永州市'}" value="qode.areaCode" cssClass="input-meduim" />
                        </div>
                        <div id="btns" class="span3 lightblue">
                            <button type="submit" class="btn btn-primary">查询</button>
                        </div>
                    </div>
                </s:form>
                <div style="margin-bottom: 20px;">
                    <s:if test="#QODE_LIST.content.size != 0">
                        <span>当前导入字符串总额： <strong><s:property value="#MONEY"/></strong> 元</span>
                        <span class="pull-right">共查询到 <strong><s:property value="#QODE_LIST.totalCount"/></strong> 条记录</span>
                    </s:if>
                </div>
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>面额</th>
                            <th>字符串</th>
                            <th>状态</th>
                            <th>地市</th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:if test="#QODE_LIST.content.size == 0">
                            <tr>
                                <td colspan="6" style="font-weight: bold;color: red;text-align: center;">很遗憾，当前没有字符串信息！</td>
                            </tr>
                        </s:if>
                        <s:iterator value="#QODE_LIST.content" status="stat">
                            <tr>
                                <td><s:property value="#QODE_LIST.beginIndex + #stat.count" /></td>
                                <td>￥<s:property value="type" /></td>
                                <td><s:property value="code" /></td>
                                <td>
                                    <s:if test="valid == 0">未使用</s:if>
                                    <s:elseif test="valid == 1">已使用</s:elseif>
                                    <s:else>未知状态</s:else>
                                </td>
                                <td><s:property value="areaCode"/></td>
                            </tr>
                        </s:iterator>
                    </tbody>
                </table>
                <div class="pagination pagination-right">
                    <ul>
                        <%-- 上一页 --%>
                        <s:if test="#QODE_LIST.currentPage == #QODE_LIST.previousPage">
                            <li class="disabled">
                                <a>«</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/qode" action="search">
                                    <s:param name="qode.type" value="qode.type"/>
                                    <s:param name="qode.valid" value="qode.valid"/>
                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                    <s:param name="page" value="#QODE_LIST.previousPage"/>«
                                </s:a>
                            </li>
                        </s:else>
                        <%-- 总页数不大于10页则全部显示 --%>
                        <s:if test="#QODE_LIST.totalPage <= 10">
                            <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                <s:param name="first" value="1" />
                                <s:param name="last" value="#QODE_LIST.totalPage" />
                                <s:iterator var="pageNumber">
                                    <s:if test="#pageNumber == #QODE_LIST.currentPage">
                                        <li class="active">
                                            <a><s:property /></a>
                                        </li>
                                    </s:if><s:else>
                                        <li>
                                            <s:a namespace="/qode" action="search">
			                                    <s:param name="qode.type" value="qode.type"/>
			                                    <s:param name="qode.valid" value="qode.valid"/>
			                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:else>
                                </s:iterator>
                            </s:bean>
                        </s:if><s:else>
                            <%-- 当前页处于前五处理开始--%>
                            <s:if test="#QODE_LIST.currentPage <= 5">
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="5" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #QODE_LIST.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/qode" action="search">
				                                    <s:param name="qode.type" value="qode.type"/>
				                                    <s:param name="qode.valid" value="qode.valid"/>
				                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                                    <s:param name="page" value="#pageNumber"/>
                                                    <s:property />
                                                </s:a>
                                            </li>
                                        </s:else>
                                    </s:iterator>
                                    <s:if test="#QODE_LIST.currentPage == 5">
                                        <li>
                                            <s:a namespace="/qode" action="search">
			                                    <s:param name="qode.type" value="qode.type"/>
			                                    <s:param name="qode.valid" value="qode.valid"/>
			                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                                <s:param name="page" value="#QODE_LIST.currentPage+1"/>
                                                <s:property value="#QODE_LIST.currentPage+1"/>
                                            </s:a>
                                        </li>
                                    </s:if>
                                </s:bean>
                                <li>
                                    <a>...</a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#QODE_LIST.totalPage - 1" />
                                    <s:param name="last" value="#QODE_LIST.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/qode" action="search">
			                                    <s:param name="qode.type" value="qode.type"/>
			                                    <s:param name="qode.valid" value="qode.valid"/>
			                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                </s:bean>
                            </s:if>
                            <%-- 当前页处于前五处理结束 --%>
                            
                            <%-- 当前页处于前五与后五之间开始 --%>
                            <s:elseif test="#QODE_LIST.currentPage > 5 && #QODE_LIST.currentPage < #QODE_LIST.totalPage - 4">
                                <%-- 第一页和第二页页码 处理--%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="2" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/qode" action="search">
			                                    <s:param name="qode.type" value="qode.type"/>
			                                    <s:param name="qode.valid" value="qode.valid"/>
			                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
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
                                    <s:a namespace="/qode" action="search">
	                                    <s:param name="qode.type" value="qode.type"/>
	                                    <s:param name="qode.valid" value="qode.valid"/>
	                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                         <s:param name="page" value="#QODE_LIST.currentPage - 1"/>
                                         <s:property value="#QODE_LIST.currentPage - 1"/>
                                    </s:a>
                                </li>
                                <li class="active">
                                    <a><s:property value="#QODE_LIST.currentPage" /></a>
                                </li>
                                <%-- 添加当前页下一页页码 --%>
                                <li>
                                    <s:a namespace="/qode" action="search">
	                                    <s:param name="qode.type" value="qode.type"/>
	                                    <s:param name="qode.valid" value="qode.valid"/>
	                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                         <s:param name="page" value="#QODE_LIST.currentPage + 1"/>
                                         <s:property value="#QODE_LIST.currentPage + 1"/>
                                    </s:a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#QODE_LIST.totalPage - 1" />
                                    <s:param name="last" value="#QODE_LIST.totalPage" />
                                    <li>
                                        <a>...</a>
                                    </li>
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/qode" action="search">
			                                    <s:param name="qode.type" value="qode.type"/>
			                                    <s:param name="qode.valid" value="qode.valid"/>
			                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
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
                                            <s:a namespace="/qode" action="search">
			                                    <s:param name="qode.type" value="qode.type"/>
			                                    <s:param name="qode.valid" value="qode.valid"/>
			                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
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
                                <s:if test="#QODE_LIST.currentPage == #QODE_LIST.totalPage - 4">
                                    <li>
                                        <s:a namespace="/qode" action="search">
		                                    <s:param name="qode.type" value="qode.type"/>
		                                    <s:param name="qode.valid" value="qode.valid"/>
		                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                            <s:param name="page" value="#QODE_LIST.currentPage-1"/>
                                            <s:property value="#QODE_LIST.currentPage-1"/>
                                        </s:a>
                                    </li>
                                </s:if>
                                <%-- 最后五页处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#QODE_LIST.totalPage - 4" />
                                    <s:param name="last" value="#QODE_LIST.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #QODE_LIST.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/qode" action="search">
				                                    <s:param name="qode.type" value="qode.type"/>
				                                    <s:param name="qode.valid" value="qode.valid"/>
				                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
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
                        <s:if test="#QODE_LIST.totalCount == 0 || #QODE_LIST.currentPage == #QODE_LIST.nextPage">
                            <li class="disabled">
                                <a>»</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/qode" action="search">
                                    <s:param name="qode.type" value="qode.type"/>
                                    <s:param name="qode.valid" value="qode.valid"/>
                                    <s:param name="qode.areaCode" value="qode.areaCode"/>
                                    <s:param name="page" value="#QODE_LIST.nextPage"/>»
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
