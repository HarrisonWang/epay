package com.epay.service;

import java.util.List;
import java.util.Map;

import com.epay.model.Page;
import com.epay.model.RefillLog;
import com.epay.model.TradeLog;
import com.epay.model.User;

/**
 * 日志服务接口，包含一些常用的新增、查询日志等操作。
 * @author Harrison Wang
 */
public interface LogService {
	
	/** 账户充值日志 */
	public static final int REFILL_LOG = 1;
	
	/** 账户支付日志 */
	public static final int TRADE_LOG = 2;
	
	/** 用户 */
	public static final int USER_TYPE = 3;
	
	/** 打款日志 */
	public static final int PROCEEDS_TYPE = 4;
	
	/**
	 * 新增充值日志
	 * @param newRefillLog 充值日志
	 * @return true成功，false失败
	 */
	public boolean add(RefillLog newRefillLog);
	
	/**
	 * 新增支付日志
	 * @param newTradeLog 支付日志
	 * @return true成功，false失败
	 */
	public boolean add(TradeLog newTradeLog);
	
	/**
	 * 获取当前账户日志列表
	 * @param logType 日志类型，支持Refill_LOG和TRADE_LOG
	 * @param currentUser 当前操作用户
	 * @param currentPage 当前页
	 * @param pageSize 每页获取记录数
	 * @return 当前账户日志列表
	 */
	public Page get(int logType, User currentUser, int currentPage, int pageSize);
	
	public Page find(int logType, int bizType, User currentUser, String beginDate, String endDate, int status, int currentPage, int pageSize);
	
	/**
	 * 获取所有日志列表
	 * @param logType 日志类型，支持Refill_LOG和TRADE_LOG
	 * @return 日志列表
	 */
//	public List getAll(int logType, int year);
	
	/**
	 * 获取图表数据列表
	 * @param type 待统计业务类型（暂未用）
	 * @param chartType 图表类型
	 * @param year 年度
	 * @return 图表所需数据列表
	 */
	public List<Object> getDataForChart(int type, int chartType, int year);
	
	/**
	 * 统计累计成功的交易总额
	 * @param type 业务类型（REFILL_LOG、TRADE_LOG）
	 * @return 累计成功的交易总额
	 */
	public Map<String, String> sumMoney(int type, int bizType, User user, String beginDate, String endDate, int status);
}
