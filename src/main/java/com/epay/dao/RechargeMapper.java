package com.epay.dao;

import java.util.List;
import java.util.Map;

import com.epay.model.Page;
import com.epay.model.RefillLog;

public interface RechargeMapper {
	
	public int count();
	
	public List<RefillLog> get(Page page);

    public int countByParams(Map<String, Object> params);
    
    public List<RefillLog> find(Map<String, Object> params);
    
    public double sumMoney(Map<String, Object> params);
	
}
