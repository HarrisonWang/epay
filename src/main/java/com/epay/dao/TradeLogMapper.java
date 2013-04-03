package com.epay.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.epay.model.Page;
import com.epay.model.Statistics;
import com.epay.model.TradeLog;

public interface TradeLogMapper {

    public int save(TradeLog tradelog);

    public int count();
    
    public int countByParams(Map<String, Object> params);

    public List<TradeLog> get(Page page);
    
    public List<TradeLog> find(Map<String, Object> params);

    public List<Statistics> statisticsForPie(@Param("year") Integer year);
    
    public List<Double> statisticsForLineOrColumn(@Param("year") Integer year);
    
    public List<Integer> getAllYear();
    
    public Map<String, String> sumMoney(Map<String, Object> params);
    
}
