<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>商品列表</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
</head>
<body>
<div id="app">
    <el-table
            :header-cell-style="headClass"
            :data="productList"
            border
            style="width: 100%">
        <el-table-column
                align="center"
                prop="id"
                label="ID"
                width="60">
        </el-table-column>
        <el-table-column
                prop="category"
                align="center"
                label="产品类别"
                width="100">
        </el-table-column>
        <el-table-column
                prop="name"
                label="产品名称">
        </el-table-column>
        <el-table-column
                prop="subTitle"
                label="产品小标题">
        </el-table-column>
        <el-table-column
                prop="originalPrice"
                align="center"
                label="原价格"
                width="100">
        </el-table-column>
        <el-table-column
                prop="promotePrice"
                label="优惠价格"
                align="center"
                width="100">
        </el-table-column>
        <el-table-column
                prop="stock"
                label="库存数量"
                align="center"
                width="100">
        </el-table-column>
        <el-table-column
                fixed="right"
                label="操作"
                width="100">
            <template slot-scope="scope">
                <el-button type="text"
                           size="small"
                           @click.native.prevent="update(scope.$index)">编辑</el-button>
                <el-button type="text" size="small">删除</el-button>
            </template>
        </el-table-column>
    </el-table>
    <div class="block" style="margin:0 auto;text-align: center;margin-top: 40px;margin-bottom: 20px">
        <el-pagination
                layout="prev, pager, next"
                page-size="pageSize"
                :current-page="currentPage"
                :total="pageNum"
                @current-change="currentChange">
        </el-pagination>
    </div>
</div>
</body>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<script>
    new Vue({
        el: '#app',
        data: function() {
            return {
                productList:[],
                pageSize:0,
                pageNum:0,
                currentPage:0,
            }
        },
        methods:{
            update(index){
                var _this=this;
                var newURL=window.location.origin+"/product/update_product/"+_this.productList[index].id;
                window.location.href=newURL;
            },
            currentChange(pageIndex){
                var _this=this;
                var newURL=window.location.origin+"/product/get_list/"+pageIndex+"/"+_this.pageSize;
                window.location.href=newURL;
            },
            headClass() {
                return "text-align:center"
            },
        },
        mounted(){
            var _this=this;
            _this.productList= ${productList};
            _this.pageSize=${pageSize};
            _this.pageNum=${productNum};
            _this.currentPage=${page};
        },
    })
</script>
</html>