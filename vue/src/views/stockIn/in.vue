<template>
  <div class="app-container">
    <el-form ref="form" :model="form" :rules="rules" label-width="108px">
        <el-form-item label="入库单号" prop="stockInNum">
          <el-col :span="24">
            <el-input v-model="form.stockInNum" style="width:220px" disabled placeholder="请输入入库单号" />
          </el-col>
        </el-form-item>
      <el-form-item label="入库仓库" prop="warehouseId">
        <el-select v-model="form.warehouseId" filterable r placeholder="入库类型" >
          <el-option v-for="item in warehouseList" :key="item.id" :label="item.name" :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
        <el-form-item label="" style="width: 1000px">
          <el-divider content-position="center" style="margin-left: 98px;">入库商品信息</el-divider>
        </el-form-item>


        <el-table style="margin-left: 108px;margin-bottom: 20px;" :data="form.itemList" :row-class-name="rowSShopOrderItemIndex" ref="sShopOrderItem">
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="SkuId" prop="skuId" width="80"></el-table-column>
          <el-table-column label="图片" prop="goodsImage" width="70">
            <template slot-scope="scope">
              <el-image style="width: 60px; height: 60px" :src="scope.row.goodsImage"></el-image>
            </template>
          </el-table-column>
          <el-table-column label="商品" prop="goodsName" width="280"></el-table-column>
          <el-table-column label="规格" prop="skuName" width="160"></el-table-column>
          <el-table-column label="Sku编码" prop="skuCode" width="160"></el-table-column>
          <el-table-column label="数量" prop="quantity" width="100"></el-table-column>
          <!-- <el-table-column label="erp系统商品id" prop="goodsId" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.goodsId" placeholder="请输入erp系统商品id" />
            </template>
          </el-table-column>
          <el-table-column label="erp系统商品规格id" prop="specId" width="150">
            <template slot-scope="scope">
              <el-input v-model="scope.row.specId" placeholder="请输入erp系统商品规格id" />
            </template>
          </el-table-column> -->
          <el-table-column label="入库仓位" prop="skuId" width="260">
            <template slot-scope="scope">
              <!-- <el-input v-model="scope.row.goodsTitle" placeholder="请输入商品标题" /> -->
              <el-select v-model="scope.row.positionId" filterable remote reserve-keyword placeholder="搜索仓库仓位" style="width: 230px;"
                :remote-method="searchWarehousePosition" :loading="locationLoading" @change="positionChange(scope.row)">
                <el-option v-for="item in positionList" :key="item.id"
                           :label="item.name"
                           :value="item.id">
                  <span style="float: left">{{ item.name }}</span>
                  <span style="float: right; color: #8492a6; font-size: 13px">{{ item.number }}</span>
                </el-option>
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="入库数量" prop="intoQuantity" width="150">
            <template slot-scope="scope">
              <el-input v-model.number="scope.row.intoQuantity" placeholder="请输入商品数量" />
            </template>
          </el-table-column>
        </el-table>

<!--      <el-form-item label="操作人" prop="stockInOperator">-->
<!--        <el-input v-model="form.stockInOperator" style="width: 220px;" placeholder="请输入操作人" />-->
<!--      </el-form-item>-->

<!--        <el-form-item label="备注" prop="remark">-->
<!--          <el-input v-model="form.remark" type="textarea" style="width: 400px;" placeholder="备注" />-->
<!--        </el-form-item>-->

      </el-form>
      <div slot="footer" class="dialog-footer" style="margin-left: 108px;">
        <el-button type="primary" @click="submitForm">确认入库</el-button>
        <!-- <el-button @click="cancel">取 消</el-button> -->
      </div>
  </div>
</template>

<script>
import { searchSku } from "@/api/goods/goods";
import {getWmsStockInEntry, stockIn, stockInCreate} from "@/api/wms/stockIn";
import {listWarehouse, searchPosition} from "@/api/wms/warehouse";

export default {
  name: "StockInCreate",
  data() {
    return {
      warehouseList:[],
      // 表单参数
      form: {
        id:null,
        stockInNum:null,
        stockInType:null,
        sourceNo:null,
        itemList:[]
      },
      // 表单校验
      rules: {
        warehouseId: [{ required: true, message: '请选择仓库' }],
        // stockInType: [{ required: true, message: '请选择入库类型' }],
        // sourceNo: [{ required: true, message: '源单号不能为空' }],
        // stockInOperator: [{ required: true, message: '请填写操作人' }],
      },
      locationLoading: true,
      skuList: [],
      positionList: [],

      // 子表选中数据
      checkedSShopOrderItem: []
    };
  },
  created() {
  },
  mounted() {
    if (this.$route.query.id) {
      this.form.id = this.$route.query.id
    }
    this.getData();
  },
  methods: {
    getData() {
      listWarehouse({status:1}).then(resp=>{
        this.warehouseList = resp.rows;
      })
      getWmsStockInEntry(this.form.id).then(response => {
        this.form = response.data;
        this.form.stockInType = this.form.stockInType+''
        this.form.stockInId = response.data.id
        this.itemList = response.data.itemList;
        // this.itemList.forEach(x=>{
        //   x.intoQuantity = x.quantity - x.inQuantity
        //   x.positionId = null
        //   x.positionNum = null
        // })
        this.open = true;
        this.title = "入库操作";
      });
    },
    // 搜索仓库仓位
    searchWarehousePosition(query) {
      if(!this.form.warehouseId){
        this.$modal.msgError('请选择仓库')
      }else {
        this.locationLoading = true;
        const qw = {
          warehouseId:this.form.warehouseId,
          number: query
        }
        searchPosition(qw).then(res => {
          this.positionList = res.rows;
          this.locationLoading = false;
        })
      }
    },
    positionChange(row){
      console.log(row)
      const selection = this.positionList.find(x => x.id === row.positionId);
      if (selection) {
        row.positionNum = selection.number
      }
    },
    /** ${subTable.functionName}序号 */
    rowSShopOrderItemIndex({ row, rowIndex }) {
      row.index = rowIndex + 1;
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.itemList = this.itemList;
          // 验证数据
          let isValid = false
          for(let i = 0;i<this.form.itemList.length;i++){
            const x = this.form.itemList[i]
            if(x.intoQuantity && !x.positionId){
              isValid = false;
              break
            }else if(x.positionId && !x.intoQuantity){
              isValid = false;
              break
            }else isValid = true
          }

          if(isValid){
            console.log('=======验证通过了========',this.form)
            stockIn(this.form).then(response => {
              this.$modal.msgSuccess("入库操作成功");
              // 调用全局挂载的方法,关闭当前标签页
              this.$store.dispatch("tagsView/delView", this.$route);
              this.$router.push('/stock_in/stock_in_list');
            });
          }else{
            this.$modal.msgError("请填写入库数量和仓位编码");
          }
        }
      });
    }
  }
};

</script>
