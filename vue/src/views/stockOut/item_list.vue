<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="出库单号" prop="entryNum">
        <el-input
          v-model="queryParams.entryNum"
          placeholder="请输入出库单号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="出库单ID" prop="entryId">
        <el-input
          v-model="queryParams.entryId"
          placeholder="请输入出库单ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>


      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable @change="handleQuery">
          <el-option label="待出库" value="0" ></el-option>
          <el-option label="部分出库" value="1" ></el-option>
          <el-option label="完全出库" value="2"></el-option>
        </el-select>
      </el-form-item>
<!--      <el-form-item label="是否关联" prop="hasLink">-->
<!--        <el-select v-model="queryParams.hasLink" placeholder="是否关联" clearable @change="handleQuery">-->
<!--          <el-option label="未关联" value="0"></el-option>-->
<!--          <el-option label="已关联" value="1"></el-option>-->
<!--        </el-select>-->
<!--      </el-form-item>-->
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
      <el-table-column label="ID" align="center" prop="id" width="65"/>
      <el-table-column label="出库单号" align="center" prop="entryNum" width="220"/>
      <el-table-column label="出库类型" align="center" prop="stockOutType" width="160" >
        <template slot-scope="scope">
          <el-tag size="small" v-if="scope.row.stockOutType === 1">订单拣货出库</el-tag>
          <el-tag size="small" v-if="scope.row.stockOutType === 2">采购退货出库</el-tag>
          <el-tag size="small" v-if="scope.row.stockOutType === 3">盘点出库</el-tag>
          <el-tag size="small" v-if="scope.row.stockOutType === 4">报损出库</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="图片"  prop="goodsImg" width="50px">
        <template slot-scope="scope">
          <el-image  style="width: 40px; height: 40px;" :src="scope.row.goodsImg" :preview-src-list="[scope.row.goodsImg]"></el-image>
        </template>
      </el-table-column>
      <el-table-column label="商品名" align="left" prop="goodsTitle" width="350px"/>
      <el-table-column label="SKU名" align="center" prop="skuName" />
      <el-table-column label="Sku编码" align="center" prop="skuCode" />
      <el-table-column label="SkuId" align="center" prop="goodsSkuId" />
      <el-table-column label="状态" align="center" prop="refundStatus" >
        <template slot-scope="scope">
           <el-tag v-if="scope.row.status === 0">待出库</el-tag>
           <el-tag v-if="scope.row.status === 1">部分出库</el-tag>
           <el-tag v-if="scope.row.status === 2">完全出库</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button style="padding-left: 6px;padding-right: 6px;" plain
                     size="mini"
                     type="success"
                     icon="el-icon-d-arrow-right"
                     @click="handleStockOut(scope.row)"
                     v-hasPermi="['wms:stockOutEntry:edit']"
          >出库</el-button>
          <el-button style="padding-left: 6px;padding-right: 6px;" plain
                     size="mini"
                     type="text"
                     icon="el-icon-view"
                     @click="handleStockOut(scope.row)"
          >出库明细</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
    <!-- 修改Erp Sku 对话框 -->
    <el-dialog title="修改ERP SKU ID" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="ERP商品skuId" prop="erpSkuId">
          <el-input type="number" v-model="form.erpSkuId" placeholder="请输入ERP商品skuId" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {getStockOutItem} from "@/api/wms/stockOut";

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
      shopList:[],
      // 弹出层标题
      open:false,
      orderTime: null,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        entryNum: null,
        entryId: null,
        status: null
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
    this.getList();
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
      getStockOutItem(this.queryParams).then(response => {
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
