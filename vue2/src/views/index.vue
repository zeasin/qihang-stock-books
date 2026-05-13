<template>
  <div class="dashboard-editor-container">
    <panel-group :chart-data="report" @handleSetLineChartData="handleSetLineChartData" />
  </div>
</template>

<script>
import PanelGroup from './dashboard/PanelGroup'
import LineChart from './dashboard/LineChart'
import RaddarChart from './dashboard/RaddarChart'
import PieChart from './dashboard/PieChart'
import BarChart from './dashboard/BarChart'
import { todayDaily } from '@/api/report/report'
const lineChartData = {
  // newVisitis: {
  //   expectedData: [100, 120, 161, 134, 105, 160, 165],
  //   actualData: [120, 82, 91, 154, 162, 140, 145]
  // },
  // messages: {
  //   expectedData: [200, 192, 120, 144, 160, 130, 140],
  //   actualData: [180, 160, 151, 106, 145, 150, 130]
  // },
  // purchases: {
  //   expectedData: [80, 100, 121, 104, 105, 90, 100],
  //   actualData: [120, 90, 100, 138, 142, 130, 130]
  // },
  // shoppings: {
  //   expectedData: [130, 140, 141, 142, 145, 150, 160],
  //   actualData: [120, 82, 91, 154, 162, 140, 130]
  // }
  salesDaily: {
    date:['09-15','09-16','09-17','09-18','09-19','09-20','09-21'],
    salesVolume: [130, 140, 141, 142, 145, 150, 160],
    salesOrder: [120, 82, 91, 154, 162, 140, 130]
  }
}

export default {
  name: 'Index',
  components: {
    PanelGroup,
    LineChart,
    RaddarChart,
    PieChart,
    BarChart
  },
  data() {
    return {
      lineChartData: {
        date:[],
        salesVolume:[],
        salesOrder:[]
      },
      skuTopData:{
        data:[
          // { value: 320, name: 'AAA' },
          // { value: 240, name: 'BBB' },
          // { value: 149, name: 'CC' },
          // { value: 100, name: 'DD' },
          // { value: 59, name: 'DEEE' }
        ]
      },
      report:{
        userType:0,
        waitShip:50,
        salesVolume:5989.98,
        orderCount:302,
        shopCount:8
      }
    }
  },
  mounted() {
    // 加载统计
    todayDaily().then(resp=>{
      this.report = resp.data
    })
  },
  methods: {
    handleSetLineChartData(type) {
      // this.lineChartData = lineChartData[type]
    },
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: rgb(240, 242, 245);
  position: relative;

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }
}

@media (max-width:1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}

.floating-ai-menu {
  position: fixed;
  right: 30px;
  top: 50%;
  transform: translateY(-50%);
  z-index: 1000;
  display: flex;
  flex-direction: column;
  align-items: center;

  .floating-menu-tooltip {
    margin-top: 8px;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    opacity: 0;
    transition: opacity 0.3s;
    white-space: nowrap;
  }

  &:hover .floating-menu-tooltip {
    opacity: 1;
  }
}
</style>
