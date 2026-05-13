# 启航智云电商ERP系统

> Vue CLI 5 + Webpack 5 + Vue 2.7 + Element UI 版本

---

## 📁 项目结构

```
vue-erp-v5/
├── src/                      # 源代码
│   ├── api/                  # API接口封装
│   ├── assets/               # 静态资源
│   ├── components/           # 公共组件
│   ├── directive/            # 自定义指令
│   ├── filters/              # 过滤器
│   ├── icons/                # 图标资源
│   ├── layout/               # 布局组件
│   ├── router/               # 路由配置
│   ├── store/                # Vuex状态管理
│   ├── utils/                # 工具函数
│   ├── views/                # 页面视图
│   ├── App.vue               # 根组件
│   ├── main.js               # 入口文件
│   └── permission.js         # 权限控制
├── public/                   # 静态文件
├── .env.development          # 开发环境配置
├── .env.production           # 生产环境配置
├── vue.config.js             # Vue CLI配置
├── babel.config.js           # Babel配置
├── package.json              # 依赖配置
└── README.md                 # 项目说明
```

---

## 🎯 技术栈

| 分类 | 技术 | 版本 | 说明 |
|------|------|------|------|
| 构建工具 | Vue CLI | 5.0.8 | 内置 Webpack 5 |
| 打包工具 | Webpack | 5.x | 由 Vue CLI 5 内置 |
| 框架 | Vue | 2.7.16 | Vue 2 最终版本，支持 Composition API |
| UI组件 | Element UI | 2.15.13 | 桌面端UI组件库 |
| 路由 | Vue Router | 3.5.3 | 路由管理 |
| 状态管理 | Vuex | 3.6.2 | 状态管理 |
| HTTP客户端 | axios | 0.24.0 | HTTP请求库 |
| CSS预处理器 | Sass | 1.69.5 | Dart Sass |

---

## 📊 依赖版本详情

### 核心依赖

```json
{
  "vue": "2.7.16",
  "element-ui": "2.15.13",
  "vue-router": "3.5.3",
  "vuex": "3.6.2",
  "axios": "0.24.0",
  "core-js": "3.25.3"
}
```

### 第三方库

| 库名 | 版本 | 用途 |
|------|------|------|
| echarts | 5.4.0 | 图表可视化 |
| vant | 2.13.9 | 移动端UI组件 |
| quill | 1.3.7 | 富文本编辑器 |
| sortablejs | 1.10.2 | 拖拽排序 |
| screenfull | 5.0.2 | 全屏API |
| marked | 4.0.18 | Markdown解析 |
| fuse.js | 6.4.3 | 模糊搜索 |

### 工具类

| 库名 | 版本 | 用途 |
|------|------|------|
| js-cookie | 3.0.1 | Cookie操作 |
| clipboard | 2.0.8 | 剪贴板操作 |
| file-saver | 2.0.5 | 文件下载 |
| jsencrypt | 3.0.0-rc.1 | RSA加密 |
| nprogress | 0.2.0 | 页面加载进度条 |

### 开发依赖

| 库名 | 版本 | 用途 |
|------|------|------|
| @vue/cli-service | 5.0.8 | Vue CLI服务 |
| @vue/cli-plugin-babel | 5.0.8 | Babel插件 |
| @vue/cli-plugin-eslint | 5.0.8 | ESLint插件 |
| sass-loader | 13.3.2 | Sass加载器 |
| svg-sprite-loader | 6.0.11 | SVG精灵加载器 |
| compression-webpack-plugin | 10.0.0 | Gzip压缩 |

---

## 🔄 升级记录

### 从 vue-erp (Vue CLI 4 + Webpack 4) 升级

| 升级项 | 原版本 | 新版本 | 说明 |
|--------|--------|--------|------|
| Vue CLI | 4.x | **5.0.8** | 构建工具升级 |
| Webpack | 4.x | **5.x** | 打包性能提升 |
| Vue | 2.6.x | **2.7.16** | 支持 Composition API |
| sass-loader | 10.x | **13.x** | Dart Sass 支持 |
| compression-webpack-plugin | 5.x | **10.x** | Gzip压缩升级 |

### Vue 2.7 新特性

Vue 2.7 是 Vue 2 的最终版本，支持 Composition API：

```javascript
<script setup>
import { ref, computed, watch } from 'vue'

const count = ref(0)
const doubled = computed(() => count.value * 2)

watch(count, (newVal) => {
  console.log('count changed:', newVal)
})
</script>
```

---

## 🚀 快速开始

### 环境要求

- Node.js >= 14.0.0
- npm >= 6.0.0

### 安装依赖

```bash
npm install
```

### 开发模式

```bash
npm run dev
```

访问: http://localhost:88/

### 生产构建

```bash
npm run build:prod
```

### 测试环境构建

```bash
npm run build:stage
```

### 代码检查

```bash
npm run lint
```

---

## 📋 功能特性

- ✅ 通用验证系统
- ✅ 登录 Token 认证
- ✅ 动态菜单加载（从数据库）
- ✅ 角色权限管理
- ✅ 按钮级权限控制
- ✅ 国际化支持
- ✅ 响应式布局

---

## 🔧 配置说明

### 环境变量

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| VUE_APP_TITLE | 应用标题 | 启航智云电商ERP系统 |
| VUE_APP_BASE_API | API基础路径 | /api |

### 开发服务器配置

```javascript
// vue.config.js
devServer: {
  host: '0.0.0.0',
  port: 88,
  proxy: {
    [process.env.VUE_APP_BASE_API]: {
      target: 'http://localhost:8088',
      changeOrigin: true,
      pathRewrite: {
        ['^' + process.env.VUE_APP_BASE_API]: ''
      }
    }
  }
}
```

---

## 📝 版本历史

| 版本 | 日期 | 说明 |
|------|------|------|
| 5.0.1 | 2026-05-11 | Vue CLI 5 + Webpack 5 + Vue 2.7 升级完成 |
| 5.0.0 | 2026-05-11 | 项目初始化 |

### 🔄 升级日志 (5.0.0 → 5.0.1)

#### 核心框架升级
| 组件 | 原版本 | 新版本 | 说明 |
|------|--------|--------|------|
| Vue CLI | 4.x | 5.0.8 | 构建工具升级，内置 Webpack 5 |
| Webpack | 4.x | 5.x | 打包性能大幅提升 |
| Vue | 2.6.14 | 2.7.16 | Vue 2 最终版本，支持 Composition API |
| sass-loader | 10.x | 13.3.2 | 支持 Dart Sass |
| compression-webpack-plugin | 5.x | 10.0.0 | Gzip 压缩升级 |
| vant | 2.12.54 | 2.13.9 | 移动端 UI 组件库升级 |

#### 修复与优化
- ✅ 修复 vant ESM 兼容性问题（Webpack 5 兼容）
- ✅ 迁移所有旧版页面和接口
- ✅ 菜单从数据库动态加载
- ✅ 角色权限管理正常工作
- ✅ 侧边栏主题改为浅色（白色背景）
- ✅ 修复 `exports is not defined` 运行时错误
- ✅ 修复页面空白问题
- ✅ 修复登录重定向问题

#### Vue 2.7 新特性
Vue 2.7 支持 Composition API，可使用 `<script setup>` 语法：
```javascript
<script setup>
import { ref, computed, watch } from 'vue'

const count = ref(0)
const doubled = computed(() => count.value * 2)

watch(count, (newVal) => {
  console.log('count changed:', newVal)
})
</script>
```

#### 生产环境就绪
- ✅ 项目能正常构建 (`npm run build:prod`)
- ✅ 开发服务器运行正常
- ✅ 页面渲染正常
- ⚠️ 建议进行功能测试、兼容性测试、性能测试后再上线

#### 旧版代码处理
新项目已包含所有旧版功能，理论上旧版 `vue-erp` 代码可以不再使用。建议暂时保留旧版作为回滚方案，确认新版本稳定运行一段时间后再删除。

---

## 📄 许可证

MIT License

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

---

*启航智云科技 © 2026*
