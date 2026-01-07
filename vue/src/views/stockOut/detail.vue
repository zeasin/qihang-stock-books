<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="108px">
      <el-form-item label="出库单ID" prop="entryId">
        <el-input
          v-model="queryParams.entryId"
          placeholder="请输入出库单ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="出库单明细ID" prop="entryItemId">
        <el-input
          v-model="queryParams.entryItemId"
          placeholder="请输入出库单明细ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品SkuId" prop="goodsSkuId">
        <el-input
          v-model="queryParams.goodsSkuId"
          placeholder="请输入商品SkuId"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品Sku编码" prop="skuCode">
        <el-input
          v-model="queryParams.skuCode"
          placeholder="请输入商品Sku编码"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="orderList" @selection-change="handleSelectionChange">
<!--      <el-table-column type="selection" width="55" align="center" />-->
      <el-table-column label="出库单明细ID" align="center" prop="entryItemId" width="100"/>
      <el-table-column label="出库单ID" align="center" prop="entryId" width="100" />


      <el-table-column label="图片"  prop="goodsImage" width="50px">
        <template slot-scope="scope">
          <el-image  style="width: 40px; height: 40px;" :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImage]"></el-image>
        </template>
      </el-table-column>
      <el-table-column label="商品名" align="center" prop="goodsTitle" width="250px"/>
      <el-table-column label="规格" align="center" prop="skuName" />
      <el-table-column label="Sku编码" align="center" prop="skuCode" />
      <el-table-column label="SkuId" align="center" prop="goodsSkuId" />
      <el-table-column label="数量" align="center" prop="quantity" />
      <el-table-column label="出库仓库" align="center" prop="shopId" >
        <template slot-scope="scope">
          <el-tag type="info">{{ warehouseList.find(x=>x.id === scope.row.warehouseId) ? warehouseList.find(x=>x.id === scope.row.warehouseId).name : '' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="入库仓位" align="center" prop="positionNum" />
      <el-table-column label="出库时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.outTime) }}</span>
        </template>
      </el-table-column>
<!--      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">-->
<!--        <template slot-scope="scope">-->
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-edit"-->
<!--            @click="handleEditErpSku(scope.row)"-->
<!--          >补充ERP SKU</el-button>-->
<!--        </template>-->
<!--      </el-table-column>-->
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

  </div>
</template>

<script>

import {listWarehouse} from "@/api/wms/warehouse";
import {listStockOutDetail} from "@/api/wms/stockOut";

export default {
  name: "Order",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 子表选中数据
      checkedSShopOrderItem: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 店铺订单表格数据
      orderList: [],
      // ${subTable.functionName}表格数据
      sShopOrderItemList: [],
      warehouseList:[],
      // 弹出层标题
      open:false,
      orderTime: null,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        entryId: null,
        entryItemId: null,
        warehouseId: null,
        goodsSkuId: null,
        skuCode: null,
      },
      // 表单参数
      form: {
        id:null,
        erpSkuId:null
      },
      // 表单校验
      rules: {
        erpSkuId: [{ required: true, message: "请输入ERP系统商品SkuId", trigger: "change" }],
      }
    };
  },
  created() {
    listWarehouse({status:1}).then(resp=>{
      this.warehouseList = resp.rows;
      this.getList();
    })

  },
  methods: {
    amountFormatter(row, column, cellValue, index) {
      return '￥' + cellValue.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
    },
    /** 查询店铺订单列表 */
    getList() {
      if(this.orderTime){
        this.queryParams.startTime = this.orderTime[0]
        this.queryParams.endTime = this.orderTime[1]
      }else {
        this.queryParams.startTime = null
        this.queryParams.endTime = null
      }
      this.loading = true;
      listStockOutDetail(this.queryParams).then(response => {
        this.orderList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.orderTime=null
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },

    reset(){

    },
    cancel(){
      this.form.id = null
      this.form.erpSkuId = null
      this.open = false
    },
    // handleEditErpSku(row){
    //   this.form.id = row.id
    //   if(this.form.erpSkuId && this.form.erpSkuId > 0) {
    //     this.form.erpSkuId = row.erpSkuId
    //   }
    //   this.open = true
    // },
    // submitForm() {
    //   this.$refs["form"].validate(valid => {
    //     if (valid) {
    //       console.log('====修改参数====',this.form)
    //       updateErpSkuId(this.form).then(response => {
    //         this.$modal.msgSuccess("修改成功");
    //         this.open = false;
    //         this.getList();
    //       });
    //
    //     }
    //   });
    // }
  }
};
</script>
