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
    <title>易点付后台管理系统-交易统计</title>
    <link rel="stylesheet" href="css/flick/jquery-ui-1.10.1.custom.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/bootstrap-responsive.css">
    <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.10.1.custom.js"></script>
    <script type="text/javascript" src="js/jquery.ui.datepicker-zh-CN.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/highcharts.js"></script>
    <script type="text/javascript" src="js/exporting.js"></script>
    <script type="text/javascript" src="js/epay.js"></script>
        <script type="text/javascript">
$(function() {
    var chart;
    var pieChart;
    $(document).ready(function() {
        var options = {
            chart: {
                renderTo: 'container',
                type: 'column',
                marginRight: 130,
                marginBottom: 25
            },
            title: {
                text: '月度交易统计',
                x: -20 //center
            },
            subtitle: {
                text: '来自: 易点付',
                x: -20
            },
            credits: {
                enabled: false
            },
            xAxis: {
                categories: ['一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月']
            },
            yAxis: {
                min: 0,
                title: {
                    text: '交易额（元）'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                        return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'元';
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: [{
                name: '',
                data: []
            }, {
                name: '',
                data: []
            }]
        };

        var opts = {
            chart: {
                renderTo: 'container',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: ''
            },
            subtitle: {
                text: '来自: 易点付',
            },
            credits: {
                enabled: false
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage}%</b>',
                percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                type: 'pie',
                name: '百分比',
                data: []
            }]
        };
        
        var host = $("#host").val();
        // Ajax request
        $.ajax({
            url: host + "test/lineOrColumn.action",
            dataType: "json",
            async: false,
            success: function(json) {
//           var years = json.tradeLogs.length/2;
//           for (var i = 0; i < years; i++) {
//           }
	            options.series[0].name= json.tradeLogs[0] + '年';
	            options.series[0].data = json.tradeLogs[1];
	            options.series[1].name= json.tradeLogs[2] + '年';
	            options.series[1].data = json.tradeLogs[3];
	            pieChart = new Highcharts.Chart(options);
            }
        });

        $("#btn-column").click(function() {
            options.chart.type = 'column';  
            chart = new Highcharts.Chart(options);
        });

        $("#btn-line").click(function() {
            options.chart.type = 'line';    
            chart = new Highcharts.Chart(options);
        });

        $("#btn-pie > ul a").click(function() {
            var year = $(this).attr("data-value");
            $.getJSON(host + "test/pie.action?year=" + year, function(json) {
                opts.title.text = json.year + '年月度交易统计';
                opts.series[0].data = json.tradeLogs;
	            pieChart = new Highcharts.Chart(opts);
            });
        });

        $.ajax({
            url: host+"test/pie.action?year=2012",
            dataType: "json",
            async: false,
            success: function(json) {
	            opts.title.text = json.year + '年月度交易统计';
	            opts.series[0].data = json.tradeLogs;
	            pieChart = new Highcharts.Chart(opts);
            }
        });
        
        chart = new Highcharts.Chart(options);
        
    });
    
});
        </script>
</head>
<body>
    <s:include value="/common/header.jsp" />
    <div class="container-fluid">
        <div class="row-fluid">
            <s:include value="/common/sidebar.jsp" />
            <div class="span9">
                <input type="hidden" id="host" value="<%=basePath%>">
                <div style="margin: 0 1em">
                    <ul id="tab" class="nav nav-tabs">
                        <li class="active">
                            <a id="btn-column" data-toggle="tab">柱状图</a>
                        </li>
                        <li>
                            <a id="btn-line" data-toggle="tab">曲线图</a>
                        </li>
                        <li id="btn-pie" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">饼图 <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="#dropdown1" data-toggle="tab" data-value="2012">2012</a></li>
                                <li><a href="#dropdown2" data-toggle="tab" data-value="2013">2013</a></li>
                            </ul>
                        </li>
                    </ul>
                    <div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
                </div>
            </div>
        </div>
        <s:include value="/common/footer.jsp" />
    </div>
</body>
</html>