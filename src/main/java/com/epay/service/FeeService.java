package com.epay.service;

import com.epay.model.Fee;
import com.epay.model.Page;

public interface FeeService {

	public boolean save(Fee fee);
	
	public Page<Fee> find(int page, int pageSize);
	
	public Fee get(String areaCode, String type);
	
	public boolean update(Fee fee);
	
	public boolean delete(Fee fee);
	
}
