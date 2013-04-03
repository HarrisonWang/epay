package com.epay.dao;

import java.util.List;
import java.util.Map;

import com.epay.model.Page;
import com.epay.model.User;

public interface UserMapper {

    public int save(User user);

    public int delete(User user);

    public int update(User user);

    public List<User> list(Page page);

    public List<User> listByUserType();
    
    public List<User> listByParams(Map<String, Object> params);

    public User find(User user);

    public int count();
    
    public int countByParams(Map<String, Object> params);

    public int countForOperationAdmin(Map<String, Object> params);

    public List<User> listForOperationAdmin(Map<String, Object> params);
    
}
