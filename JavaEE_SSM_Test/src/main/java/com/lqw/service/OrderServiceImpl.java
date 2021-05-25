package com.lqw.service;

import com.lqw.dao.OrderDao;
import com.lqw.pojo.Order;
import com.lqw.pojo.OrderItem;
import com.lqw.pojo.Product;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.apache.bcel.generic.RET;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService{
    Log log= LogFactory.getLog(OrderService.class);

    @Autowired
    OrderDao orderDao;

    @Override
    public List<Order> getOrderList(int page, int limit) {
        List<Order> OrderList=orderDao.getOrderList((page-1)*limit,limit);
        int productNum;
        double amount;
        for (Order order : OrderList) {
            productNum=0;
            amount=0;
            for (OrderItem orderItem : order.getOrderItems()) {
                productNum+=orderItem.getNumber();
                amount+=orderItem.getNumber()*orderItem.getItemAmount();
            }
            order.setProductNum(productNum);
            order.setAmount(amount);//保留两位小数
        }
        return OrderList;
    }


    @Override
    public int getOrderNum() {
        return orderDao.getOrderNum();
    }

    @Override
    public int deliverById(int id) {
        return orderDao.deliverById(id);
    }
}
