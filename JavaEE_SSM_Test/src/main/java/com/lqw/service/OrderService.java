package com.lqw.service;

import com.lqw.pojo.Order;
import com.lqw.pojo.Product;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.List;

public interface OrderService {

    List<Order> getOrderList(int page, int limit);
    int getOrderNum();
    int deliverById(int id);
}
