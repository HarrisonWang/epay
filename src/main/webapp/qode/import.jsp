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
    <title>易点付后台管理系统-字符串查询</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.css">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.1.custom.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/epay.js"></script>
    <script type="text/javascript">
$(function() {
	$("#areaCode").change(function() {
        if (this.value == "") {
            $(this).parent().parent().removeClass();
            $(this).parent().parent().addClass("control-group error");
            $(".help-inline", $(this).parent()).show();
        } else {
            $(this).parent().parent().removeClass();
            $(this).parent().parent().addClass("control-group success");
            $(".help-inline", $(this).parent()).hide();
        }
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
                <s:form action="save" namespace="/qode" theme="simple" method="post" cssClass="form-horizontal" enctype="multipart/form-data">
                    <s:if test="hasActionMessages()">
                        <div class="alert alert-success">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <s:property value="actionMessages[0]" />
                        </div>
                    </s:if>
                    <s:elseif test="hasActionErrors()">
                        <div class="alert alert-error">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <s:property value="actionErrors[0]" />
                        </div>
                    </s:elseif>
                    <s:elseif test="hasFieldErrors()">
                        <div class="alert alert-error">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <s:property value="fieldErrors[0]" />
                        </div>
                    </s:elseif>
                    <div class="control-group">
                        <label class="control-label">地市</label>
                        <div class="controls">
                            <s:select id="areaCode" name="qode.areaCode" list="#{'': '请选择', '0730':'岳阳市', '0731':'长沙市', '0732':'湘潭市', '0733':'株洲市', '0734':'衡阳市', '0735':'郴州市', '0736':'常德市', '0737':'益阳市', '0738':'娄底市', '0739':'邵阳市', '0743':'湘西州', '0744':'张家界', '0745':'怀化市', '0746':'永州市'}" value="qode.areaCode" cssClass="input-meduim" />
                            <span class="help-inline" style="display:none;">请选择地市</span>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">充值额度</label>
                        <div class="controls">
                            <input type="text" class="input-meduim" id="qodeType" name="qode.type">
                            <span class="help-inline" style="display: none;">请输入充值额度</span>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">字符串</label>
                        <div class="controls">
                            <s:file id="qodeFile" name="myDoc" cssClass="input-file"></s:file>
                            <span class="help-inline" style="display: none;">请选择需要导入的字符串</span>
                        </div>
                    </div>
                    <div class="control-group">
	                    <div class="controls controls-row">
	                        <button type="submit" class="btn btn-primary">导入</button>
		                    <button type="button" class="btn" id="btn-back">返回</button>
	                    </div>
                    </div>
                </s:form>
            </div>
        </div>
        <s:include value="/common/footer.jsp" />
    </div>
</body>
</html>
