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
public interface ProductService {

     List<Product> getProductList(int page,int limit);
     Product getProductById(int id);
     int getProductNum();

     List<Category> getCategoryNum();
     int updateProductById(int id,String name,String subTitle,double originalPrice,
                                 double promotePrice,int stock,int cid);
}
