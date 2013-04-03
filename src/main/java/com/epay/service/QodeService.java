package com.epay.service;

import com.epay.model.Page;
import com.epay.model.Qode;

public interface QodeService {

	public boolean save(String filePath, Qode instance);
	
	public Page<Qode> find(Qode qode, int currentPage, int pageSize);
	
	public double sumMoney(Qode qode);
	
}
