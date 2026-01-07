<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="108px">
      <el-form-item label="入库单ID" prop="stockInId">
        <el-input
          v-model="queryParams.stockInId"
          placeholder="请输入入库单ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="入库单明细ID" prop="stockInItemId">
        <el-input
          v-model="queryParams.stockInItemId"
          placeholder="请输入入库单明细ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="入库单号" prop="stockInNum">
        <el-input
          v-model="queryParams.stockInNum"
          placeholder="请输入订单号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="来源单号" prop="stockInSourceNo">
        <el-input
          v-model="queryParams.stockInSourceNo"
          placeholder="请输入来源单号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="仓库" prop="warehouseId">
        <el-select v-model="queryParams.warehouseId" placeholder="请选择仓库" clearable @change="handleQuery">
         <el-option
            v-for="item in warehouseList"
            :key="item.id"
            :label="item.name"
            :value="item.id">

          </el-option>
        </el-select>
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
      <el-table-column label="入库单明细ID" align="center" prop="stockInItemId" />
      <el-table-column label="入库单ID" align="center" prop="stockInId" />
      <el-table-column label="入库单号" align="center" prop="stockInNum" />
      <el-table-column label="来源单号" align="center" prop="stockInSourceNo" />
      <el-table-column label="入库仓库" align="center" prop="shopId" >
        <template slot-scope="scope">
          <el-tag type="info">{{ warehouseList.find(x=>x.id === scope.row.warehouseId) ? warehouseList.find(x=>x.id === scope.row.warehouseId).name : '' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="入库仓位" align="center" prop="positionNum" />
      <el-table-column label="图片"  prop="goodsImage" width="50px">
        <template slot-scope="scope">
          <el-image  style="width: 40px; height: 40px;" :src="scope.row.goodsImage" :preview-src-list="[scope.row.goodsImage]"></el-image>
        </template>
      </el-table-column>
      <el-table-column label="商品名" align="center" prop="goodsName" width="250px"/>
      <el-table-column label="规格" align="center" prop="skuName" />
      <el-table-column label="Sku编码" align="center" prop="skuCode" />
      <el-table-column label="SkuId" align="center" prop="skuId" />
      <el-table-column label="数量" align="center" prop="quantity" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
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
import { listStockInDetail, getWmsStockInEntry, stockIn ,complete} from "@/api/wms/stockIn";
import { listShop } from "@/api/shop/shop";
import {listWarehouse} from "@/api/wms/warehouse";

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
        stockInSourceNo: null,
        warehouseId: null,
        stockInItemId: null,
        stockInId: null,
        stockInNum: null,
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
      listStockInDetail(this.queryParams).then(response => {
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
