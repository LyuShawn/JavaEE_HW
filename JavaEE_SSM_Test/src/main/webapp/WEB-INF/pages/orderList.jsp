<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>订单列表</title>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <style>
        .demo-table-expand {
            font-size: 0;
        }
        .demo-table-expand label {
            width: 90px;
            color: #99a9bf;
        }
        .demo-table-expand .el-form-item {
            margin-right: 0;
            margin-bottom: 0;
            width: 50%;
        }
    </style>
</head>
<body>
<div id="app">
    <el-table
            :header-cell-style="headClass"
            ref="table"
            :row-key="getRowKeys"
            :data="orderList"
            border
            style="width: 100%">
        <el-table-column
                label="ID"
                align="center"
                width="80"
                sortable
                prop="id">
        </el-table-column>
        <el-table-column
                label="状态"
                align="center"
                width="120"
                sortable
                prop="status">
        </el-table-column>
        <el-table-column
                label="金额"
                align="center"
                width="120"
                sortable
                prop="amount">
        </el-table-column>
        <el-table-column
                label="商品数量"
                align="center"
                width="110"
                sortable
                prop="productNum">
        </el-table-column>
        <el-table-column
                label="买家名称"
                align="center"
                width="120"
                sortable
                prop="receiver">
        </el-table-column>
        <el-table-column
                label="创建时间"
                align="center"
                width="200"
                sortable
                prop="createDate">
        </el-table-column>
        <el-table-column
                label="支付时间"
                align="center"
                width="200"
                sortable
                prop="payDate">
        </el-table-column>
        <el-table-column
                label="发货时间"
                align="center"
                width="200"
                sortable
                prop="deliveryDate">
        </el-table-column>
        <el-table-column
                label="确认收货时间"
                align="center"
                sortable
                width="200"
                prop="confirmDate">
        </el-table-column>
        <el-table-column label="操作" align="center">
            <template slot-scope="scope">
                <el-button type="text" @click="toogleExpand(scope.row)">查看详情</el-button>
                <el-button type="text" @click="deliver(scope.row)"
                           v-show="scope.row.status==='待发货'">发货</el-button>
            </template>
        </el-table-column>
        <el-table-column type="expand" width="1">
            <template slot-scope="props">
                <el-form label-position="left" inline class="demo-table-expand"
                v-for="(item,index) in props.row.orderItems">
                    <el-form-item label="商品名称">
                        <span>{{ item.itemName }}</span>
                    </el-form-item>
                    <el-form-item label="商品价格" style="width: 20%;">
                        <span>{{ item.itemAmount }}</span>
                    </el-form-item>
                    <el-form-item label="商品数量" style="width: 20%;">
                        <span>{{ item.number }}</span>
                    </el-form-item>
                </el-form>

            </template>
        </el-table-column>
    </el-table>
    <div class="block" style="margin:0 auto;text-align: center;margin-top: 40px;margin-bottom: 20px">
        <el-pagination
                layout="prev, pager, next"
                page-size="pageSize"
                :current-page="currentPage"
                :total="orderNum"
                @current-change="currentChange">
        </el-pagination>
    </div>
</div>
</body>
<!-- import Vue before Element -->
<script src="https://unpkg.com/vue@2.6.12/dist/vue.js"></script>
<!-- import JavaScript -->
<script src="https://unpkg.com/element-ui/lib/index.js"></script>
<!-- import axios -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    new Vue({
        el: '#app',
        data: function() {
            return {
                orderList:[],
                orderNum:0,
                currentPage:0,
                pageSize:0,
            }
        },
        methods:{
            headClass(){
              return "text-align:center"
            },

            getRowKeys(row) {
                return row.id;
            },

            toogleExpand(row) {
                let $table = this.$refs.table;
                this.orderList.map((item) => {
                    if (row.id != item.id) {
                        $table.toggleRowExpansion(item, false)
                    }
                })
                $table.toggleRowExpansion(row)
            },
            deliver(row){
                let _this=this;
                console.log(row);
                let getURL=window.location.origin+"/order/deliver_by_id?id="+row.id;
                axios.get(getURL).then(response=>{
                    if(response.data==='success'){
                        _this.updateSuccess();
                        row.status='待收货';
                        console.log(_this.orderList);
                    }
                    else{
                        _this.updateError();
                    }
                });
            },
            updateSuccess(){
                this.$message({
                    message: '发货成功！',
                    type: 'success'
                });

            },
            updateError(){
                this.$message.error('发货失败');
            },

            currentChange(pageIndex){
                var _this=this;
                var newURL=window.location.origin+"/order/get_list/"+pageIndex+"/"+_this.pageSize;
                window.location.href=newURL;
            },

            //金额格式化函数
            number_format(number, decimals, dec_point, thousands_sep) {
            /*
            　　 * 参数说明：
            　　 * number：要格式化的数字
            　　 * decimals：保留几位小数
            　　 * dec_point：小数点符号
            　　 * thousands_sep：千分位符号
            　　 * */
            number = (number + '').replace(/[^0-9+-Ee.]/g, '');
            var n = !isFinite(+number) ? 0 : +number,
                prec = !isFinite(+decimals) ? 2 : Math.abs(decimals),
                sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
                dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
                s = '',
                toFixedFix = function(n, prec) {
                    var k = Math.pow(10, prec);
                    return '' + Math.ceil(n * k) / k;
                };

            s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
            var re = /(-?\d+)(\d{3})/;
            while(re.test(s[0])) {
                s[0] = s[0].replace(re, "$1" + sep + "$2");
            }

            if((s[1] || '').length < prec) {
                s[1] = s[1] || '';
                s[1] += new Array(prec - s[1].length + 1).join('0');
            }
            return s.join(dec);
            },
        },
        mounted(){
            let _this=this;
            let list=${orderList}
            this.pageSize=${pageSize};
            console.log(this.pageSize);
            this.currentPage=${currentPage};
            console.log(this.currentPage);
            for(let i=0;i<list.length;i++){
                list[i].amount='￥'+_this.number_format(list[i].amount);
                if(list[i].status==='waitConfirm'){
                    list[i].status='待收货';
                }
                else if (list[i].status==='waitDelivery'){
                    list[i].status='待发货';
                }
            }
            this.orderList=list;
            this.orderNum=this.orderList.length;
            console.log(this.orderList);
        },
    })
</script>
</html>