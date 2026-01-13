<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
      <el-tab-pane label="店铺售后列表" name="orderList" >
        <RefundList></RefundList>
      </el-tab-pane>
      <el-tab-pane label="店铺售后处理" name="orderItemList" lazy>
        <AfterSaleProcess></AfterSaleProcess>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import RefundList  from "@/views/refund/refund_list.vue";
import AfterSaleProcess  from "@/views/refund/after_sale_process.vue";


export default {
  name: "Refund",
  components:{ RefundList, AfterSaleProcess},
  data() {
    return {
      activeName: 'orderList',
      typeList: [],
    };
  },
  created() {

  },
  mounted() {

  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event);
    }
  }
};
</script>
