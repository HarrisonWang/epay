package com.epay.action;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.epay.service.LogService;
import com.opensymphony.xwork2.ActionSupport;

public class ChartAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	public static final int LINE_CHART = 1;
	public static final int COLUMN_CHART = 2;
	public static final int PIE_CHART = 3;
    private String year;
    private Map<String, Object> dataMap;
	@Autowired
    private LogService logService;
	
    public ChartAction() {
    	dataMap = new HashMap<String, Object>();
	}

	public String pie() throws Exception {
		dataMap.clear();
        int queryYear = 0;
        if (StringUtils.isNotEmpty(year)) {
        	queryYear = Integer.parseInt(year);
        } else {
        	queryYear = Integer.parseInt(DateFormatUtils.format(Calendar.getInstance(), "yyyy"));
        }
        List<Object> list = logService.getDataForChart(LogService.TRADE_LOG, ChartAction.PIE_CHART, queryYear);
        dataMap.put("tradeLogs", list);
        dataMap.put("year", queryYear);
        dataMap.put("success", true);
        return SUCCESS;
    }
	
	public String lineOrColumn() throws Exception {
		dataMap.clear();
		List<Object> list = logService.getDataForChart(LogService.TRADE_LOG, ChartAction.LINE_CHART, 0);
		dataMap.put("tradeLogs", list);
		dataMap.put("success", true);
		return SUCCESS;
	}
	
	public String getYear() {
		return year;
	}
	
	public void setYear(String year) {
		this.year = year;
	}

	public Map<String, Object> getDataMap() {
		return dataMap;
	}

	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}
}
