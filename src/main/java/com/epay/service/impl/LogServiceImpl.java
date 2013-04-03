package com.epay.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.epay.model.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.epay.action.ChartAction;
import com.epay.dao.AccountMapper;
import com.epay.dao.RechargeMapper;
import com.epay.dao.TradeLogMapper;
import com.epay.service.LogService;

@Service
public class LogServiceImpl implements LogService {

	private static final Logger logger = Logger.getLogger(LogServiceImpl.class);
	
	@Autowired
	private AccountMapper accountMapper;
	
	@Autowired
	private TradeLogMapper tradeLogMapper;
	
	@Autowired
	private RechargeMapper rechargeMapper;
	
	public boolean add(RefillLog newRefillLog) {
		int i = accountMapper.saveFillLog(newRefillLog);
		if (i == 1) {
			logger.info("记录充值日志" + newRefillLog.toString() + "成功");
			return true;
		}
		logger.info("记录充值日志" + newRefillLog.toString() + "失败");
		return false;
	}

	public boolean add(TradeLog newTradeLog) {
		int i = tradeLogMapper.save(newTradeLog);
		if (i == 1) {
			logger.info("记录交易日志" + newTradeLog.toString() + "成功");
			return true;
		}
		logger.info("记录交易日志" + newTradeLog.toString() + "失败");
		return false;
	}

	public Page get(int logType, User currentUser, int currentPage, int pageSize) {
		if (logType == REFILL_LOG) {
			int totalCount = rechargeMapper.count();
			Page<RefillLog> page = new Page<RefillLog>(currentPage, pageSize, totalCount);
			List<RefillLog> list = rechargeMapper.get(page);
			if (list.size() == 0) {
				logger.info("找不到用户" + currentUser.toString() + "相关充值记录");
			}
			page.setContent(list);
			return page;
		} else if (logType == TRADE_LOG) {
			int totalCount = tradeLogMapper.count();
			Page<TradeLog> page = new Page<TradeLog>(currentPage, pageSize, totalCount);
			List<TradeLog> tradeLogs = tradeLogMapper.get(page);
			page.setContent(tradeLogs);
			return page;
		}
		return null;
	}
	
	public Page find(int logType, int bizType, User user, String beginDate, String endDate, int status, int currentPage, int pageSize) {
		if (logType == REFILL_LOG) {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("beginDate", beginDate);
			params.put("endDate", endDate);
			params.put("status", status);
			if (user != null) {
				params.put("userId", user.getUserId());
                if (StringUtils.isNotEmpty(user.getAccountNumber())) {
                    Account account = accountMapper.findByNumber(user.getAccountNumber());
                    params.put("accountId", account.getId());
                }
			}
			if (bizType != -1) {
				params.put("fillType", bizType);
			}
			int totalCount = rechargeMapper.countByParams(params);
			
			Page<RefillLog> page = new Page<RefillLog>(currentPage, pageSize, totalCount);
			params.put("beginIndex", Integer.valueOf(page.getBeginIndex()));
			params.put("pageSize", Integer.valueOf(page.getPageSize()));
			List<RefillLog> list = rechargeMapper.find(params);
			if (list.size() == 0) {
				logger.info("找不到用户" + user.toString() + "相关充值记录");
			}
			page.setContent(list);
			return page;
		} else if (logType == TRADE_LOG) {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("beginDate", beginDate);
			params.put("endDate", endDate);
			params.put("status", status);
			params.put("userId", user.getUserId());
			params.put("bizType", user.getBizType());
            if (StringUtils.isNotEmpty(user.getAccountNumber())) {
                Account account = accountMapper.findByNumber(user.getAccountNumber());
                if (account != null) {
                	params.put("accountId", account.getId());
                } else {
                	return new Page<TradeLog>(currentPage, pageSize, 0);
                }
            }
			int totalCount = tradeLogMapper.countByParams(params);
			Page<TradeLog> page = new Page<TradeLog>(currentPage, pageSize, totalCount);
			params.put("beginIndex", page.getBeginIndex());
			params.put("pageSize", page.getPageSize());
			List<TradeLog> tradeLogs = tradeLogMapper.find(params);
			page.setContent(tradeLogs);
			return page;
		}
		return null;
	}

	public List<Object> getDataForChart(int type, int chartType, int year) {
		List<Object> list = new ArrayList<Object>();
		if (chartType == ChartAction.LINE_CHART || chartType == ChartAction.COLUMN_CHART) {
			List<Integer> years = tradeLogMapper.getAllYear();
			for (int y : years) {
				List<Double> listForYear = tradeLogMapper.statisticsForLineOrColumn(y);
				list.add(y);
				list.add(listForYear);
			}
		} else if (chartType == ChartAction.PIE_CHART) {
			List<Statistics> result = tradeLogMapper.statisticsForPie(year);
			if (result != null && result.size() > 0) {
				Object[] objs = null;
				for (Statistics instance : result) {
					objs = new Object[2];
					switch (instance.getMonth()) {
					case 1:
						objs[0] = "一月";
						objs[1] = instance.getTotal();
						break;
					case 2:
						objs[0] = "二月";
						objs[1] = instance.getTotal();
						break;
					case 3:
						objs[0] = "三月";
						objs[1] = instance.getTotal();
						break;
					case 4:
						objs[0] = "四月";
						objs[1] = instance.getTotal();
						break;
					case 5:
						objs[0] = "五月";
						objs[1] = instance.getTotal();
						break;
					case 6:
						objs[0] = "六月";
						objs[1] = instance.getTotal();
						break;
					case 7:
						objs[0] = "七月";
						objs[1] = instance.getTotal();
						break;
					case 8:
						objs[0] = "八月";
						objs[1] = instance.getTotal();
						break;
					case 9:
						objs[0] = "九月";
						objs[1] = instance.getTotal();
						break;
					case 10:
						objs[0] = "十月";
						objs[1] = instance.getTotal();
						break;
					case 11:
						objs[0] = "十一月";
						objs[1] = instance.getTotal();
						break;
					case 12:
						objs[0] = "十二月";
						objs[1] = instance.getTotal();
						break;
					default:
						break;
					}
					list.add(objs);
				}
			}
			return list;
		}
		return list;
	}
	
	public Map<String, String> sumMoney(int type, int bizType, User user, String beginDate, String endDate, int status) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (type == TRADE_LOG) {
			params.put("beginDate", beginDate);
			params.put("endDate", endDate);
			params.put("status", status);
			if (user != null) {
				params.put("userId", user.getUserId());
//				params.put("accountId", user.getAccountId());
                Account account = accountMapper.findByNumber(user.getAccountNumber());
                if (account != null) {
                	params.put("accountId", account.getId());
                }
				params.put("bizType", user.getBizType());
			}
			return tradeLogMapper.sumMoney(params);
		} else if (type == REFILL_LOG) {
			if (StringUtils.isNotEmpty(beginDate)) {
				params.put("beginDate", beginDate);
			}
			if (StringUtils.isNotEmpty(endDate)) {
				params.put("endDate", endDate);
			}
			if (user != null) {
//				params.put("accountId", user.getAccountId());
				Account account = accountMapper.findByNumber(user.getAccountNumber());
				if (account != null) {
					params.put("accountId", account.getId());
				}
				if (StringUtils.isNotEmpty(user.getUserId())) {
					params.put("userId", user.getUserId());
				}
			}
			params.put("status", status);
			if (bizType != -1) {
				params.put("fillType", bizType);
			}
			double money = rechargeMapper.sumMoney(params);
			Map<String, String> map = new HashMap<String, String>();
			map.put("money", String.valueOf(money));
			return map;
		}
		return null;
	}
	
}
