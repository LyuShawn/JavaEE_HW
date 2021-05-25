package com.lqw.dao;

import com.lqw.controller.ProductController;
import com.lqw.pojo.Category;
import com.lqw.pojo.Product;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Mapper
public interface ProductDao {

    List<Product> getProductList(@Param("start") int start, @Param("limit") int limit);

    Product getProductById(int id);

    int getProductNum();

    int updateProductById(@Param("id") int id,
                          @Param("name") String name,
                          @Param("subTitle")String subTitle,
                          @Param("originalPrice")double originalPrice,
                          @Param("promotePrice") double promotePrice,
                          @Param("stock") int stock,
                          @Param("cid") int cid);

    List<Category> getCategoryNum();
}
