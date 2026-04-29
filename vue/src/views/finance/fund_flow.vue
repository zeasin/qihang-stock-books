<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="凭证号" prop="voucherNo">
        <el-input
          v-model="queryParams.voucherNo"
          placeholder="请输入凭证号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="会计科目" prop="accountType">
        <el-select v-model="queryParams.accountType" placeholder="请选择会计科目" clearable @change="handleQuery">
          <el-option label="销售收入" value="销售收入" />
          <el-option label="采购成本" value="采购成本" />
          <el-option label="回收支出" value="回收支出" />
          <el-option label="日常支出" value="日常支出" />
          <el-option label="差旅报销" value="差旅报销" />
        </el-select>
      </el-form-item>
      <el-form-item label="业务日期" prop="businessDate">
        <el-date-picker
          v-model="queryParams.businessDate"
          type="date"
          placeholder="选择业务日期"
          @change="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >手动录入</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="dataList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="凭证号" align="left" prop="voucherNo" width="200px" />
      <el-table-column label="业务日期" align="center" prop="businessDate" width="150px">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.businessDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="会计科目" align="center" prop="accountType" />
      <el-table-column label="收入金额" align="center" prop="incomeAmount" />
      <el-table-column label="支出金额" align="center" prop="expenseAmount" />
      <el-table-column label="来源类型" align="center" prop="sourceType" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="创建时间" align="center" prop="createdTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleVoid(scope.row)"
          >作废</el-button>
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
    <!-- 手动录入对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="业务日期" prop="businessDate">
          <el-date-picker
            v-model="form.businessDate"
            type="date"
            placeholder="选择业务日期"
            style="width: 300px"
          />
        </el-form-item>
        <el-form-item label="会计科目" prop="accountType">
          <el-select v-model="form.accountType" placeholder="请选择会计科目" style="width: 300px">
            <el-option label="销售收入" value="销售收入" />
            <el-option label="采购成本" value="采购成本" />
            <el-option label="回收支出" value="回收支出" />
            <el-option label="日常支出" value="日常支出" />
            <el-option label="差旅报销" value="差旅报销" />
          </el-select>
        </el-form-item>
        <el-form-item label="收入金额" prop="incomeAmount">
          <el-input v-model="form.incomeAmount" placeholder="请输入收入金额" style="width: 300px" />
        </el-form-item>
        <el-form-item label="支出金额" prop="expenseAmount">
          <el-input v-model="form.expenseAmount" placeholder="请输入支出金额" style="width: 300px" />
        </el-form-item>
        <el-form-item label="来源类型" prop="sourceType">
          <el-select v-model="form.sourceType" placeholder="请选择来源类型" style="width: 300px">
            <el-option label="订单" value="order" />
            <el-option label="采购" value="purchase" />
            <el-option label="回收" value="recovery" />
            <el-option label="报销" value="expense_application" />
          </el-select>
        </el-form-item>
        <el-form-item label="来源ID" prop="sourceId">
          <el-input v-model="form.sourceId" placeholder="请输入来源ID" style="width: 300px" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input type="textarea" v-model="form.remark" placeholder="请输入备注" style="width: 300px" />
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
import { list, add, voidFlow } from '@/api/finance/fund_flow'
import { parseTime } from '@/utils/zhijian'

export default {
  name: "FundFlow",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 表格数据
      dataList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        voucherNo: null,
        accountType: null,
        businessDate: null,
      },
      // 表单参数
      form: {
        merchantId: null,
        shopId: null,
        businessDate: null,
        accountType: null,
        incomeAmount: 0,
        expenseAmount: 0,
        sourceType: null,
        sourceId: null,
        remark: null
      },
      // 表单校验
      rules: {
        businessDate: [{ required: true, message: "请选择业务日期", trigger: "change" }],
        accountType: [{ required: true, message: "请选择会计科目", trigger: "change" }],
        sourceType: [{ required: true, message: "请选择来源类型", trigger: "change" }],
      }
    };
  },
  created() {
    this.form.merchantId = this.$store.state.user.merchantId;
    this.form.shopId = this.$store.state.user.shopId || 0;
    this.getList();
  },
  methods: {
    parseTime,
    /** 查询财务流水列表 */
    getList() {
      this.loading = true;
      list(this.queryParams).then(response => {
        this.dataList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        merchantId: this.$store.state.user.merchantId,
        shopId: this.$store.state.user.shopId || 0,
        businessDate: null,
        accountType: null,
        incomeAmount: 0,
        expenseAmount: 0,
        sourceType: null,
        sourceId: null,
        remark: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open=true
      this.title="手动录入财务流水"
    },
    handleVoid(row) {
      this.$modal.confirm('确定要作废这条财务流水吗？').then(() => {
        voidFlow({ id: row.id }).then(response => {
          if (response.code === 200) {
            this.$modal.msgSuccess("作废成功");
            this.getList();
          } else {
            this.$modal.msgError(response.msg);
          }
        });
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          add(this.form).then(response => {
            if (response.code === 200) {
              this.$modal.msgSuccess("录入成功");
              this.open = false;
              this.reset();
              this.getList();
            } else {
              this.$modal.msgError(response.msg);
            }
          });
        }
      });
    }
  }
};
</script>
