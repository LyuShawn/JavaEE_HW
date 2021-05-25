package com.lqw.service;

import com.lqw.dao.ProductDao;
import com.lqw.pojo.Category;
import com.lqw.pojo.Product;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.xml.crypto.dsig.keyinfo.RetrievalMethod;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductDao productDao;
    static Log log= LogFactory.getLog(ProductService.class);

    public List<Product> getProductList(int page,int limit){
        List<Product> productList=productDao.getProductList((page-1)*limit,limit);
        //log.info(productList);
        return productList;
    }
    public Product getProductById(int id){
        Product product=productDao.getProductById(id);
        //log.info(product);
        return product;
    }
    public int getProductNum(){
        int num=productDao.getProductNum();
        return num;
    }

    public List<Category> getCategoryNum(){
        return productDao.getCategoryNum();
    }
    public int updateProductById(int id,String name,String subTitle,double originalPrice,
                                 double promotePrice,int stock,int cid){
        int update=productDao.updateProductById(id,name,subTitle,originalPrice,promotePrice,stock,cid);
        return update;
    }
}
