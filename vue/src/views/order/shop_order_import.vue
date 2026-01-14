<template>
  <div class="app-container">
    <el-form :model="form" ref="form" size="small" label-width="120px">
      <el-form-item label="店铺" prop="shopId">
        <el-select v-model="form.shopId" placeholder="请选择店铺" clearable >
         <el-option
            v-for="item in shopList"
            :key="item.id"
            :label="item.name"
            :value="item.id">
           <span style="float: left">{{ item.name }}</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 500">微信小店</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 200">京东POP</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 280">京东自营</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 100">淘宝天猫</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 300">拼多多</span>
           <span style="float: right; color: #8492a6; font-size: 13px"  v-if="item.type === 400">抖店</span>
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="Excel文件" prop="createTime">
        <el-upload
          class="upload-demo"
          :headers="headers"
          drag
          :action="importUrl"
          :data="{shopId:form.shopId}"
          accept="xlsx"
          :on-success="uploadSuccess">
          <i class="el-icon-upload"></i>
          <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
          <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>
        </el-upload>
      </el-form-item>

    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-download"
          size="mini"
          :disabled="multiple"
          @click="handlePull"
        >导入选择</el-button>
      </el-col>
    </el-row>

    <el-table  :data="lists"  @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="订单号" align="center" prop="orderNum" />
      <el-table-column label="商品" align="left" prop="goodsTitle" />
      <el-table-column label="规格" align="center" prop="goodsSpec" />
      <el-table-column label="SkuId" align="center" prop="skuId" />
      <el-table-column label="规格编码" align="center" prop="skuNum" />
      <el-table-column label="价格" align="center" prop="goodsPrice" :formatter="amountFormatter"/>
      <el-table-column label="发货快递" align="center" prop="goodsNum" />

      <el-table-column label="下单时间" align="center" prop="pullTime" >
        <template slot-scope="scope">
          {{ parseTime(scope.row.subOrderNum) }}
        </template>
      </el-table-column>

    </el-table>




  </div>
</template>

<script>
import {listShop, listShopPullLogs} from "@/api/shop/shop";
import {importOrder, pullOrder} from "@/api/shop/order";
import {MessageBox} from "element-ui";
import {isRelogin} from "@/utils/request";
import {getToken} from "@/utils/auth";
import {amountFormatter} from "@/utils/zhijian";
export default {
  name: "Order",
  data() {
    return {
      headers: { 'Authorization': 'Bearer ' + getToken() },
      importUrl:  process.env.VUE_APP_BASE_API + "/shop/order/order_read",
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 遮罩层
      loading: true,
      lists:[],
      shopList:[],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        pullType: 'ORDER'
      },
      // 表单参数
      form: {
        createTime:null,
        shopId:null
      },
      rules: {
        shopId: [
          { required: true, message: "不能为空", trigger: "blur" }
        ],
        createTime: [
          { required: true, message: "不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    listShop({}).then(response => {
        this.shopList = response.rows;
      });
  },
  mounted() {
    if(this.$route.query.shopId){
        this.queryParams.shopId = this.$route.query.shopId
    }
  },
  methods: {
    amountFormatter,
    uploadSuccess(response, file, fileList){
      console.log("========成功",response.data)
      console.log('文件列表:', fileList)
      // 保存返回数据
      this.lists = response.data
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.orderNum)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.pullLoading = false
      this.queryParams.shopId = this.form.shopId
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.pullLoading = false
      this.resetForm("queryForm");
      this.handleQuery();
    },
    handlePull() {
        this.pullLoading = true
      importOrder({shopId:this.queryParams.shopId,createTime:this.form.createTime}).then(response => {
          console.log('导入店铺订单接口返回=====',response)
          this.pullLoading = false
        })

    }
  }
};
</script>
