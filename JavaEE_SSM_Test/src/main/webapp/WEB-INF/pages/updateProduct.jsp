<%@ page import="com.lqw.pojo.Product" %><%--
  Created by IntelliJ IDEA.
  User: 90589
  Date: 2021/5/7
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <!-- import CSS -->
    <title>编辑产品</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
</head>
<body>
<div id="app">
    <el-form ref="form" :model="form" label-width="120px">
        <el-form-item label="产品名称">
            <el-input v-model="form.name" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="产品小标题">
            <el-input v-model="form.subTitle" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="原价格">
            <el-input v-model="form.originalPrice" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="优惠价格">
            <el-input v-model="form.promotePrice" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="库存">
            <el-input v-model="form.stock" style="width: 50%;"></el-input>
        </el-form-item>
        <el-form-item label="类别">
            <el-select v-model="form.cid">
                <el-option v-for="category in categoryList"
                           :label="category.name"
                           :value="category.id"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="onSubmit">提交</el-button>
        </el-form-item>
    </el-form>
</div>
</body>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<!-- import axios -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    new Vue({
        el: '#app',
        data: function() {
            return {
                form:'',
                categoryList:'',
            }
        },
        methods: {
            updateSuccess(){
                this.$message({
                    message: '更新成功！',
                    type: 'success'
                });
            },
            updateError(){
                this.$message.error('更新失败');
            },
            onSubmit(){
                var _this=this;
                var getURL=window.location.origin+"/product/updateById?"+
                    "id="+_this.form.id+
                    "&name="+_this.form.name+
                    "&subTitle="+_this.form.subTitle+
                    "&originalPrice="+_this.form.originalPrice+
                    "&promotePrice="+_this.form.promotePrice+
                    "&stock="+_this.form.stock+
                    "&cid="+_this.form.cid;
                axios.get(getURL).then(response=>{
                   if(response.data==='success'){
                       _this.updateSuccess();
                   }
                   else{
                       _this.updateError();
                   }
                });
            }
        },
        mounted() {
            var _this=this;
            _this.form=${product};
            _this.categoryList=${categoryList};
            console.log(_this.categoryList);
        }
    })
</script>
</html>