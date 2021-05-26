package com.lqw.controller;

import com.alibaba.fastjson.JSON;
import com.lqw.pojo.Order;
import com.lqw.pojo.Product;
import com.lqw.service.OrderServiceImpl;
import com.lqw.service.ProductServiceImpl;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("order")
public class OrderController {
    static Log log= LogFactory.getLog(OrderController.class);

    @Autowired
    OrderServiceImpl orderService;

    @RequestMapping(value={"/get_list/{page}/{limit}","get_list/{page}"})
    public String getOrderListByPage(HttpServletRequest request,
                                     @PathVariable(value = "page",required = false) Integer page,
                                     @PathVariable(value = "limit",required = false) Integer limit){
        if(limit==null){
            limit=10;
        }
        if(page==null){
            page=1;
        }
        List<Order> OrderList=orderService.getOrderList(page,limit);
        request.setAttribute("orderList",JSON.toJSON(OrderList));
        request.setAttribute("currentPage",page.intValue());
        request.setAttribute("pageSize",limit.intValue());
        return "orderList";
    }

    @RequestMapping("/deliver_by_id")
    @ResponseBody
    public String deliverById(@RequestParam("id") int id){
        int update=orderService.deliverById(id);
        if(update==1){
            return "success";
        }
        else{
            return "error";
        }
    }
}
