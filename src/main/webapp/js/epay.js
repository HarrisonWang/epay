$(function() {
	
	$("#btn-back").click(function() {
		window.history.back();
	});

    $.datepicker.setDefaults($.datepicker.regional['zh-CN']);
	$("#beginDate").datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        dateFormat: "yy-mm-dd",
        onClose: function( selectedDate ) {
            $( "#endDate" ).datepicker( "option", "minDate", selectedDate );
        }
    });
	$("#endDate").datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        dateFormat: "yy-mm-dd",
        onClose: function( selectedDate ) {
            $( "#beginDate" ).datepicker( "option", "maxDate", selectedDate );
        }
    });

    $("#btn-export").click(function() {
        var url = $(this).attr("action") + "?beginDate=" + $("#beginDate").val() + "&endDate=" + $("#endDate").val() + "&user.userId=" + $("#userId").val() + "&status=" + $("#status").val() + "&bizType=" + $("#bizType").val() + "&user.accountNumber=" + $("#accountNumber").val();
        window.location.href = url;
    });

    $("#qodeType").blur(function() {
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
    
    $("#qodeFile").change(function() {
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
    
    $("#accountId").change(function() {
    	if (this.value != "") {
    		// TODO: 
    	}
    	
    });
    
    // 选中当前页
    var pathname = location.pathname;
    $("#sidebar").find("a").each(function(i){
    	if (pathname == this.pathname || pathname.replace("search", "index") == this.pathname) {
    		$(this).parent("li").addClass("active");
    		return;
    	}
    });
    $('#kaptcha').click(function() {
    	this.src = getRootPath() + "Kaptcha.jpg?random="+Math.random();
    });
    
    $('#login-btn').click(function() {
    	var btn = $(this);
    	btn.button('loading');
    	setTimeout(function () {
    		btn.button('reset');
    	}, 3000);
    });
    
});

function delete_user(optionUser, targetUser) {
    if (window.confirm("尊敬的" + optionUser + "用户，您是否确认删除该用户？点击确认将无法找回，谢谢！")) {
        location.href = "user/delete.action?user.userId=" + targetUser;
        return true;
    }
    return false;
}

function getRootPath(){
    var currentHref = location.href;
    var pathName = location.pathname;
    var pos = currentHref.indexOf(pathName);
    var host = currentHref.substring(0,pos);
    var projectName = pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(host+projectName + "/");
}