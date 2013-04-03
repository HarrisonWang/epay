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
    <title>易点付后台管理系统-用户查询</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.css">
    <link rel="stylesheet" href="css/style.css">
    <style type="text/css">
   .form-horizontal .control-label {
      width: 60px;
      }
   .form-horizontal .controls {
      margin-left: 70px;
   }
   .form-horizontal .row-fluid .span4 {
      margin-left: 0px;
   }
    </style>
    <link rel="stylesheet" href="css/bootstrap-responsive.css">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.1.custom.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/epay.js"></script>
    <script type="text/javascript">
    $(function() {
        $("#user-export").click(function() {
            alert($("[type=checkbox]").val());
            var url = $(this).attr("action") + "?user.createTime=" + $("#beginDate").val() + "&user.userId=" + $("#userId").val() + "&user.areaCode=" + $("#areaCode").val() + "&user.type=" + $("#userType").val() + "&user.accountNumber=" + $("#accountNumber").val();
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
                <s:form namespace="/user" action="search" method="post" theme="simple" id="searchForm" cssClass="form-horizontal">
                   <div class="row-fluid">
                       <div class="span4">
                           <div class="control-group">
                               <label class="control-label">用户名</label>
                               <div class="controls">
                                   <input type="text" id="userId" name="user.userId" class="input-meduim" value="<s:property value='user.userId' />">
                               </div>
                           </div>
                       </div>
                       <div class="span4">
                           <div class="control-group">
                               <label class="control-label">创建时间</label>
                               <div class="controls">
                                   <input type="text" name="user.createTime" id="beginDate" class="input-meduim" value="<s:date name='user.createTime' format='yyyy-MM-dd'/>">
                               </div>
                           </div>
                       </div>
                       <div class="span4">
                           <div class="control-group">
                               <label class="control-label">所属账户</label>
                               <div class="controls">
                                   <input type="text" id="accountNumber" name="user.accountNumber" class="input-meduim" value="<s:property value='user.accountNumber' />" placeholder="账户ID">
                               </div>
                           </div>
                       </div>
                   </div>
                    <div class="row-fluid">
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">地市</label>
                                <div class="controls">
                                    <s:select id="areaCode" name="user.areaCode" cssClass="input-meduim" list="#{'': '所有', '0730':'岳阳市', '0731':'长沙市', '0732':'湘潭市', '0733':'株洲市', '0734':'衡阳市', '0735':'郴州市', '0736':'常德市', '0737':'益阳市', '0738':'娄底市', '0739':'邵阳市', '0743':'湘西州', '0744':'张家界', '0745':'怀化市', '0746':'永州市'}" value="user.areaCode" cssClass="input-meduim" />
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">用户类型</label>
                                <div class="controls">
	                                <s:if test="#session.LOGIN_USER.type == 1">
	                                    <s:select id="userType" name="user.type" cssClass="input-meduim" list="#{'-1': '所有', '0': '普通用户', '1': '管理员', '2': '操作管理员', '3': '财务管理员'}" value="user.type"/>
	                                </s:if><s:elseif test="#session.LOGIN_USER.type == 2">
	                                    <s:select id="userType" name="user.type" cssClass="input-meduim" list="#{'-1': '所有', '0': '普通用户', '2': '操作管理员', '3': '财务管理员'}" value="user.type"/>
	                                </s:elseif>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <div class="control-group">
                                <label class="control-label">业务类型</label>
                                <label class="checkbox inline" style="width: 42px; padding-left: 30px;">
                                    <s:if test="bizType.contains(\"1\")">
                                        <input type="checkbox" name="bizType" value="1" checked="checked">QQ币
                                    </s:if><s:else>
                                        <input type="checkbox" name="bizType" value="1">QQ币
                                    </s:else>
                                </label>
                                <label class="checkbox inline" style="width: 42px;padding-left: 10px;">
		                             <s:if test="bizType.contains(\"2\")">
		                                 <input type="checkbox" name="bizType" value="2" checked="checked">黄金岛
		                             </s:if><s:else>
		                                 <input type="checkbox" name="bizType" value="2">黄金岛
		                             </s:else>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="pull-right">
                                <button type="submit" class="btn btn-primary">查询</button>
                                <button type="button" class="btn" id="user-export" action="user/export.action">导出</button>
                            </div>
                        </div>
                    </div>
                </s:form>
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
						<tr>
                            <th>序号</th>
                            <th>用户名</th>
                            <th>用户类型</th>
                            <th>地市编码</th>
                            <th>所属账户</th>
                            <th>业务名称</th>
                            <th>操作</th>
						</tr>
                    </thead>
                    <tbody>
                        <s:if test="#LIST_USER.content.size == 0">
                            <tr>
                                <td colspan="7" style="font-weight: bold;color: red;text-align: center;">很遗憾，没有找到您想要的，换个条件试试？</td>
                            </tr>
                        </s:if>
                        <s:iterator value="#LIST_USER.content" status="stat">
                            <tr>
                                <td><s:property value="#LIST_USER.beginIndex + #stat.count" /></td>
                                <td><s:property value="userId" /></td>
                                <td>
                                  <s:if test="type == 0">普通用户</s:if>
                                  <s:elseif test="type == 1">管理员</s:elseif>
                                  <s:elseif test="type == 2">操作管理员</s:elseif>
                                  <s:elseif test="type == 3">财务管理员</s:elseif>
                                </td>
                                <td><s:property value="areaCode" /></td>
                                <td><s:property value="accountNumber" /></td>
                                <td>
                                <s:if test="bizType.equals('1|2')">QQ币；黄金岛</s:if>
                                <s:elseif test="bizType == 1"> QQ币 </s:elseif>
                                <s:elseif test="bizType == 2">黄金岛</s:elseif>
                                </td>
                                <td>
                                    <s:a action="edit?user.userId=%{userId}" namespace="/user" title="编辑">
                                        <i class="icon-edit"></i>
                                    </s:a>
                                    <a onclick="delete_user('<s:property value="#session.LOGIN_USER.userId" />', '<s:property value="userId" />');" href="javascript:;" title="删除">
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
                        <s:if test="#LIST_USER.currentPage == #LIST_USER.previousPage">
                            <li class="disabled">
                                <a>«</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/user" action="search">
                                    <s:param name="user.accountId" value="user.accountId"/>
                                    <s:param name="user.userId" value="user.userId"/>
                                    <s:param name="user.createTime" value="user.createTime"/>
                                    <s:param name="user.areaCode" value="user.areaCode"/>
                                    <s:param name="user.type" value="user.type"/>
                                    <s:param name="bizType" value="bizType"/>
                                    <s:param name="page" value="#LIST_USER.previousPage"/>«
                                </s:a>
                            </li>
                        </s:else>
                        <%-- 总页数不大于10页则全部显示 --%>
                        <s:if test="#LIST_USER.totalPage <= 10">
                            <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                <s:param name="first" value="1" />
                                <s:param name="last" value="#LIST_USER.totalPage" />
                                <s:iterator var="pageNumber">
                                    <s:if test="#pageNumber == #LIST_USER.currentPage">
                                        <li class="active">
                                            <a><s:property /></a>
                                        </li>
                                    </s:if><s:else>
                                        <li>
                                            <s:a namespace="/user" action="search">
			                                    <s:param name="user.accountId" value="user.accountId"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="user.createTime" value="user.createTime"/>
			                                    <s:param name="user.areaCode" value="user.areaCode"/>
                                                <s:param name="bizType" value="bizType"/>
			                                    <s:param name="user.type" value="user.type"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:else>
                                </s:iterator>
                            </s:bean>
                        </s:if><s:else>
                            <%-- 当前页处于前五处理开始--%>
                            <s:if test="#LIST_USER.currentPage <= 5">
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="5" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #LIST_USER.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/user" action="search">
				                                    <s:param name="user.accountId" value="user.accountId"/>
				                                    <s:param name="user.userId" value="user.userId"/>
				                                    <s:param name="user.createTime" value="user.createTime"/>
				                                    <s:param name="user.areaCode" value="user.areaCode"/>
				                                    <s:param name="bizType" value="bizType"/>
				                                    <s:param name="user.type" value="user.type"/>
                                                    <s:param name="page" value="#pageNumber"/>
                                                    <s:property />
                                                </s:a>
                                            </li>
                                        </s:else>
                                    </s:iterator>
                                    <s:if test="#LIST_USER.currentPage == 5">
                                        <li>
                                            <s:a namespace="/user" action="search">
			                                    <s:param name="user.accountId" value="user.accountId"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="user.createTime" value="user.createTime"/>
			                                    <s:param name="user.areaCode" value="user.areaCode"/>
			                                    <s:param name="bizType" value="bizType"/>
			                                    <s:param name="user.type" value="user.type"/>
                                                <s:param name="page" value="#LIST_USER.currentPage+1"/>
                                                <s:property value="#LIST_USER.currentPage+1"/>
                                            </s:a>
                                        </li>
                                    </s:if>
                                </s:bean>
                                <li>
                                    <a>...</a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_USER.totalPage - 1" />
                                    <s:param name="last" value="#LIST_USER.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/user" action="search">
			                                    <s:param name="user.accountId" value="user.accountId"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="user.createTime" value="user.createTime"/>
			                                    <s:param name="user.areaCode" value="user.areaCode"/>
			                                    <s:param name="bizType" value="bizType"/>
			                                    <s:param name="user.type" value="user.type"/>
                                                <s:param name="page" value="#pageNumber"/>
                                                <s:property />
                                            </s:a>
                                        </li>
                                    </s:iterator>
                                </s:bean>
                            </s:if>
                            <%-- 当前页处于前五处理结束 --%>
                            
                            <%-- 当前页处于前五与后五之间开始 --%>
                            <s:elseif test="#LIST_USER.currentPage > 5 && #LIST_USER.currentPage < #LIST_USER.totalPage - 4">
                                <%-- 第一页和第二页页码 处理--%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="1" />
                                    <s:param name="last" value="2" />
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/user" action="search">
			                                    <s:param name="user.accountId" value="user.accountId"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="user.createTime" value="user.createTime"/>
			                                    <s:param name="user.areaCode" value="user.areaCode"/>
			                                    <s:param name="bizType" value="bizType"/>
			                                    <s:param name="user.type" value="user.type"/>
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
                                    <s:a namespace="/user" action="search">
	                                    <s:param name="user.accountId" value="user.accountId"/>
	                                    <s:param name="user.userId" value="user.userId"/>
	                                    <s:param name="user.createTime" value="user.createTime"/>
	                                    <s:param name="user.areaCode" value="user.areaCode"/>
	                                    <s:param name="user.type" value="user.type"/>
	                                    <s:param name="bizType" value="bizType"/>
                                         <s:param name="page" value="#LIST_USER.currentPage - 1"/>
                                         <s:property value="#LIST_USER.currentPage - 1"/>
                                    </s:a>
                                </li>
                                <li class="active">
                                    <a><s:property value="#LIST_USER.currentPage" /></a>
                                </li>
                                <%-- 添加当前页下一页页码 --%>
                                <li>
                                    <s:a namespace="/user" action="search">
	                                    <s:param name="user.accountId" value="user.accountId"/>
	                                    <s:param name="user.userId" value="user.userId"/>
	                                    <s:param name="user.createTime" value="user.createTime"/>
	                                    <s:param name="user.areaCode" value="user.areaCode"/>
	                                    <s:param name="user.type" value="user.type"/>
	                                    <s:param name="bizType" value="bizType"/>
                                         <s:param name="page" value="#LIST_USER.currentPage + 1"/>
                                         <s:property value="#LIST_USER.currentPage + 1"/>
                                    </s:a>
                                </li>
                                <%-- 最后两页页码处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_USER.totalPage - 1" />
                                    <s:param name="last" value="#LIST_USER.totalPage" />
                                    <li>
                                        <a>...</a>
                                    </li>
                                    <s:iterator var="pageNumber">
                                        <li>
                                            <s:a namespace="/user" action="search">
			                                    <s:param name="user.accountId" value="user.accountId"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="user.createTime" value="user.createTime"/>
			                                    <s:param name="user.areaCode" value="user.areaCode"/>
			                                    <s:param name="user.type" value="user.type"/>
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
                                            <s:a namespace="/user" action="search">
			                                    <s:param name="user.accountId" value="user.accountId"/>
			                                    <s:param name="user.userId" value="user.userId"/>
			                                    <s:param name="user.createTime" value="user.createTime"/>
			                                    <s:param name="user.areaCode" value="user.areaCode"/>
			                                    <s:param name="user.type" value="user.type"/>
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
                                <s:if test="#LIST_USER.currentPage == #LIST_USER.totalPage - 4">
                                    <li>
                                        <s:a namespace="/user" action="search">
		                                    <s:param name="user.accountId" value="user.accountId"/>
		                                    <s:param name="user.userId" value="user.userId"/>
		                                    <s:param name="user.createTime" value="user.createTime"/>
		                                    <s:param name="user.areaCode" value="user.areaCode"/>
		                                    <s:param name="user.type" value="user.type"/>
		                                    <s:param name="bizType" value="bizType"/>
                                            <s:param name="page" value="#LIST_USER.currentPage-1"/>
                                            <s:property value="#LIST_USER.currentPage-1"/>
                                        </s:a>
                                    </li>
                                </s:if>
                                <%-- 最后五页处理 --%>
                                <s:bean name="org.apache.struts2.util.Counter" id="counter">
                                    <s:param name="first" value="#LIST_USER.totalPage - 4" />
                                    <s:param name="last" value="#LIST_USER.totalPage" />
                                    <s:iterator var="pageNumber">
                                        <s:if test="#pageNumber == #LIST_USER.currentPage">
                                            <li class="active">
                                                <a><s:property /></a>
                                            </li>
                                        </s:if><s:else>
                                            <li>
                                                <s:a namespace="/user" action="search">
				                                    <s:param name="user.accountId" value="user.accountId"/>
				                                    <s:param name="user.userId" value="user.userId"/>
				                                    <s:param name="user.createTime" value="user.createTime"/>
				                                    <s:param name="user.areaCode" value="user.areaCode"/>
				                                    <s:param name="user.type" value="user.type"/>
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
                        <s:if test="#LIST_USER.totalCount == 0 || #LIST_USER.currentPage == #LIST_USER.nextPage">
                            <li class="disabled">
                                <a>»</a>
                            </li>
                        </s:if><s:else>
                            <li>
                                <s:a namespace="/user" action="search">
                                    <s:param name="user.accountId" value="user.accountId"/>
                                    <s:param name="user.userId" value="user.userId"/>
                                    <s:param name="user.createTime" value="user.createTime"/>
                                    <s:param name="user.areaCode" value="user.areaCode"/>
                                    <s:param name="user.type" value="user.type"/>
                                    <s:param name="bizType" value="bizType"/>
                                    <s:param name="page" value="#LIST_USER.nextPage"/>»
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
