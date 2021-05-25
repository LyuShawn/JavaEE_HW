package com.lqw.dao;

import com.lqw.pojo.Order;
import com.lqw.pojo.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Mapper
public interface OrderDao {
    int getOrderNum();
    List<Order> getOrderList(@Param("start") int start, @Param("limit") int limit);
    int deliverById(@Param("id") int id);
}
