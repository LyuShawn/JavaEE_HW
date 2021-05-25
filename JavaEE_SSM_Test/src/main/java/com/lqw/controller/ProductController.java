package com.lqw.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.lqw.dao.ProductDao;
import com.lqw.pojo.Category;
import com.lqw.pojo.Product;
import com.lqw.service.ProductService;
import com.lqw.service.ProductServiceImpl;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {
    static Log log= LogFactory.getLog(ProductController.class);

    @Autowired
    ProductServiceImpl productService;

    @RequestMapping("/test/{page}")
    //@ResponseBody
    public String returnTest(HttpServletRequest request, @PathVariable("page") int page) throws IOException {
        //Product product=productService.getProductById(87);
        List<Product> productList=productService.getProductList(1,10);
        request.setAttribute("test",page);
        //return JSON.toJSONString(productList);
        return "index";
    }

    /**
     *
     * @param page  必须
     * @param limit 非必须，默认值10
     * @return
     *
     */
    @RequestMapping(value = "/get_product_list",method = RequestMethod.GET)
    @ResponseBody
    public String getProductList(@RequestParam(value = "page",required = true) int page,
                                 @RequestParam(value = "limit",defaultValue = "10",
                                         required = false) int limit) throws IOException {

        List<Product> productList=productService.getProductList(page,limit);
        int productNum=productService.getProductNum();
        JSONObject list=new JSONObject();
        list.put("productNum",productNum);
        list.put("productList",productList);
        return list.toJSONString();
    }

    /**
     *
     * @param request
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value={"/get_list/{page}/{limit}","get_list/{page}"})
    public String getProductListByPage(HttpServletRequest request,
                                       @PathVariable(value = "page",required = false) Integer page,
                                       @PathVariable(value = "limit",required = false) Integer limit){
        //当limit为空时，为limit指定默认值10
        if(limit==null){
            limit=10;
        }
        if(page==null){
            page=1;
        }
        List<Product> productList=productService.getProductList(page,limit);
        int productNum=productService.getProductNum();
        request.setAttribute("pageSize",limit);
        request.setAttribute("page",page);
        request.setAttribute("productNum",productNum);
        request.setAttribute("productList",JSON.toJSON(productList));
        return "index";
    }

    /**
     *
     * @param request
     * @param id
     * @return
     */
    @RequestMapping("/update_product/{id}")
    public String updateProduct(HttpServletRequest request,
                                @PathVariable("id") int id){
        Product product=productService.getProductById(id);
        List<Category> categoryList=productService.getCategoryNum();
        request.setAttribute("product",JSON.toJSON(product));
        request.setAttribute("categoryList",JSON.toJSON(categoryList));
        return "updateProduct";
    }

    /**
     *
     * @param request
     * @param id
     * @param name
     * @param subTitle
     * @param originalPrice
     * @param promotePrice
     * @param stock
     * @param cid
     * @return
     */
    @RequestMapping("/updateById")
    @ResponseBody
    public String updateProductById(HttpServletRequest request,
                                  @RequestParam("id") int id,
                                  @RequestParam("name")String name,
                                  @RequestParam("subTitle")String subTitle,
                                  @RequestParam("originalPrice")double originalPrice,
                                  @RequestParam("promotePrice")double promotePrice,
                                  @RequestParam("stock")int stock,
                                  @RequestParam("cid")int cid){
        int update=productService.updateProductById(id,name,subTitle,originalPrice,promotePrice,stock,cid);
        if(update==1){
            return "success";
        }
        else{
            return "error";
        }
    }
}
