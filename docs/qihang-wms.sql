/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : qihang-wms

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 14/01/2026 09:29:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for erp_logistics
-- ----------------------------
DROP TABLE IF EXISTS `erp_logistics`;
CREATE TABLE `erp_logistics`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司编码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NULL DEFAULT NULL COMMENT '状态（0禁用1启用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购物流公司表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_logistics
-- ----------------------------

-- ----------------------------
-- Table structure for erp_purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order`;
CREATE TABLE `erp_purchase_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `order_num` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单编号',
  `order_date` date NOT NULL COMMENT '订单日期',
  `order_time` bigint NOT NULL COMMENT '订单创建时间',
  `order_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `ship_amount` decimal(6, 2) NOT NULL COMMENT '物流费用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '订单状态 0待审核1已审核101供应商已确认102供应商已发货2已收货3已入库',
  `audit_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '采购单审核人',
  `audit_time` bigint NULL DEFAULT 0 COMMENT '审核时间',
  `supplier_confirm_time` datetime NULL DEFAULT NULL COMMENT '供应商确认时间',
  `supplier_delivery_time` datetime NULL DEFAULT NULL COMMENT '供应商发货时间',
  `received_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order
-- ----------------------------
INSERT INTO `erp_purchase_order` VALUES (2, 34, 'PUR20251228153252', '2025-12-28', 1766907172, 0.00, 0.00, NULL, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2025-12-28 15:32:53', NULL, NULL);
INSERT INTO `erp_purchase_order` VALUES (3, 34, 'PUR20251228153353', '2025-12-28', 1766907233, 0.00, 0.00, NULL, 0, '', 0, NULL, NULL, NULL, NULL, 'admin', '2025-12-28 15:33:54', NULL, NULL);

-- ----------------------------
-- Table structure for erp_purchase_order_cost
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_cost`;
CREATE TABLE `erp_purchase_order_cost`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '采购单ID（主键）',
  `supplier_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '采购单金额',
  `order_date` date NULL DEFAULT NULL COMMENT '采购订单日期',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购订单编号',
  `order_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `order_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `order_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  `actual_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '实际金额',
  `freight` decimal(6, 2) NULL DEFAULT NULL COMMENT '运费',
  `confirm_user` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '确认人',
  `confirm_time` datetime NULL DEFAULT NULL COMMENT '确认时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `pay_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '已支付金额',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `pay_count` int NULL DEFAULT NULL COMMENT '支付次数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `status` int NULL DEFAULT NULL COMMENT '状态（0未支付1已支付）',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单费用确认表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_cost
-- ----------------------------

-- ----------------------------
-- Table structure for erp_purchase_order_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_item`;
CREATE TABLE `erp_purchase_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NULL DEFAULT 0 COMMENT '订单id',
  `order_num` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '订单编号',
  `trans_type` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '150501采购 150502退货',
  `amount` double NULL DEFAULT 0 COMMENT '购货金额',
  `order_date` date NULL DEFAULT NULL COMMENT '订单日期',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `goods_id` bigint NULL DEFAULT 0 COMMENT '商品ID',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `spec_id` bigint NULL DEFAULT 0 COMMENT '商品规格id',
  `spec_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `color_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `color_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `size_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尺码',
  `style_value` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '款式',
  `price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '单价',
  `dis_amount` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '折扣额',
  `dis_rate` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '折扣率',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '数量(采购单据)',
  `inQty` bigint NOT NULL DEFAULT 0 COMMENT '已入库数量',
  `locationId` int NULL DEFAULT NULL COMMENT '入库的仓库id',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '1删除 0正常',
  `status` int NULL DEFAULT 0 COMMENT '状态（同billStatus）0待审核1正常2已作废3已入库',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type`(`trans_type` ASC) USING BTREE,
  INDEX `billdate`(`order_date` ASC) USING BTREE,
  INDEX `invId`(`goods_id` ASC) USING BTREE,
  INDEX `transType`(`trans_type` ASC) USING BTREE,
  INDEX `iid`(`order_id` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_item
-- ----------------------------
INSERT INTO `erp_purchase_order_item` VALUES (2, 2, 'PUR20251228153252', 'Purchase', 22.9, '2025-12-28', '', 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 47, 'LSZMLED0010024W', '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', '24W', '', 22.90, 0.00, 0.00, 1, 0, NULL, 0, 0);
INSERT INTO `erp_purchase_order_item` VALUES (3, 3, 'PUR20251228153353', 'Purchase', 22.9, '2025-12-28', '', 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 46, 'LSZMLED0010018W', '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', '18W', '', 22.90, 0.00, 0.00, 1, 0, NULL, 0, 0);

-- ----------------------------
-- Table structure for erp_purchase_order_payable
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_payable`;
CREATE TABLE `erp_purchase_order_payable`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `supplier_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商名称',
  `amount` decimal(10, 2) NOT NULL COMMENT '应付金额',
  `date` date NOT NULL COMMENT '应付日期',
  `invoice_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票号码',
  `purchase_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购单号',
  `purchase_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购说明',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态（0已生成1已结算)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购单应付款' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_payable
-- ----------------------------

-- ----------------------------
-- Table structure for erp_purchase_order_ship
-- ----------------------------
DROP TABLE IF EXISTS `erp_purchase_order_ship`;
CREATE TABLE `erp_purchase_order_ship`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '采购单ID（主键）',
  `supplier_id` bigint NOT NULL COMMENT '供应商id',
  `order_id` bigint NULL DEFAULT NULL,
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `freight` decimal(6, 2) NULL DEFAULT NULL COMMENT '运费',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `receipt_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` int NULL DEFAULT NULL COMMENT '状态（0未收货1已收货2已入库）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `back_count` int NULL DEFAULT NULL COMMENT '退回数量',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `stock_in_count` int NULL DEFAULT NULL COMMENT '入库数量',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `order_date` date NULL DEFAULT NULL COMMENT '采购订单日期',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '采购订单编号',
  `order_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `order_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `order_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '采购订单物流表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_purchase_order_ship
-- ----------------------------

-- ----------------------------
-- Table structure for erp_stock_in
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_in`;
CREATE TABLE `erp_stock_in`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_in_num` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '入库单据编号',
  `stock_in_type` int NOT NULL COMMENT '来源类型（1采购入库2销售退货入库3盘点入库）',
  `source_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_goods_unit` int NULL DEFAULT NULL COMMENT '采购订单商品数',
  `source_spec_unit_total` int NULL DEFAULT NULL COMMENT '采购订单总件数',
  `source_spec_unit` int NULL DEFAULT NULL COMMENT '采购订单商品规格数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `stock_in_operator_id` bigint NULL DEFAULT NULL COMMENT '操作入库人id',
  `stock_in_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作入库人',
  `stock_in_time` datetime NULL DEFAULT NULL COMMENT '入库时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '入库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_in
-- ----------------------------
INSERT INTO `erp_stock_in` VALUES (1, '1767693036123762', 1, 'aaa1111', NULL, 1, 1, 1, NULL, 1, 'aa', '2026-01-06 17:52:31', 2, 'admin', '2026-01-06 17:50:49', 'admin', '2026-01-06 17:52:31');
INSERT INTO `erp_stock_in` VALUES (2, '1767693771192485', 1, '22222', NULL, 1, 12, 1, NULL, 1, '2', '2026-01-06 18:04:00', 2, 'admin', '2026-01-06 18:03:04', 'admin', '2026-01-06 18:04:00');
INSERT INTO `erp_stock_in` VALUES (3, '1767750078907676', 1, '33333', NULL, 1, 10, 1, NULL, 1, 'a', '2026-01-07 09:41:55', 2, 'admin', '2026-01-07 09:41:34', 'admin', '2026-01-07 09:41:55');

-- ----------------------------
-- Table structure for erp_stock_in_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_in_item`;
CREATE TABLE `erp_stock_in_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_in_id` bigint NOT NULL COMMENT '入库单id',
  `stock_in_type` int NULL DEFAULT NULL COMMENT '来源类型（1采购订单2退货订单）',
  `source_no` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单id',
  `source_item_id` bigint NOT NULL COMMENT '来源单itemId',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `quantity` int NOT NULL COMMENT '原始数量',
  `in_quantity` int NOT NULL DEFAULT 0 COMMENT '入库数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int NULL DEFAULT 0 COMMENT '状态（0待入库1部分入库2全部入库）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '入库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_in_item
-- ----------------------------
INSERT INTO `erp_stock_in_item` VALUES (1, 1, 1, 'aaa1111', 0, 0, 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 45, 'LSZMLED0010012W', '白光 12W', 1, 12, '', 2, 'admin', '2026-01-06 17:50:49', 'admin', '2026-01-06 17:52:31');
INSERT INTO `erp_stock_in_item` VALUES (2, 2, 1, '22222', 0, 0, 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 46, 'LSZMLED0010018W', '白光 18W', 12, 23, '', 2, 'admin', '2026-01-06 18:03:04', 'admin', '2026-01-06 18:04:00');
INSERT INTO `erp_stock_in_item` VALUES (3, 3, 1, '33333', 0, 0, 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 47, 'LSZMLED0010024W', '白光 24W', 10, 20, '', 2, 'admin', '2026-01-07 09:41:34', 'admin', '2026-01-07 09:41:55');

-- ----------------------------
-- Table structure for erp_stock_in_item_detail
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_in_item_detail`;
CREATE TABLE `erp_stock_in_item_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_in_id` bigint NOT NULL COMMENT '入库单ID',
  `stock_in_item_id` bigint NOT NULL DEFAULT 0 COMMENT '入库单ItemID',
  `stock_in_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '入库单号',
  `stock_in_source_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源单号',
  `goods_inventory_id` bigint NOT NULL DEFAULT 0 COMMENT '库存ID',
  `goods_inventory_batch_id` bigint NOT NULL DEFAULT 0 COMMENT '库存详情ID',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '出库数量',
  `warehouse_id` bigint NOT NULL COMMENT '仓库ID',
  `warehouse_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库名',
  `position_id` bigint NULL DEFAULT NULL COMMENT '仓位id',
  `position_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓位编码',
  `operator_id` bigint NULL DEFAULT 0 COMMENT '入库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库操作人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `sku_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_stock_info_item_id_index`(`goods_inventory_batch_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库仓位详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_in_item_detail
-- ----------------------------
INSERT INTO `erp_stock_in_item_detail` VALUES (1, 1, 1, '1767693036123762', 'aaa1111', 1, 1, 12, 6, NULL, 25, 'aac', 1, 'admin', '2026-01-06 17:52:31', 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 45, 'LSZMLED0010012W', '白光 12W');
INSERT INTO `erp_stock_in_item_detail` VALUES (2, 2, 2, '1767693771192485', '22222', 2, 2, 23, 6, NULL, 25, 'aac', 1, 'admin', '2026-01-06 18:04:00', 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 46, 'LSZMLED0010018W', '白光 18W');
INSERT INTO `erp_stock_in_item_detail` VALUES (3, 3, 3, '1767750078907676', '33333', 3, 3, 20, 6, NULL, 25, 'aac', 1, 'admin', '2026-01-07 09:41:55', 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 47, 'LSZMLED0010024W', '白光 24W');

-- ----------------------------
-- Table structure for erp_stock_out
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_out`;
CREATE TABLE `erp_stock_out`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_out_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '出库单编号',
  `source_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源单据号',
  `source_id` bigint NULL DEFAULT NULL COMMENT '来源单据Id',
  `stock_out_type` int NOT NULL DEFAULT 1 COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `goods_unit` int NOT NULL COMMENT '商品数',
  `spec_unit` int NOT NULL COMMENT '商品规格数',
  `spec_unit_total` int NOT NULL COMMENT '总件数',
  `out_total` int NULL DEFAULT NULL COMMENT '已出库数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL COMMENT '状态：0待出库1部分出库2全部出库',
  `print_status` int NOT NULL COMMENT '打印状态：是否打印1已打印0未打印',
  `print_time` datetime NULL DEFAULT NULL COMMENT '打印时间',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `operator_id` int NULL DEFAULT 0 COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_out
-- ----------------------------
INSERT INTO `erp_stock_out` VALUES (1, 'DDCK-20260104180112', '260103-064550356563156', 2, 1, 1, 1, 1, 0, '订单生成出库单', 0, 0, NULL, NULL, NULL, 0, '', '2026-01-04 18:01:12', '订单生成出库单', '2026-01-04 10:01:12', NULL);
INSERT INTO `erp_stock_out` VALUES (2, 'DDCK-20260107094024', '260107-477175560572373', 3, 1, 1, 1, 1, 2, '订单生成出库单', 2, 0, NULL, '2026-01-07 15:16:14', '2026-01-07 15:16:14', 1, 'admin', '2026-01-07 09:40:25', '订单生成出库单', '2026-01-07 15:16:14', 'admin');

-- ----------------------------
-- Table structure for erp_stock_out_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_out_item`;
CREATE TABLE `erp_stock_out_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `stock_out_type` int NOT NULL COMMENT '出库类型1订单拣货出库2采购退货出库3盘点出库4报损出库',
  `entry_id` bigint NOT NULL COMMENT '出库单id（外键）',
  `entry_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库单号',
  `source_order_id` bigint NOT NULL COMMENT '来源订单id',
  `source_order_item_id` bigint NOT NULL COMMENT '来源订单itemId出库对应的itemId，如：order_item表id、invoice_info表id',
  `source_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '来源订单号',
  `source_sub_order_num` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源子订单号',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_sku_id` bigint NOT NULL DEFAULT 0 COMMENT '商品规格id',
  `sku_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码',
  `sku_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `quantity` int NOT NULL COMMENT '总数量',
  `out_quantity` int NOT NULL DEFAULT 0 COMMENT '已出库数量',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成出库时间',
  `picked_time` datetime NULL DEFAULT NULL COMMENT '完成拣货时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态：0待出库1部分出库2全部出库',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIndex`(`goods_sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库单明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_out_item
-- ----------------------------
INSERT INTO `erp_stock_out_item` VALUES (1, 1, 1, 'DDCK-20260104180112', 2, 2, '260103-064550356563156', '260103-064550356563156-1742164849116', 0, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 'LEDDX001', 12, 'LEDDX00102', '18W白光-175mm', 1, 0, NULL, NULL, 0, '2026-01-04 18:01:12', NULL);
INSERT INTO `erp_stock_out_item` VALUES (2, 1, 2, 'DDCK-20260107094024', 3, 3, '260107-477175560572373', '260107-477175560572373-1742164849117', 16, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 'LEDDX001', 47, 'LEDDX00103', '24W白光-215mm', 1, 2, '2026-01-07 15:16:14', NULL, 2, '2026-01-07 09:40:25', '2026-01-07 15:16:14');

-- ----------------------------
-- Table structure for erp_stock_out_item_detail
-- ----------------------------
DROP TABLE IF EXISTS `erp_stock_out_item_detail`;
CREATE TABLE `erp_stock_out_item_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `entry_id` bigint NOT NULL COMMENT '出库单ID',
  `entry_item_id` bigint NOT NULL DEFAULT 0 COMMENT '出库单ItemID',
  `inventory_id` bigint NOT NULL DEFAULT 0 COMMENT '库存ID',
  `inventory_batch_id` bigint NOT NULL DEFAULT 0 COMMENT '库存详情ID',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '出库数量',
  `warehouse_id` bigint NULL DEFAULT NULL COMMENT '仓库ID',
  `warehouse_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库名',
  `position_id` bigint NULL DEFAULT NULL COMMENT '仓位id',
  `position_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓位编码',
  `operator_id` bigint NULL DEFAULT 0 COMMENT '出库操作人userid',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出库操作人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_sku_id` bigint NOT NULL DEFAULT 0 COMMENT '商品规格id',
  `sku_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码',
  `sku_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `out_time` datetime NULL DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goods_stock_info_item_id_index`(`inventory_batch_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2008799820739379202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '出库仓位详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_stock_out_item_detail
-- ----------------------------
INSERT INTO `erp_stock_out_item_detail` VALUES (2008799324947480577, 2, 2, 3, 3, 1, 6, 'aa', 25, 'aac', 1, 'admin', NULL, 16, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 47, 'LSZMLED0010024W', '白光 24W', '2026-01-07 15:14:15');
INSERT INTO `erp_stock_out_item_detail` VALUES (2008799820739379201, 2, 2, 3, 3, 1, 6, 'aa', 25, 'aac', 1, 'admin', NULL, 16, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 47, 'LSZMLED0010024W', '白光 24W', '2026-01-07 15:16:14');

-- ----------------------------
-- Table structure for erp_warehouse
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouse`;
CREATE TABLE `erp_warehouse`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库名称',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `district` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '街道',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态0禁用  1正常',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_warehouse
-- ----------------------------
INSERT INTO `erp_warehouse` VALUES (6, 'aac', 'aa', '河北省', '邯郸市', '复兴区', 'aa', NULL, NULL, 1, 'admin', '2026-01-05 16:20:34', NULL, NULL);

-- ----------------------------
-- Table structure for erp_warehouse_position
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouse_position`;
CREATE TABLE `erp_warehouse_position`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse_id` int NOT NULL COMMENT '仓库id',
  `number` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库/货架编号',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓位/货架名称',
  `parent_id` int NOT NULL COMMENT '上级id',
  `depth` int NULL DEFAULT 1 COMMENT '层级深度1级2级3级',
  `parent_id1` int NOT NULL COMMENT '一级类目id',
  `parent_id2` int NOT NULL COMMENT '二级类目id',
  `address` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_delete` int NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库仓位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_warehouse_position
-- ----------------------------
INSERT INTO `erp_warehouse_position` VALUES (25, 6, 'aac', 'aa', 0, 1, 0, 0, NULL, NULL, 0, 'admin', '2026-01-05 16:20:34', NULL, NULL);

-- ----------------------------
-- Table structure for erp_warehouse_stock_take
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouse_stock_take`;
CREATE TABLE `erp_warehouse_stock_take`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_take_date` date NOT NULL COMMENT '盘点日期',
  `stock_take_man` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盘点人',
  `sku_unit` int NOT NULL COMMENT '商品sku数',
  `panying_unit` int NULL DEFAULT 0 COMMENT '盘盈数量',
  `pankui_unit` int NULL DEFAULT 0 COMMENT '盘亏数量',
  `total_quantity` int NOT NULL COMMENT '总件数',
  `result_quantity` int NOT NULL COMMENT '总结果件数',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态（0已创建1盘点中2盘点完成）',
  `result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理结果',
  `warehouse_id` bigint NOT NULL COMMENT '云仓ID',
  `warehouse_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '云仓名',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `first_take_time` datetime NULL DEFAULT NULL COMMENT '首次盘点时间',
  `complete_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库盘点表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_warehouse_stock_take
-- ----------------------------
INSERT INTO `erp_warehouse_stock_take` VALUES (3, '2026-01-08', 'admin', 0, 0, 0, 0, 0, 'aa', 0, NULL, 6, 'aa', 'admin', '2026-01-08 12:09:19', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for erp_warehouse_stock_take_item
-- ----------------------------
DROP TABLE IF EXISTS `erp_warehouse_stock_take_item`;
CREATE TABLE `erp_warehouse_stock_take_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stock_take_id` bigint NOT NULL COMMENT '盘点id',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL,
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sku_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `quantity` int NOT NULL COMMENT '原始数量',
  `take_quantity` int NOT NULL DEFAULT 0 COMMENT '盘点数量',
  `result_qty` int NOT NULL DEFAULT 0 COMMENT '盘点差异数量',
  `result` int NOT NULL COMMENT '盘点结果（0未出结果10盘平20盘盈30盘亏）',
  `result_id` bigint NULL DEFAULT NULL COMMENT '盘点处理id（盘盈入库单id，盘亏出库单id）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int NULL DEFAULT 0 COMMENT '状态（0待盘点2已盘点）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `warehouse_id` bigint NULL DEFAULT NULL COMMENT '仓库id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '盘点明细' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of erp_warehouse_stock_take_item
-- ----------------------------

-- ----------------------------
-- Table structure for o_after_sale
-- ----------------------------
DROP TABLE IF EXISTS `o_after_sale`;
CREATE TABLE `o_after_sale`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` int NULL DEFAULT NULL COMMENT '类型（0无需处理；10退货；20换货；80补发；99订单拦截；）',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NULL DEFAULT NULL COMMENT '店铺类型',
  `refund_id` bigint NULL DEFAULT NULL COMMENT '退款id（o_refund表主键）',
  `refund_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后单号',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `sub_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单号',
  `o_order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单id（o_order表主键id）',
  `o_order_item_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单id（o_order_item表主键id）',
  `sku_id` bigint NULL DEFAULT NULL COMMENT '平台商品skuid',
  `quantity` int NULL DEFAULT NULL COMMENT '售后数量',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `img` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku描述',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `o_goods_id` bigint NULL DEFAULT NULL COMMENT '系统商品id（o_goods表主键id）',
  `o_goods_sku_id` bigint NULL DEFAULT NULL COMMENT '系统商品skuId（o_goods表主键id）',
  `has_goods_send` int NULL DEFAULT NULL COMMENT ' 是否发货',
  `send_logistics_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货物流单号',
  `return_info` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回人信息json',
  `return_logistics_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回快递单号',
  `return_logistics_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退回物流公司名称',
  `receiver_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人联系电话',
  `receiver_province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `receiver_city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `receiver_town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `receiver_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人详细地址',
  `reissue_logistics_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货快递单号（补发、换货发货）',
  `reissue_logistics_company` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货快递公司',
  `status` int NULL DEFAULT NULL COMMENT '状态:0待处理；1已发出；2已收货；10已完成',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2010668039339151362 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS售后处理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_after_sale
-- ----------------------------
INSERT INTO `o_after_sale` VALUES (2010668039339151361, 10, 1011, 300, 4, '18104483624816', '260106-505146273432079', '260106-505146273432079-1742164849117', '29', '30', 1742164849117, 2, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', '1742164849117', 'LEDDX00103', 0, 0, 1, NULL, NULL, 'DPK202675485511', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '2026-01-12 18:59:52', 'admin', NULL, NULL);

-- ----------------------------
-- Table structure for o_goods
-- ----------------------------
DROP TABLE IF EXISTS `o_goods`;
CREATE TABLE `o_goods`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图片地址',
  `outer_erp_goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品唯一ID',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '商品编号',
  `unit_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '单位名称',
  `category_id` bigint NULL DEFAULT 0 COMMENT '商品分类ID',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '条码',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态1销售中2已下架',
  `length` float NOT NULL DEFAULT 0 COMMENT '衣长/裙长/裤长',
  `height` float NOT NULL DEFAULT 0 COMMENT '高度/袖长',
  `width` float NOT NULL DEFAULT 0 COMMENT '宽度/胸阔(围)',
  `width1` float NOT NULL DEFAULT 0 COMMENT '肩阔',
  `width2` float NOT NULL DEFAULT 0 COMMENT '腰阔',
  `width3` float NOT NULL DEFAULT 0 COMMENT '臀阔',
  `weight` float NOT NULL DEFAULT 0 COMMENT '重量',
  `disable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0启用   1禁用',
  `period` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '保质期',
  `pur_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '预计采购价格',
  `whole_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议批发价',
  `retail_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议零售价',
  `unit_cost` decimal(8, 2) NULL DEFAULT NULL COMMENT '单位成本',
  `supplier_id` bigint NULL DEFAULT 0 COMMENT '供应商id',
  `brand_id` bigint NULL DEFAULT 0 COMMENT '品牌id',
  `attr1` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性1：季节',
  `attr2` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性2：分类',
  `attr3` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性3：风格',
  `attr4` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性4：年份',
  `attr5` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '属性5：面料',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '外链url',
  `low_qty` int NULL DEFAULT 0 COMMENT '最低库存（预警）',
  `high_qty` int NULL DEFAULT 0 COMMENT '最高库存（预警）',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地市',
  `town` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货地区',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `goods_id_unique`(`outer_erp_goods_id` ASC) USING BTREE,
  INDEX `number`(`goods_num` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'OMS商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods
-- ----------------------------
INSERT INTO `o_goods` VALUES (16, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 'LSZMLED001', '', 4, '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, '0', 22.90, 0.00, 0.00, NULL, 34, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 'admin', '2025-10-09 14:40:12', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for o_goods_brand
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_brand`;
CREATE TABLE `o_goods_brand`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '品牌名',
  `status` int NULL DEFAULT NULL COMMENT '状态',
  `create_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_brand
-- ----------------------------

-- ----------------------------
-- Table structure for o_goods_category
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_category`;
CREATE TABLE `o_goods_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类编码',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类名称',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `parent_id` bigint NULL DEFAULT NULL COMMENT '上架分类id',
  `path` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '分类路径',
  `sort` int NULL DEFAULT 0 COMMENT '排序值',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `isDelete` tinyint(1) NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_category
-- ----------------------------
INSERT INTO `o_goods_category` VALUES (3, 'ZM', '照明', NULL, 0, '', 0, NULL, 0, 'admin', '2025-10-09 14:36:08', NULL, NULL);
INSERT INTO `o_goods_category` VALUES (4, 'LED', 'LED光源', NULL, 3, '', 0, NULL, 0, 'admin', '2025-10-09 14:36:32', NULL, NULL);

-- ----------------------------
-- Table structure for o_goods_category_attribute
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_category_attribute`;
CREATE TABLE `o_goods_category_attribute`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `category_id` bigint NOT NULL,
  `type` int NOT NULL DEFAULT 0 COMMENT '类型：0属性1规格',
  `title` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '\'属性名\'',
  `code` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '固定值color颜色size尺码style款式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_category_attribute
-- ----------------------------
INSERT INTO `o_goods_category_attribute` VALUES (2, 3, 1, '颜色', 'color');
INSERT INTO `o_goods_category_attribute` VALUES (3, 3, 1, '亮度', 'size');

-- ----------------------------
-- Table structure for o_goods_category_attribute_value
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_category_attribute_value`;
CREATE TABLE `o_goods_category_attribute_value`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键，属性值id',
  `category_attribute_id` bigint NULL DEFAULT NULL COMMENT '属性id',
  `value` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '属性值文本',
  `sku_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成SKU的编码',
  `orderNum` int NULL DEFAULT 0,
  `isDelete` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 431 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_category_attribute_value
-- ----------------------------
INSERT INTO `o_goods_category_attribute_value` VALUES (427, 2, '白光', '00', 0, 0);
INSERT INTO `o_goods_category_attribute_value` VALUES (428, 3, '12W', '12W', 0, 0);
INSERT INTO `o_goods_category_attribute_value` VALUES (429, 3, '18W', '18W', 0, 0);
INSERT INTO `o_goods_category_attribute_value` VALUES (430, 3, '24W', '24W', 0, 0);

-- ----------------------------
-- Table structure for o_goods_inventory
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_inventory`;
CREATE TABLE `o_goods_inventory`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名',
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'SKU名',
  `quantity` bigint NOT NULL DEFAULT 0 COMMENT '当前库存',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常  1删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `warehouse_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '仓库名',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `specIdIndex`(`sku_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品库存表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_inventory
-- ----------------------------
INSERT INTO `o_goods_inventory` VALUES (1, 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 45, 'LSZMLED0010012W', '白光 12W', 12, 0, '2026-01-06 17:52:31', 'admin', '2026-01-06 09:52:30', NULL, 6, 'aa');
INSERT INTO `o_goods_inventory` VALUES (2, 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 46, 'LSZMLED0010018W', '白光 18W', 23, 0, '2026-01-06 18:04:00', 'admin', '2026-01-06 18:04:00', NULL, 6, 'aa');
INSERT INTO `o_goods_inventory` VALUES (3, 16, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', 47, 'LSZMLED0010024W', '白光 24W', 18, 0, '2026-01-07 09:41:55', 'admin', '2026-01-07 15:16:14', 'admin', 6, 'aa');

-- ----------------------------
-- Table structure for o_goods_inventory_batch
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_inventory_batch`;
CREATE TABLE `o_goods_inventory_batch`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `inventory_id` bigint NOT NULL COMMENT '库存id',
  `batch_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '批次号',
  `origin_qty` bigint NOT NULL COMMENT '初始数量',
  `current_qty` bigint NOT NULL DEFAULT 0 COMMENT '当前数量',
  `in_qty` bigint NOT NULL COMMENT '入库数量',
  `usable_qty` bigint NOT NULL COMMENT '可用数量',
  `pur_price` double NULL DEFAULT 0 COMMENT '采购价',
  `pur_id` bigint NOT NULL COMMENT '采购单id',
  `pur_item_id` bigint NOT NULL COMMENT '采购单itemId',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `sku_id` bigint NOT NULL COMMENT '规格id',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `warehouse_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库名',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `position_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓位编码',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品库存批次' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_inventory_batch
-- ----------------------------
INSERT INTO `o_goods_inventory_batch` VALUES (1, 1, '20260106175230', 0, 12, 12, 12, 0, 0, 0, NULL, 45, 16, 'LSZMLED0010012W', 6, 'aa', 25, 'aac', '2026-01-06 17:52:31', 'admin', '2026-01-06 09:52:30', NULL);
INSERT INTO `o_goods_inventory_batch` VALUES (2, 2, '20260106180400', 0, 23, 23, 23, 0, 0, 0, NULL, 46, 16, 'LSZMLED0010018W', 6, 'aa', 25, 'aac', '2026-01-06 18:04:00', 'admin', '2026-01-06 10:04:00', NULL);
INSERT INTO `o_goods_inventory_batch` VALUES (3, 3, '20260107094154', 0, 20, 20, 18, 0, 0, 0, '出库扣减库存；出库扣减库存；', 47, 16, 'LSZMLED0010024W', 6, 'aa', 25, 'aac', '2026-01-07 09:41:55', 'admin', '2026-01-07 15:16:14', 'admin');

-- ----------------------------
-- Table structure for o_goods_inventory_operation
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_inventory_operation`;
CREATE TABLE `o_goods_inventory_operation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `goods_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `batch_id` bigint NOT NULL COMMENT '库存批次id',
  `batch_num` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '库存批次号',
  `type` int NOT NULL COMMENT '库存类型（1增加库存2减少库存3锁定库存）',
  `inventory_detail_id` bigint NOT NULL COMMENT '商品库存id（本表id减库存的时候关联）',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '操作库存数量',
  `locked_quantity` int NOT NULL COMMENT '锁定库存数量（status变成已结算时把该字段值更新到quantity）',
  `price` double NULL DEFAULT 0 COMMENT '价格（type=1采购价格；type=2出库时的价格）',
  `biz_type` int NOT NULL COMMENT '业务类型（10采购入库20采购退货30退货入库40订单出库）',
  `biz_id` bigint NOT NULL COMMENT '业务单id',
  `biz_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '业务单号',
  `biz_item_id` bigint NOT NULL COMMENT '业务单itemId',
  `status` int NOT NULL COMMENT '状态（0待结算1已结算）',
  `remark` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `warehouse_id` bigint NOT NULL COMMENT '仓库id',
  `position_id` bigint NOT NULL COMMENT '仓位id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库库存操作记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_inventory_operation
-- ----------------------------

-- ----------------------------
-- Table structure for o_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_sku`;
CREATE TABLE `o_goods_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `goods_id` bigint NOT NULL COMMENT '外键（o_goods）',
  `outer_erp_goods_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部erp系统商品id',
  `outer_erp_sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外部erp系统skuId(唯一)',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名',
  `goods_num` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `sku_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '规格名',
  `sku_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规格编码',
  `color_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色label',
  `color_id` bigint NULL DEFAULT 0 COMMENT '颜色id',
  `color_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色值',
  `color_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色图片',
  `size_label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尺码label',
  `size_id` bigint NULL DEFAULT 0 COMMENT '尺码id',
  `size_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '尺码值(材质)',
  `style_label` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '款式label',
  `style_id` bigint NULL DEFAULT 0 COMMENT '款式id',
  `style_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '款式值',
  `bar_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '库存条形码',
  `pur_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '预计采购价格',
  `retail_price` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '建议零售价',
  `unit_cost` decimal(8, 2) NULL DEFAULT 0.00 COMMENT '单位成本',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态',
  `low_qty` int NULL DEFAULT 0 COMMENT '最低库存（预警）',
  `high_qty` int NULL DEFAULT 0 COMMENT '最高库存（预警）',
  `volume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'erp商品体积',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sku_id_unique`(`outer_erp_sku_id` ASC) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE,
  INDEX `number`(`sku_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS商品SKU表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_sku
-- ----------------------------
INSERT INTO `o_goods_sku` VALUES (45, 16, NULL, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', NULL, '白光 12W', 'LSZMLED0010012W', NULL, 427, '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 428, '12W', NULL, 0, '', NULL, 22.90, 0.00, 0.00, '', 1, 0, 0, NULL, '2025-10-09 06:40:12', NULL);
INSERT INTO `o_goods_sku` VALUES (46, 16, NULL, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', NULL, '白光 18W', 'LSZMLED0010018W', NULL, 427, '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 429, '18W', NULL, 0, '', NULL, 22.90, 0.00, 0.00, '', 1, 0, 0, NULL, '2025-10-09 06:40:12', NULL);
INSERT INTO `o_goods_sku` VALUES (47, 16, NULL, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', NULL, '白光 24W', 'LSZMLED0010024W', NULL, 427, '白光', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 430, '24W', NULL, 0, '', NULL, 22.90, 0.00, 0.00, '', 1, 0, 0, NULL, '2025-10-09 06:40:12', NULL);
INSERT INTO `o_goods_sku` VALUES (48, 16, NULL, NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', NULL, '双色 36W', 'LSZMLED0010036W', NULL, 428, '双色', 'https://img.pddpic.com/mms-material-img/2025-05-29/25bf5df9-764b-428c-aae2-59c3ee16f7e6.jpeg.a.jpeg', NULL, 434, '36W', NULL, 0, '', NULL, 22.90, 0.00, 0.00, '', 1, 0, 0, NULL, '2025-10-09 06:40:12', NULL);

-- ----------------------------
-- Table structure for o_goods_sku_attr
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_sku_attr`;
CREATE TABLE `o_goods_sku_attr`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint NOT NULL,
  `type` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `k` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `kid` int NULL DEFAULT NULL,
  `vid` int NULL DEFAULT NULL,
  `v` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_sku_attr
-- ----------------------------
INSERT INTO `o_goods_sku_attr` VALUES (1, 16, 'color', '颜色', 114, 427, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (2, 16, 'size', '尺码', 115, 428, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (3, 16, 'size', '尺码', 115, 429, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (4, 16, 'size', '尺码', 115, 430, NULL, NULL);
INSERT INTO `o_goods_sku_attr` VALUES (5, 16, 'style', '款式', 116, 427, NULL, NULL);

-- ----------------------------
-- Table structure for o_goods_sku_bad_stock
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_sku_bad_stock`;
CREATE TABLE `o_goods_sku_bad_stock`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `goods_id` bigint NOT NULL COMMENT '商品id',
  `sku_id` bigint NOT NULL COMMENT '商品规格id',
  `sku_code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '规格编码（唯一）',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `goods_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` int NOT NULL COMMENT '类型（1销售退货报损2仓库库存报损）',
  `source_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '来源ID（type==1时 order_send_return主键id）',
  `warehouse_id` bigint NOT NULL DEFAULT 0 COMMENT '仓库id',
  `warehouse_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '仓库名',
  `position_id` bigint NULL DEFAULT NULL COMMENT '仓位id',
  `position_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '仓位',
  `inventory_id` bigint NULL DEFAULT NULL COMMENT '库存id',
  `inventory_batch_id` bigint NULL DEFAULT NULL COMMENT '库存批次Id',
  `quantity` int NOT NULL DEFAULT 0 COMMENT '数量',
  `loss_amount` double NOT NULL DEFAULT 0 COMMENT '损失金额（最大成本）',
  `result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理结果',
  `resultTime` datetime NULL DEFAULT NULL COMMENT '处理时间',
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '理由',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '是否处理0未处理1已减库存2已完成（退供应商、销毁）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品报损记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of o_goods_sku_bad_stock
-- ----------------------------

-- ----------------------------
-- Table structure for o_goods_supplier
-- ----------------------------
DROP TABLE IF EXISTS `o_goods_supplier`;
CREATE TABLE `o_goods_supplier`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商名称',
  `number` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商编码',
  `taxRate` double NULL DEFAULT 0 COMMENT '税率',
  `amount` double NULL DEFAULT 0 COMMENT '期初应付款',
  `periodMoney` double NULL DEFAULT 0 COMMENT '期初预付款',
  `difMoney` double NULL DEFAULT 0 COMMENT '初期往来余额',
  `beginDate` date NULL DEFAULT NULL COMMENT '余额日期',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `place` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '职位',
  `linkMan` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '联系方式',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `county` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区县',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货地址详情',
  `pinYin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `disable` tinyint(1) NULL DEFAULT 0 COMMENT '0启用   1禁用',
  `isDelete` tinyint(1) NULL DEFAULT 0 COMMENT '0正常 1删除',
  `purchaserName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分管采购员',
  `createTime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_goods_supplier
-- ----------------------------
INSERT INTO `o_goods_supplier` VALUES (34, 'ASAA', 'AAS', 0, 0, 0, 0, NULL, 'AA', 'AA', 'AA', 'AA', NULL, NULL, NULL, 'AA', '', 0, 0, NULL, '2025-10-07 14:16:23');

-- ----------------------------
-- Table structure for o_logistics_company
-- ----------------------------
DROP TABLE IF EXISTS `o_logistics_company`;
CREATE TABLE `o_logistics_company`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform_id` int NULL DEFAULT NULL COMMENT '平台id',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺ID',
  `logistics_id` bigint NULL DEFAULT NULL COMMENT '物流公司id（值来自于平台返回）',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司编码（值来自于平台返回）',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司名称（值来自于平台返回）',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int NULL DEFAULT NULL COMMENT '状态（0禁用1启用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '快递公司表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_logistics_company
-- ----------------------------
INSERT INTO `o_logistics_company` VALUES (1, 100, NULL, NULL, 'aad', 'avd', 'aaa', 1);
INSERT INTO `o_logistics_company` VALUES (2, 400, NULL, NULL, 'JTSD', '极兔速递', NULL, 1);
INSERT INTO `o_logistics_company` VALUES (4, 300, NULL, NULL, 'AA', 'AA', NULL, 1);

-- ----------------------------
-- Table structure for o_order
-- ----------------------------
DROP TABLE IF EXISTS `o_order`;
CREATE TABLE `o_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单id，自增',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号（第三方平台订单号）',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shop_id` bigint NOT NULL COMMENT '店铺ID',
  `remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `buyer_memo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '买家留言信息',
  `seller_memo` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '卖家留言信息',
  `tag` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签',
  `refund_status` int NOT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `order_status` int NOT NULL COMMENT '订单状态 0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12已关闭；12退款中；21待付款；22锁定，29删除，101部分发货',
  `goods_amount` double NOT NULL DEFAULT 0 COMMENT '订单商品金额',
  `change_amount` double NOT NULL DEFAULT 0 COMMENT '订单改价折扣金额，单位元',
  `post_fee` double NULL DEFAULT 0 COMMENT '订单运费',
  `seller_discount` double NULL DEFAULT 0 COMMENT '商家优惠金额，单位：元',
  `platform_discount` double NULL DEFAULT 0 COMMENT '平台优惠金额，单位：元',
  `amount` double NOT NULL DEFAULT 0 COMMENT '订单实际金额',
  `payment` double NOT NULL DEFAULT 0 COMMENT '实付金额',
  `service_fee` double NOT NULL DEFAULT 0 COMMENT '服务费',
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人手机号',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人地址',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  `order_created` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单时间',
  `order_updated` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单更新时间',
  `order_pay_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单支付时间',
  `order_finish_time` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单完成时间',
  `shipper` bigint NOT NULL DEFAULT 0 COMMENT '发货人',
  `ship_type` int NOT NULL DEFAULT 0 COMMENT '发货方式2供应商代发0仓库发货',
  `ship_status` int NOT NULL DEFAULT 0 COMMENT '发货状态 0 待发货 1 已分配供应商发货 2全部发货',
  `ship_company` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '发货快递公司',
  `ship_code` varchar(33) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货物流公司',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '取消原因',
  `platform_order_status_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台订单状态文本',
  `platform_order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台订单状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_sn_index`(`order_num` ASC) USING BTREE,
  INDEX `shopid_index`(`shop_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_order
-- ----------------------------
INSERT INTO `o_order` VALUES (1, '260103-143340377723488', 300, 1011, NULL, '', '', NULL, 4, 11, 39.32, 0, 0, 0, 14.54, 24.78, 24.78, 0, '', '', '', '', '', '', '2026-01-03 13:08:45', '2026-01-03 13:18:01', '2026-01-03 13:08:46', '', 0, 0, 0, '0', NULL, NULL, '2026-01-03 16:08:13', NULL, '2026-01-12 12:41:07', NULL, NULL, '待发货', '1');
INSERT INTO `o_order` VALUES (2, '260103-064550356563156', 300, 1011, NULL, '', '', NULL, 4, 11, 33.93, 0, 0, 0, 0, 33.93, 33.93, 0, NULL, NULL, NULL, '', '', '', '2026-01-03 13:45:26', '2026-01-06 21:18:59', '2026-01-03 13:45:27', '', 0, 0, 2, '0', NULL, NULL, '2026-01-03 16:08:13', NULL, '2026-01-12 12:41:07', '生成出库单', NULL, '已发货待签收', '2');
INSERT INTO `o_order` VALUES (3, '260107-477175560572373', 300, 1011, NULL, '', '', NULL, 1, 1, 39.32, 0, 0, 0, 11.79, 27.53, 27.53, 0, '孔**', '***********', '****************', '湖北省', '武汉市', '黄陂区', '2026-01-07 07:27:39', '2026-01-07 07:57:41', '2026-01-07 07:27:40', '', 0, 0, 2, '0', NULL, NULL, '2026-01-07 09:38:56', NULL, '2026-01-07 09:40:25', '生成出库单', NULL, '待发货', '1');
INSERT INTO `o_order` VALUES (4, '6923393258387635672', 400, 1007, NULL, '', '', NULL, 1, 3, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '重庆市', '重庆市', '巴南区', '2026-01-04 06:51:53', '2026-01-10 08:02:32', '2026-01-04 06:51:59', '2026-01-10 08:01:52', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, '已完成', '5');
INSERT INTO `o_order` VALUES (5, '6949791995166594053', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 07:51:28', '2026-01-10 07:51:31', '2026-01-10 07:51:30', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (6, '6949816466661184517', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 07:08:00', '2026-01-10 07:08:03', '2026-01-10 07:08:02', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (7, '6949128093576795539', 400, 1007, NULL, '', '', NULL, 1, 3, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '广东省', '深圳市', '龙华区', '2025-12-19 07:00:54', '2026-01-10 07:02:47', '2025-12-19 07:00:57', '2026-01-10 07:02:47', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, '已完成', '5');
INSERT INTO `o_order` VALUES (8, '6949745776142587858', 400, 1007, NULL, '', ';申通快递(770295253646587)', NULL, 1, 2, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '陕西省', '西安市', '雁塔区', '2026-01-08 02:13:38', '2026-01-10 06:24:12', '2026-01-08 02:13:44', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (9, '6949809616992605189', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 05:42:08', '2026-01-10 05:42:11', '2026-01-10 05:42:10', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:09', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (10, '6949010657148671384', 400, 1007, NULL, '', '', NULL, 1, 11, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '江苏省', '苏州市', '虎丘区', '2025-12-16 01:12:33', '2026-01-10 05:41:09', '2025-12-16 01:12:35', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:09', NULL, NULL, '已关闭', '4');
INSERT INTO `o_order` VALUES (11, '6949809605484090373', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 05:34:53', '2026-01-10 05:34:56', '2026-01-10 05:34:55', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (12, '6949802927116588037', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 03:54:26', '2026-01-10 03:54:29', '2026-01-10 03:54:28', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (13, '6949816118446593029', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 03:41:35', '2026-01-10 03:41:38', '2026-01-10 03:41:37', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (14, '6949796186915017733', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 03:40:03', '2026-01-10 03:40:05', '2026-01-10 03:40:05', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (15, '6949796168668681221', 400, 1007, NULL, '', '', NULL, 1, 1, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, '王*', '1**********', '**************', '重庆市', '重庆市', '北碚区', '2026-01-10 03:36:11', '2026-01-10 03:36:14', '2026-01-10 03:36:14', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, '待发货', '2');
INSERT INTO `o_order` VALUES (16, '6949123396864054675', 400, 1007, NULL, '', '', NULL, 1, 3, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '广东省', '深圳市', '龙华区', '2025-12-19 03:26:40', '2026-01-10 03:30:59', '2025-12-19 03:26:43', '2026-01-10 03:30:59', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, '已完成', '5');
INSERT INTO `o_order` VALUES (17, '6949259293290730532', 400, 1007, NULL, '', '', NULL, 1, 2, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '广东省', '深圳市', '福田区', '2025-12-23 11:11:06', '2026-01-10 02:31:07', '2025-12-23 11:11:12', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (18, '6923305213814865436', 400, 1007, NULL, '', ';申通快递(770295252463508)', NULL, 1, 2, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '安徽省', '蚌埠市', '固镇县', '2025-12-30 06:08:29', '2026-01-10 02:31:07', '2025-12-30 06:08:30', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:10', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (19, '6949779094764590341', 400, 1007, NULL, '', '【0.0：16884998604179451847640开放平台测试专用店（总利润 ￥-231.99）￥232】', NULL, 1, 2, 39, -38.99, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '福建省', '福州市', '仓山区', '2026-01-09 05:45:14', '2026-01-10 02:30:56', '2026-01-09 05:46:27', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (20, '6949775342744179923', 400, 1007, NULL, '', '2026-01-09 16:47:26test0312-test(空)SF5127586136177test0312-test2026-01-09 16:47:26(空)SF5127586136177(空)涮肚2G909202511050002;(空)涮肚1G909202511050001;(空)东坡焖肉CWYZ067;(空)烧烤1G909202511050003;卖家备注', NULL, 1, 2, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '江苏省', '苏州市', '吴中区', '2026-01-09 08:29:15', '2026-01-10 02:30:56', '2026-01-09 08:29:17', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (21, '6949759759895369682', 400, 1007, NULL, '', '', NULL, 1, 2, 0.02, 0, 0, 0, 0, 0.02, 0.02, 0, NULL, NULL, NULL, '上海市', '上海市', '静安区', '2026-01-08 09:50:23', '2026-01-10 02:30:56', '2026-01-08 09:50:27', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (22, '6949752640139040063', 400, 1007, NULL, '', ';申通快递(770295252463491)', NULL, 1, 2, 0.02, 0, 0, 0, 0, 0.02, 0.02, 0, NULL, NULL, NULL, '上海市', '上海市', '青浦区', '2026-01-08 02:59:44', '2026-01-10 02:30:56', '2026-01-08 02:59:45', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (23, '6949743576382511058', 400, 1007, NULL, '', ';申通快递(770295253646587)', NULL, 1, 2, 0.01, 0, 0, 0, 0, 0.01, 0.01, 0, NULL, NULL, NULL, '陕西省', '西安市', '雁塔区', '2026-01-08 02:13:01', '2026-01-10 02:30:56', '2026-01-08 02:13:08', '1970-01-01 00:00:00', 0, 0, 0, '0', NULL, NULL, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, '已发货', '3');
INSERT INTO `o_order` VALUES (24, '260101-602941713932531', 300, 1011, NULL, '', '', NULL, 4, 11, 39.32, 0, 0, 0, 10, 29.32, 29.32, 0, '', '', '', '', '', '', '2026-01-01 14:48:29', '2026-01-01 14:53:57', '2026-01-01 14:48:36', '', 0, 0, 0, '0', NULL, NULL, '2026-01-12 11:12:56', NULL, NULL, NULL, NULL, '待发货', '1');
INSERT INTO `o_order` VALUES (25, '260101-343073113703028', 300, 1011, NULL, '', '', NULL, 4, 11, 29.35, 0, 0, 0, 0, 29.35, 29.35, 0, '', '', '', '', '', '', '2026-01-01 20:47:51', '2026-01-01 20:52:17', '2026-01-01 20:47:51', '', 0, 0, 0, '0', NULL, NULL, '2026-01-12 11:12:56', NULL, NULL, NULL, NULL, '待发货', '1');
INSERT INTO `o_order` VALUES (26, '260103-124791079222466', 300, 1011, NULL, '', '', NULL, 1, 2, 33.93, 0, 0, 1.7, 9.67, 22.56, 22.56, 0, NULL, NULL, NULL, '', '', '', '2026-01-03 22:26:41', '2026-01-06 16:58:37', '2026-01-03 22:27:57', '', 0, 0, 0, '0', NULL, NULL, '2026-01-12 12:41:07', NULL, NULL, NULL, NULL, '已发货待签收', '2');
INSERT INTO `o_order` VALUES (27, '260103-554287808822466', 300, 1011, NULL, '', '', NULL, 1, 2, 29.35, 0, 0, 1.46, 8.36, 19.53, 19.53, 0, NULL, NULL, NULL, '', '', '', '2026-01-03 22:26:41', '2026-01-06 16:58:37', '2026-01-03 22:27:57', '', 0, 0, 0, '0', NULL, NULL, '2026-01-12 12:41:07', NULL, NULL, NULL, NULL, '已发货待签收', '2');
INSERT INTO `o_order` VALUES (28, '260106-260403381772674', 300, 1011, NULL, '', '', NULL, 1, 2, 33.93, 0, 0, 0, 0, 33.93, 33.93, 0, NULL, NULL, NULL, '', '', '', '2026-01-06 17:14:59', '2026-01-09 18:30:47', '2026-01-06 17:15:00', '', 0, 0, 0, '0', NULL, NULL, '2026-01-12 12:55:42', NULL, NULL, NULL, NULL, '已发货待签收', '2');
INSERT INTO `o_order` VALUES (29, '260106-505146273432079', 300, 1011, NULL, '', '', NULL, 2, 11, 78.64, 0, 0, 3.93, 0, 74.71, 74.71, 0, NULL, NULL, NULL, '', '', '', '2026-01-06 22:39:53', '2026-01-10 22:41:28', '2026-01-06 22:40:01', '', 0, 0, 0, '0', NULL, NULL, '2026-01-12 12:55:42', NULL, NULL, NULL, NULL, '已发货待签收', '2');
INSERT INTO `o_order` VALUES (30, '260113-074742505040578', 300, 1011, NULL, '', '', NULL, 4, 11, 33.93, 0, 0, 0, 0, 33.93, 33.93, 0, '', '', '', '', '', '', '2026-01-13 08:17:17', '2026-01-13 08:19:30', '2026-01-13 08:17:19', '', 0, 0, 0, '0', NULL, NULL, '2026-01-13 10:53:58', NULL, NULL, NULL, NULL, '待发货', '1');

-- ----------------------------
-- Table structure for o_order_item
-- ----------------------------
DROP TABLE IF EXISTS `o_order_item`;
CREATE TABLE `o_order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id，自增',
  `shop_id` bigint NOT NULL COMMENT '店铺ID',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `order_id` bigint NOT NULL COMMENT '订单ID（o_order外键）',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号（第三方平台）',
  `sub_order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '子订单号（第三方平台）',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台skuId',
  `goods_id` bigint NOT NULL DEFAULT 0 COMMENT '商品id(o_goods外键)',
  `goods_sku_id` bigint NOT NULL DEFAULT 0 COMMENT '商品skuid(o_goods_sku外键)',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `goods_price` double NOT NULL COMMENT '商品单价',
  `item_amount` double NULL DEFAULT NULL COMMENT '子订单金额',
  `discount_amount` double NULL DEFAULT 0 COMMENT '子订单优惠金额',
  `payment` double NULL DEFAULT NULL COMMENT '实际支付金额',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `refund_count` int NULL DEFAULT 0 COMMENT '已退货数量',
  `refund_status` int NULL DEFAULT NULL COMMENT '售后状态 1：无售后或售后关闭，2：售后处理中，3：退款中，4： 退款成功 ',
  `order_status` int NULL DEFAULT NULL COMMENT '订单状态1：待发货，2：已发货，3：已完成，11已取消；21待付款',
  `shipper` bigint NOT NULL DEFAULT 0 COMMENT '发货人',
  `ship_type` int NOT NULL DEFAULT 0 COMMENT '发货方式 0 自己发货或待处理2供应商发货',
  `ship_status` int NOT NULL DEFAULT 0 COMMENT '发货状态 0 待发货  2全部发货',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `platform_order_status` int NULL DEFAULT NULL COMMENT '平台订单状态',
  `platform_order_status_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台订单状态文本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goodId_index`(`goods_id` ASC) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  INDEX `order_num_index`(`order_num` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS订单明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_order_item
-- ----------------------------
INSERT INTO `o_order_item` VALUES (1, 1011, 300, 1, '260103-143340377723488', '260103-143340377723488-1742164849117', '1742164849117', 16, 47, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 'LEDDX001', '24W白光-215mm', 'LEDDX00103', 39.32, 39.32, 0, 39.32, 1, NULL, 0, 1, 1, 0, 0, 0, '2026-01-03 16:08:13', NULL, '2026-01-12 12:41:07', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (2, 1011, 300, 2, '260103-064550356563156', '260103-064550356563156-1742164849116', '1742164849116', 16, 46, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 'LEDDX001', '18W白光-175mm', 'LEDDX00102', 33.93, 33.93, 0, 33.93, 1, NULL, 0, 1, 2, 0, 0, 2, '2026-01-03 16:08:13', NULL, '2026-01-12 12:41:07', '出库备货', NULL, NULL);
INSERT INTO `o_order_item` VALUES (3, 1011, 300, 3, '260107-477175560572373', '260107-477175560572373-1742164849117', '1742164849117', 16, 47, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 'LEDDX001', '24W白光-215mm', 'LEDDX00103', 39.32, 39.32, 0, 39.32, 1, NULL, 0, 1, 1, 0, 0, 2, '2026-01-07 09:38:56', NULL, '2026-01-07 09:40:25', '出库备货', NULL, NULL);
INSERT INTO `o_order_item` VALUES (4, 1007, 400, 4, '6923393258387635672', '6923393258387635672', '3623427283808258', 0, 0, '【测试商品勿拍】测试商品-源选线上库存2658031546412462', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_2ef63a32ff24988251b0f746265e2523_sx_314190_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 1, 4, 5, 0, 0, 0, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (5, 1007, 400, 5, '6949791995166594053', '6949791995166594053', '1750172828570655', 0, 0, '【测试商品勿拍】半身裙显瘦白色X型黑色蛋糕裙大码大田裙子', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_51d5ff356da0f3664980f84a9029bedb_sx_24925_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (6, 1007, 400, 6, '6949816466661184517', '6949816466661184517', '1750172828570655', 0, 0, '【测试商品勿拍】半身裙显瘦白色X型黑色蛋糕裙大码大田裙子', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_51d5ff356da0f3664980f84a9029bedb_sx_24925_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (7, 1007, 400, 7, '6949128093576795539', '6949128093576795539', '3417476047510530', 0, 0, '【测试商品】测试半身裙ZTX20240910001', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_37a036e05c9936e8087f03d5918baafe_sx_309843_www800-800', '0', NULL, '20240904001002CODE', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 5, 0, 0, 0, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (8, 1007, 400, 8, '6949745776142587858', '6949745776142587858', '3629163995110146', 0, 0, '【测试商品勿拍】羊毛袜子女冬天保暖中筒圣诞复古麋鹿堆堆袜', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_d4cd50bf62355242a286d4e30d5ab0dc_sx_329867_www800-800', '0', NULL, '6122107374405', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:08', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (9, 1007, 400, 9, '6949809616992605189', '6949809616992605189', '3400024810573570', 0, 0, '【测试商品勿拍】单品007衬衫上衣', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_e6cd65d17cc9a1fd1e4b5dc0217656eb_sx_70577_www479-479', '1769542828717744128', NULL, '1769542828789047296', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:21', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (10, 1007, 400, 10, '6949010657148671384', '6949010657148671384', '3619283222658050', 0, 0, '【测试商品勿拍】半身裙夏季大田2025-12-03 11:44:49-leng', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/v1_ALSUvYM_70630259408755264040798_16991a88a61d1a1f4ab8bc526fcb7762_sx_388998_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 1, 4, 4, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (11, 1007, 400, 11, '6949809605484090373', '6949809605484090373', '3400024810573570', 0, 0, '【测试商品勿拍】单品007衬衫上衣', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_e6cd65d17cc9a1fd1e4b5dc0217656eb_sx_70577_www479-479', '1769542828717744128', NULL, '1769542828789047296', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (12, 1007, 400, 12, '6949802927116588037', '6949802927116588037', '3400024810573570', 0, 0, '【测试商品勿拍】单品007衬衫上衣', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_e6cd65d17cc9a1fd1e4b5dc0217656eb_sx_70577_www479-479', '1769542828717744128', NULL, '1769542828789047296', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (13, 1007, 400, 13, '6949816118446593029', '6949816118446593029', '3400024810573570', 0, 0, '【测试商品勿拍】单品007衬衫上衣', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_e6cd65d17cc9a1fd1e4b5dc0217656eb_sx_70577_www479-479', '1769542828717744128', NULL, '1769542828789047296', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (14, 1007, 400, 14, '6949796186915017733', '6949796186915017733', '1750172828570655', 0, 0, '【测试商品勿拍】半身裙显瘦白色X型黑色蛋糕裙大码大田裙子', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_51d5ff356da0f3664980f84a9029bedb_sx_24925_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (15, 1007, 400, 15, '6949796168668681221', '6949796168668681221', '1750172828570655', 0, 0, '【测试商品勿拍】半身裙显瘦白色X型黑色蛋糕裙大码大田裙子', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_51d5ff356da0f3664980f84a9029bedb_sx_24925_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (16, 1007, 400, 16, '6949123396864054675', '6949123396864054675', '3417476047511042', 0, 0, '【测试商品】测试半身裙ZTX20240910001', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_37a036e05c9936e8087f03d5918baafe_sx_309843_www800-800', '0', NULL, '20240904001004CODE', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 5, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (17, 1007, 400, 17, '6949259293290730532', '6949259293290730532', '3411571523508994', 0, 0, '【PA测试勿动】婚礼复古欧美简约新款网红爆款头纱气质白色', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b8efe9381652d59decaedecccb14f05_sx_323405_www730-730', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:09', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (18, 1007, 400, 18, '6923305213814865436', '6923305213814865436', '3623618022704642', 0, 0, '【测试商品勿拍】源选线上库存03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_2ef63a32ff24988251b0f746265e2523_sx_314190_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:22', NULL, '2026-01-10 16:52:10', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (19, 1007, 400, 19, '6949779094764590341', '6949779094764590341', '3625873415842818', 0, 0, 'Dove/德芙【测试商品勿拍】可爱小熊耳朵加厚毛毛绒中', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5e19ef21614783a0f44fe034e60bcbbc_sx_94759_www700-700', '0', NULL, '5146084489368', 39, 39, 0, 0.01, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (20, 1007, 400, 20, '6949775342744179923', '6949775342744179923', '3619283222658050', 0, 0, '【测试商品勿拍】半身裙裙子夏季大田2025-12-0311:44:49-leng', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/v1_ALSUvYM_70630259408755264040798_16991a88a61d1a1f4ab8bc526fcb7762_sx_388998_www800-800', '0', NULL, '', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (21, 1007, 400, 20, '6949775342744179923', '6949775342744245459', '3562349700644610', 0, 0, '【测试商品勿拍】直销 家用缝纫机梭心 梭芯 老式缝纫机梭芯 缝纫', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_110e4a5d54ebaf30d03994f9689fca2e_sx_87240_www1300-1300', '0', NULL, '', 4.1, 0, 0, 0, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (22, 1007, 400, 21, '6949759759895369682', '6949759759895369682', '3629163995110146', 0, 0, '【测试商品勿拍】羊毛袜子女冬天保暖中筒圣诞复古麋鹿堆堆袜', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_d4cd50bf62355242a286d4e30d5ab0dc_sx_329867_www800-800', '0', NULL, '6122107374405', 0.02, 0.02, 0, 0.02, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (23, 1007, 400, 22, '6949752640139040063', '6949752640139040063', '3629163995110146', 0, 0, '【测试商品勿拍】羊毛袜子女冬天保暖中筒圣诞复古麋鹿堆堆袜', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_d4cd50bf62355242a286d4e30d5ab0dc_sx_329867_www800-800', '0', NULL, '6122107374405', 0.02, 0.02, 0, 0.02, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (24, 1007, 400, 23, '6949743576382511058', '6949743576382511058', '3629163995110146', 0, 0, '【测试商品勿拍】羊毛袜子女冬天保暖中筒圣诞复古麋鹿堆堆袜', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_d4cd50bf62355242a286d4e30d5ab0dc_sx_329867_www800-800', '0', NULL, '6122107374405', 0.01, 0.01, 0, 0.01, 1, NULL, 0, 1, 3, 0, 0, 0, '2026-01-10 16:15:23', NULL, '2026-01-10 16:52:10', '手动修改ERP SKU ID', NULL, NULL);
INSERT INTO `o_order_item` VALUES (25, 1011, 300, 24, '260101-602941713932531', '260101-602941713932531-1742164849117', '1742164849117', 16, 47, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 'LEDDX001', '24W白光-215mm', 'LEDDX00103', 39.32, 39.32, 0, 39.32, 1, NULL, 0, 1, 1, 0, 0, 0, '2026-01-12 11:12:56', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (26, 1011, 300, 25, '260101-343073113703028', '260101-343073113703028-1742164849115', '1742164849115', 16, 45, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/a3e7e689-5c30-495c-b5e0-90e38bd352b5.jpeg.a.jpeg', 'LEDDX001', '12W白光-135mm', 'LEDDX00101', 29.35, 29.35, 0, 29.35, 1, NULL, 0, 1, 1, 0, 0, 0, '2026-01-12 11:12:56', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (27, 1011, 300, 26, '260103-124791079222466', '260103-124791079222466-1742164849116', '1742164849116', 16, 46, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 'LEDDX001', '18W白光-175mm', 'LEDDX00102', 33.93, 33.93, 0, 33.93, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-12 12:41:07', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (28, 1011, 300, 27, '260103-554287808822466', '260103-554287808822466-1742164849115', '1742164849115', 16, 45, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/a3e7e689-5c30-495c-b5e0-90e38bd352b5.jpeg.a.jpeg', 'LEDDX001', '12W白光-135mm', 'LEDDX00101', 29.35, 29.35, 0, 29.35, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-12 12:41:07', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (29, 1011, 300, 28, '260106-260403381772674', '260106-260403381772674-1742164849116', '1742164849116', 16, 46, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 'LEDDX001', '18W白光-175mm', 'LEDDX00102', 33.93, 33.93, 0, 33.93, 1, NULL, 0, 1, 2, 0, 0, 0, '2026-01-12 12:55:42', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (30, 1011, 300, 29, '260106-505146273432079', '260106-505146273432079-1742164849117', '1742164849117', 16, 47, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 'LEDDX001', '24W白光-215mm', 'LEDDX00103', 39.32, 78.64, 0, 78.64, 2, NULL, 0, 2, 2, 0, 0, 0, '2026-01-12 12:55:42', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_order_item` VALUES (31, 1011, 300, 30, '260113-074742505040578', '260113-074742505040578-1742164849116', '1742164849116', 16, 46, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 'LEDDX001', '18W白光-175mm', 'LEDDX00102', 33.93, 33.93, 0, 33.93, 1, NULL, 0, 1, 1, 0, 0, 0, '2026-01-13 10:53:58', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for o_refund
-- ----------------------------
DROP TABLE IF EXISTS `o_refund`;
CREATE TABLE `o_refund`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `refund_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '退货单号',
  `refund_type` int NULL DEFAULT NULL COMMENT '类型(1-售前退款 10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)',
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NULL DEFAULT NULL COMMENT '店铺类型',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '源订单号',
  `order_item_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子订单号或id',
  `order_amount` float NULL DEFAULT NULL COMMENT '订单金额',
  `refund_amount` float NOT NULL COMMENT '退款金额',
  `refund_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退款原因',
  `sku_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源skuId',
  `sku_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `sku_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品sku',
  `product_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台商品id',
  `product_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `product_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `after_num` int NOT NULL COMMENT '售后数量',
  `buy_num` int NOT NULL COMMENT '购买数量',
  `order_id` bigint NOT NULL COMMENT '订单库id',
  `order_item_id` bigint NOT NULL COMMENT '订单库itemId',
  `goods_id` bigint NOT NULL COMMENT '商品id(o_goods外键)',
  `goods_sku_id` bigint NOT NULL COMMENT '商品skuid(o_goods_sku外键)',
  `shipping_status` int NOT NULL DEFAULT 0 COMMENT '订单发货状态 0:未发货， 1:已发货（包含：已发货，已揽收）',
  `user_shipping_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '0-未勾选 1-消费者选择的收货状态为未收到货 2-消费者选择的收货状态为已收到货3消费者已退货',
  `has_good_return` int NULL DEFAULT NULL COMMENT '买家是否需要退货。可选值:1(是),0(否)',
  `return_logistics_company` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货物流公司',
  `return_logistics_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '退货物流单号',
  `receive_time` datetime NULL DEFAULT NULL COMMENT '收货时间',
  `remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `platform_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台状态值',
  `platform_status_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台状态',
  `refund_created` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后创建时间',
  `refund_updated` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '售后更新时间',
  `order_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单时间',
  `status` int NOT NULL DEFAULT 0 COMMENT '状态（0待处理 1处理中 2已处理）',
  `create_time` datetime NOT NULL COMMENT '订单创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `has_processing` int NOT NULL DEFAULT 0 COMMENT '是否处理0未处理1已处理',
  `after_sale_id` bigint NULL DEFAULT NULL COMMENT '处理id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OMS售后处理表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_refund
-- ----------------------------
INSERT INTO `o_refund` VALUES (1, '17894479236915', 11, 1011, 300, '260101-602941713932531', '260101-602941713932531-1742164849117', 29.32, 29.32, '其他原因', '1742164849117', 'LEDDX00103', '24W白光-215mm', NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 1, 0, 24, 25, 16, 47, 0, '1', 0, '', '', NULL, '', '10', '退款成功', '2026-01-01 14:53:14', '2026-01-01 06:53:19', '2026-01-01 06:48:36', 0, '2026-01-12 11:35:04', NULL, '2026-01-13 10:44:35', NULL, 0, NULL);
INSERT INTO `o_refund` VALUES (2, '17958668300087', 11, 1011, 300, '260101-343073113703028', '260101-343073113703028-1742164849115', 29.35, 29.35, '其他原因', '1742164849115', 'LEDDX00101', '12W白光-135mm', NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/a3e7e689-5c30-495c-b5e0-90e38bd352b5.jpeg.a.jpeg', 1, 0, 25, 26, 16, 45, 0, '1', 0, '', '', NULL, '', '10', '退款成功', '2026-01-01 20:52:10', '2026-01-01 12:52:17', '2026-01-01 12:47:51', 0, '2026-01-12 11:35:05', NULL, '2026-01-13 10:44:33', NULL, 0, NULL);
INSERT INTO `o_refund` VALUES (3, '18094162708216', 10, 1011, 300, '260103-064550356563156', '260103-064550356563156-1742164849116', 33.93, 33.93, '其他原因', '1742164849116', 'LEDDX00102', '18W白光-175mm', NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 1, 0, 2, 2, 16, 46, 1, '0', 1, '德邦快递', 'DPK202672107532', NULL, '', '10', '退款成功', '2026-01-06 14:01:10', '2026-01-09 10:20:38', '2026-01-03 05:45:28', 0, '2026-01-12 12:37:02', NULL, '2026-01-13 10:44:18', NULL, 0, NULL);
INSERT INTO `o_refund` VALUES (4, '18104483624816', 10, 1011, 300, '260106-505146273432079', '260106-505146273432079-1742164849117', 74.71, 74.71, '不想要了', '1742164849117', 'LEDDX00103', '24W白光-215mm', NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 2, 0, 29, 30, 16, 47, 1, '0', 0, '德邦快递', 'DPK202675485511', NULL, '', '10', '退款成功', '2026-01-10 22:41:27', '2026-01-12 05:12:11', '2026-01-06 14:40:01', 0, '2026-01-12 12:57:07', NULL, '2026-01-13 10:44:27', 'admin操作售后处理', 1, 2010668039339151361);
INSERT INTO `o_refund` VALUES (5, '18148057136940', 11, 1011, 300, '260111-141274662501554', '260111-141274662501554-1740677623153', 15.73, 15.73, '其他原因', '1740677623153', 'LEDDP00103', '', '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'https://img.pddpic.com/mms-material-img/2025-05-28/90a9f73e-acc9-4350-bf91-aa3c0c6a19a2.jpeg.a.jpeg', 1, 1, 0, 0, 0, 0, 0, '1', 0, '', '', NULL, '', '10', '退款成功', '2026-01-11 07:36:15', '2026-01-11 12:33:32', '2026-01-10 23:21:39', 0, '2026-01-12 12:57:08', NULL, '2026-01-13 19:50:40', NULL, 0, NULL);
INSERT INTO `o_refund` VALUES (6, '18078171104251', 11, 1011, 300, '260103-143340377723488', '260103-143340377723488-1742164849117', 24.78, 24.78, '不想要了', '1742164849117', 'LEDDX00103', '24W白光-215mm', NULL, '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/70732144-21a8-423c-90df-553c3ea4fe36.jpeg.a.jpeg', 1, 0, 1, 1, 16, 47, 0, '1', 0, '', '', NULL, '', '10', '退款成功', '2026-01-03 13:17:53', '2026-01-03 05:18:00', '2026-01-03 05:08:47', 0, '2026-01-12 16:03:29', NULL, '2026-01-13 10:42:54', NULL, 0, NULL);
INSERT INTO `o_refund` VALUES (7, '18267421812292', 11, 1011, 300, '260113-074742505040578', '260113-074742505040578-1742164849116', 33.93, 33.93, '不想要了', '1742164849116', 'LEDDX00102', '18W白光-175mm', '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'https://img.pddpic.com/mms-material-img/2025-05-29/dfb81deb-a7c1-4028-b6b1-b3f02fb63c72.jpeg.a.jpeg', 1, 1, 30, 31, 16, 46, 0, '1', 0, '', '', NULL, '', '10', '退款成功', '2026-01-13 08:19:22', '2026-01-13 00:19:29', '2026-01-13 00:17:19', 0, '2026-01-13 10:33:34', NULL, '2026-01-13 19:50:33', NULL, 0, NULL);

-- ----------------------------
-- Table structure for o_ship_stock_up
-- ----------------------------
DROP TABLE IF EXISTS `o_ship_stock_up`;
CREATE TABLE `o_ship_stock_up`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `sale_order_id` bigint NULL DEFAULT NULL COMMENT 'erp订单id',
  `sale_order_item_id` bigint NULL DEFAULT NULL COMMENT 'erp订单itemid',
  `order_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `original_sku_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '原始订单skuid',
  `goods_id` bigint NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `spec_id` bigint NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_spec` varchar(2550) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `goods_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `spec_num` varchar(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `quantity` int NOT NULL COMMENT '商品数量',
  `status` int NOT NULL COMMENT '状态0待备货1备货中2备货完成3已发货',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1827537194227638275 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货-备货表（打单加入备货清单）' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_ship_stock_up
-- ----------------------------
INSERT INTO `o_ship_stock_up` VALUES (1817540108503371777, 1, 1817230905045843970, 1817230905091981313, '1722092947647399', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-07-28 20:38:25', '消息通知备货', '2024-07-30 23:06:18', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823982945285689345, 1, 1823969793328271361, 1823969793403768833, '172370314299481', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-08-15 15:19:57', '消息通知备货', '2024-08-15 15:36:51', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823989949987192833, 2, 1823988373058998273, 1823988373058998274, '1723707501431263', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-08-15 15:47:47', '消息通知备货', '2024-08-18 16:14:59', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823991276628770817, 2, 1823991184286973954, 1823991184349888514, '1723708260966435', '1', 0, 0, 'AA', NULL, 'BB', NULL, 'AABB001', 1, 3, '2024-08-15 15:53:03', '消息通知备货', '2024-08-18 16:13:54', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1823991276628770818, 2, 1823991184286973954, 1823991184349888515, '1723708260966435', '2', 0, 0, 'AAABBB', 'https://cbu01.alicdn.com/img/ibank/O1CN012YyP5f1hbcSsvkd3k_!!2218127114296-0-cib.jpg', '红罐加多宝', NULL, 'AABB002', 1, 3, '2024-08-15 15:53:03', '消息通知备货', '2024-08-18 16:13:54', '消息通知发货完成');
INSERT INTO `o_ship_stock_up` VALUES (1825085906361516034, 1, 1825085325148422145, 1825085325215531009, '1723968921461168', '2', 0, 0, 'AAABBB', 'https://cbu01.alicdn.com/img/ibank/O1CN012YyP5f1hbcSsvkd3k_!!2218127114296-0-cib.jpg', '红罐加多宝', NULL, 'AABB002', 1, 0, '2024-08-18 16:22:43', '消息通知备货', NULL, NULL);
INSERT INTO `o_ship_stock_up` VALUES (1827537194227638274, 1, 1827306479443587074, 1827306487383404546, '1724485556330230', '2', 0, 0, 'AAABBB', 'https://cbu01.alicdn.com/img/ibank/O1CN012YyP5f1hbcSsvkd3k_!!2218127114296-0-cib.jpg', '红罐加多宝', NULL, 'AABB002', 1, 3, '2024-08-25 10:43:16', '消息通知备货', '2024-08-25 10:46:09', '消息通知发货完成');

-- ----------------------------
-- Table structure for o_shipment
-- ----------------------------
DROP TABLE IF EXISTS `o_shipment`;
CREATE TABLE `o_shipment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `order_id` bigint NULL DEFAULT NULL COMMENT 'o_order表id',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `order_time` datetime NULL DEFAULT NULL COMMENT '订单时间',
  `shipper` int NOT NULL DEFAULT 0 COMMENT '发货方 0 仓库发货 1 供应商发货',
  `supplier_id` bigint NOT NULL DEFAULT 0 COMMENT '供应商ID',
  `supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `ship_type` int NULL DEFAULT NULL COMMENT '发货类型（1订单发货2商品补发3商品换货）',
  `ship_company` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流公司',
  `ship_company_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物流公司code',
  `ship_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '物流单号',
  `ship_fee` decimal(6, 2) NOT NULL DEFAULT 0.00 COMMENT '物流费用',
  `ship_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `ship_operator` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发货操作人',
  `ship_status` int NULL DEFAULT NULL COMMENT '物流状态（0 待发货1已发货2已完成）',
  `package_weight` float NULL DEFAULT NULL COMMENT '包裹重量',
  `package_length` float NULL DEFAULT NULL COMMENT '包裹长度',
  `package_width` float NULL DEFAULT NULL COMMENT '包裹宽度',
  `package_height` float NULL DEFAULT NULL COMMENT '包裹高度',
  `packsge_operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打包操作人',
  `packsge_time` datetime NULL DEFAULT NULL COMMENT '打包时间',
  `packages` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '包裹内容JSON',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `receiver_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人手机号',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收件人地址',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `town` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id_index`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shipment
-- ----------------------------
INSERT INTO `o_shipment` VALUES (1, 1007, 400, 74, '6921377343921159820', '2025-10-06 10:16:50', 0, 0, NULL, 1, '极兔速递', 'JTSD', 'AAAAA', 0.00, '2025-10-06 20:29:47', NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, '2025-10-06 20:29:50', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (2, 1007, 2, 0, 'aaa', NULL, 0, 0, NULL, 2, '极兔速递', 'JTSD', 'aa', 0.00, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-07 17:23:55', '手动添加发货记录', NULL, NULL, 'a', 'a', 'a', NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (3, 1007, 2, 0, 'aaa', NULL, 0, 0, NULL, 2, '极兔速递', 'JTSD', 'aa', 0.00, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-07 17:24:27', '手动添加发货记录', NULL, NULL, 'a', 'a', 'a', NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (4, 1007, 1, 0, 'aa', NULL, 0, 0, NULL, 1, '极兔速递', 'JTSD', 'aa', 0.00, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-07 17:25:06', '手动添加发货记录', NULL, NULL, 'd', 'd', 'a', NULL, NULL, NULL);
INSERT INTO `o_shipment` VALUES (5, 1011, 300, 75, '251002-171237742200640', '2025-10-02 03:56:59', 0, 0, NULL, 1, 'AA', 'AA', 'AAAAA', 0.00, '2025-10-09 12:53:46', NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, NULL, '2025-10-09 12:53:46', 'admin', NULL, NULL, '彭**', '***********', '江西省***********************', '江西省', '南昌市', '西湖区');

-- ----------------------------
-- Table structure for o_shipment_item
-- ----------------------------
DROP TABLE IF EXISTS `o_shipment_item`;
CREATE TABLE `o_shipment_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id，自增',
  `shipment_id` bigint NOT NULL COMMENT '发货id',
  `shipper` int NOT NULL COMMENT '发货方 0 仓库发货 1 供应商发货',
  `supplier_id` bigint NOT NULL DEFAULT 0 COMMENT '供应商ID',
  `supplier` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '供应商',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `order_id` bigint NOT NULL COMMENT '订单 id',
  `order_num` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_time` datetime NULL DEFAULT NULL COMMENT '订单时间',
  `order_item_id` bigint NOT NULL COMMENT '订单itemID（o_order_item外键）',
  `erp_goods_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `erp_sku_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品规格id',
  `goods_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `goods_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编码',
  `goods_spec` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格',
  `sku_num` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品规格编码',
  `quantity` int NOT NULL COMMENT '商品数量',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `stock_status` int NOT NULL COMMENT '仓库状态 0 备货中 1 已出库 2 已发走',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `goodId_index`(`erp_goods_id` ASC) USING BTREE,
  INDEX `order_id`(`order_item_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '发货明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shipment_item
-- ----------------------------
INSERT INTO `o_shipment_item` VALUES (1, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 54, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"XL\"}]', '', 1, NULL, 0, '2025-10-06 20:30:05', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (2, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 55, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"L\"}]', '', 1, NULL, 0, '2025-10-06 20:30:12', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (3, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 56, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"M\"}]', '', 1, NULL, 0, '2025-10-06 20:30:12', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (4, 1, 0, 0, NULL, 400, 1007, 74, '6921377343921159820', '2025-10-06 10:16:50', 57, 0, 0, '通用气质针织春夏收腰欧美法式潮流短款外套', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/ALSUvYM_m_6b2c63f75ace689f2e1b03224ce5fd7e_sx_27680_www600-600', '0', '[{\"name\":\"颜色分类\",\"value\":\"乳白色22234\"},{\"name\":\"尺码大小\",\"value\":\"S\"}]', '', 1, NULL, 0, '2025-10-06 20:30:12', 'admin', NULL, NULL);
INSERT INTO `o_shipment_item` VALUES (5, 5, 0, 0, NULL, 300, 1011, 75, '251002-171237742200640', '2025-10-02 03:56:59', 58, 0, 0, NULL, 'https://img.pddpic.com/mms-material-img/2025-06-02/0d875ad2-529b-43be-b699-96748b4c0bb4.jpeg.a.jpeg', 'LEDDP001', 'E27螺口 5瓦白光 1级能效', 'LEDDP00102', 1, NULL, 0, '2025-10-09 12:53:46', 'admin', NULL, NULL);

-- ----------------------------
-- Table structure for o_shop
-- ----------------------------
DROP TABLE IF EXISTS `o_shop`;
CREATE TABLE `o_shop`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '店铺名',
  `type` int NOT NULL COMMENT '对应第三方平台Id',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '店铺url',
  `sort` int NOT NULL DEFAULT 9 COMMENT '排序',
  `status` int NULL DEFAULT 0 COMMENT '状态（1正常2已删除）',
  `remark` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `seller_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第三方平台店铺id',
  `app_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Appkey',
  `app_secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Appsercet',
  `access_token` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第三方平台sessionKey（access_token）',
  `expires_in` bigint NULL DEFAULT NULL COMMENT '到期',
  `access_token_begin` bigint NULL DEFAULT NULL COMMENT 'access_token开始时间',
  `refresh_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '刷新token',
  `refresh_token_timeout` bigint NULL DEFAULT NULL COMMENT '刷新token过期时间',
  `api_request_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求url',
  `api_redirect_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回调url',
  `manage_user_id` bigint NULL DEFAULT NULL COMMENT '负责人id',
  `manage_dept_id` bigint NULL DEFAULT NULL COMMENT '负责人部门id',
  `region_id` bigint NOT NULL DEFAULT 0 COMMENT '国家/地区',
  `api_status` int NOT NULL COMMENT 'api运行状态0不运行1运行',
  `modify_on` bigint NOT NULL COMMENT '更新时间',
  `create_on` bigint NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1014 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop
-- ----------------------------
INSERT INTO `o_shop` VALUES (1007, '抖店测试', 400, NULL, 9, 1, NULL, '4463798', NULL, NULL, 'c3tzx2q5p41h7zl69zjws9900002noae-11', NULL, NULL, '070t45roa51h7zl69zjws9900002noae-12', NULL, NULL, NULL, NULL, NULL, 0, 0, 1759307372, 1759307261);
INSERT INTO `o_shop` VALUES (1011, '爱顾家的小店', 300, NULL, 9, 1, NULL, '0', NULL, NULL, 'd7b50ba1a8aa42c7b0b040ee6f86b5f8e83027c2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 1759371874, 1759371874);
INSERT INTO `o_shop` VALUES (1012, '微信小店测试', 500, NULL, 9, 1, NULL, '0', 'wx82dd65f284dd6ee3', 'a6054ccf2694e8dc51d2616e634cad39', '99_fTlkZRP6GjasIVJEoEmbvMpEFOIO99Pld8JwA4eSzFfIa2-sbgbjbL6iGSzt2ZX7ydg0CKxe6kzLxvs9L1GxoINeyST5efbptdvrqu0LJkCEXzkZ4crveaIK5vMKKMgABAUUW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1759373401, 1759373401);
INSERT INTO `o_shop` VALUES (1013, '测试TMALL', 100, NULL, 9, 1, NULL, '2', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1767360004, 1767360004);

-- ----------------------------
-- Table structure for o_shop_platform
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_platform`;
CREATE TABLE `o_shop_platform`  (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台名',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台编码',
  `app_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `app_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `redirect_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台回调uri',
  `server_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口访问地址',
  `status` int NULL DEFAULT NULL COMMENT '状态（0启用1关闭）',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `region_id` bigint NULL DEFAULT NULL COMMENT '国家/地区',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺平台配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_platform
-- ----------------------------
INSERT INTO `o_shop_platform` VALUES (100, '淘宝天猫', 'TMALL', '', '', 'http://www.qihangerp.cn', 'http://gw.api.taobao.com/router/rest', 0, 3, 1);
INSERT INTO `o_shop_platform` VALUES (200, '京东POP', 'JD-POP', '', NULL, 'http://www.qihangerp.cn', 'https://api.jd.com/routerjson', 0, 4, 1);
INSERT INTO `o_shop_platform` VALUES (300, '拼多多', 'PDD', 'dc953bcf16d24b27abf3e64a59e1ecd1', '89c639b1ceaf8e5260acc73b2bdbb5c529cf23a4', 'https://qihangerp.cn', 'https://gw-api.pinduoduo.com/api/router', 0, 1, 1);
INSERT INTO `o_shop_platform` VALUES (400, '抖店', 'DOUDIAN', '7005157746437834253', '8104c8b8-9085-4a80-9248-629759b4f1a3', 'https://www.qihangerp.cn', 'https://openapi-fxg.jinritemai.com/', 0, 0, 1);
INSERT INTO `o_shop_platform` VALUES (500, '微信小店', 'WEISHOP', '', NULL, 'http://www.qihangerp.cn', 'https://api.weixin.qq.com', 0, 2, 1);
INSERT INTO `o_shop_platform` VALUES (999, '其他平台', 'OFFLINE', NULL, NULL, NULL, NULL, 0, 10, 1);

-- ----------------------------
-- Table structure for o_shop_pull_lasttime
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_pull_lasttime`;
CREATE TABLE `o_shop_pull_lasttime`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NULL DEFAULT NULL COMMENT '店铺id',
  `pull_type` enum('ORDER','REFUND','GOODS') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型（ORDER:订单，REFUND:退款）',
  `lasttime` datetime NULL DEFAULT NULL COMMENT '最后更新时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1577832450 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺更新最后时间记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_pull_lasttime
-- ----------------------------
INSERT INTO `o_shop_pull_lasttime` VALUES (102, 1007, 'ORDER', '2025-10-02 16:16:23', '2025-10-01 17:11:03', '2026-01-01 17:18:44');
INSERT INTO `o_shop_pull_lasttime` VALUES (103, 1010, 'ORDER', '2025-10-02 08:47:13', '2025-10-02 08:43:16', '2025-10-02 08:47:13');
INSERT INTO `o_shop_pull_lasttime` VALUES (104, 1011, 'ORDER', '2025-12-22 21:31:11', '2025-10-02 10:31:11', '2026-01-02 09:06:08');
INSERT INTO `o_shop_pull_lasttime` VALUES (1577832449, 1011, 'GOODS', '2026-01-02 10:19:37', '2026-01-02 09:00:45', '2026-01-02 10:19:39');

-- ----------------------------
-- Table structure for o_shop_pull_logs
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_pull_logs`;
CREATE TABLE `o_shop_pull_logs`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `shop_id` int NULL DEFAULT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '平台id',
  `pull_type` enum('ORDER','REFUND','GOODS') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型（ORDER订单，GOODS商品，REFUND退款）',
  `pull_way` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉取方式（主动拉取、定时任务）',
  `pull_params` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拉取参数',
  `pull_result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '拉取结果',
  `pull_time` datetime NULL DEFAULT NULL COMMENT '拉取时间',
  `duration` bigint NULL DEFAULT NULL COMMENT '耗时（毫秒）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2011043211082424323 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺更新日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_pull_logs
-- ----------------------------
INSERT INTO `o_shop_pull_logs` VALUES (2007051452283584514, 1007, 400, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-02 19:28:50', 9);
INSERT INTO `o_shop_pull_logs` VALUES (2007051615710445570, 1007, 400, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-02 19:29:10', 19818);
INSERT INTO `o_shop_pull_logs` VALUES (2007053815446753282, 1011, 300, 'GOODS', '主动拉取商品sku', '', 'access_token已过期', '2026-01-02 19:38:13', 339);
INSERT INTO `o_shop_pull_logs` VALUES (2007054121874214913, 1011, 300, 'GOODS', '主动拉取商品sku', '', 'access_token已过期', '2026-01-02 19:39:26', 212);
INSERT INTO `o_shop_pull_logs` VALUES (2007054347586490370, 1011, 300, 'GOODS', '主动拉取商品sku', '', '{successTotal:35}', '2026-01-02 19:40:17', 3004);
INSERT INTO `o_shop_pull_logs` VALUES (2007060914402689025, 1007, 400, 'GOODS', '主动拉取商品sku', '', '请求API错误：认证失败, 确保app_key, method, param_json, timestamp, v, sign等参数不为空', '2026-01-02 20:06:26', 246);
INSERT INTO `o_shop_pull_logs` VALUES (2007061626629062658, 1007, 400, 'GOODS', '主动拉取商品sku', '', '系统异常：Cannot invoke \"java.net.http.HttpResponse.statusCode()\" because \"response\" is null', '2026-01-02 20:07:44', 92188);
INSERT INTO `o_shop_pull_logs` VALUES (2007063329415884802, 1007, 400, 'GOODS', '主动拉取商品sku', '', '{successTotal:299}', '2026-01-02 20:15:27', 34667);
INSERT INTO `o_shop_pull_logs` VALUES (2007080897514033153, 1013, 100, 'GOODS', '主动拉取商品sku', '', 'SessionKey非法', '2026-01-02 21:25:32', 18452);
INSERT INTO `o_shop_pull_logs` VALUES (2007080916300320770, 1013, 100, 'GOODS', '主动拉取商品sku', '', 'SessionKey非法', '2026-01-02 21:25:55', 54);
INSERT INTO `o_shop_pull_logs` VALUES (2007081406052421634, 1013, 100, 'GOODS', '主动拉取商品sku', '', 'SessionKey非法', '2026-01-02 21:26:02', 109359);
INSERT INTO `o_shop_pull_logs` VALUES (2007084780449681410, 1013, 100, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-02 21:27:58', 798366);
INSERT INTO `o_shop_pull_logs` VALUES (2007086428349714433, 1013, 100, 'GOODS', '主动拉取商品sku', '', '{successTotal:887}', '2026-01-02 21:45:42', 127474);
INSERT INTO `o_shop_pull_logs` VALUES (2007246559934894081, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-03 08:24:07', 5);
INSERT INTO `o_shop_pull_logs` VALUES (2007247972962381826, 1012, 500, 'GOODS', '主动拉取商品sku', '', 'invalid credential, access_token is invalid or not latest, could get access_token by getStableAccessToken, more details at https://mmbizurl.cn/s/JtxxFh33r rid: 695862e9-14c7ceab-423f4f5c', '2026-01-03 08:29:24', 20600);
INSERT INTO `o_shop_pull_logs` VALUES (2007247993237647361, 1012, 500, 'GOODS', '主动拉取商品sku', '', 'invalid credential, access_token is invalid or not latest, could get access_token by getStableAccessToken, more details at https://mmbizurl.cn/s/JtxxFh33r rid: 695862fd-06f01503-4fa2639f', '2026-01-03 08:29:49', 73);
INSERT INTO `o_shop_pull_logs` VALUES (2007248036346703874, 1012, 500, 'GOODS', '主动拉取商品sku', '', 'invalid credential, access_token is invalid or not latest, could get access_token by getStableAccessToken, more details at https://mmbizurl.cn/s/JtxxFh33r rid: 69586307-50f58f7f-3572dd68', '2026-01-03 08:29:59', 76);
INSERT INTO `o_shop_pull_logs` VALUES (2007254711795396610, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-03 08:55:58', 33005);
INSERT INTO `o_shop_pull_logs` VALUES (2007255303028682753, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:0}', '2026-01-03 08:56:36', 136242);
INSERT INTO `o_shop_pull_logs` VALUES (2007255692893470721, 1012, 500, 'GOODS', '主动拉取商品sku', '', '{successTotal:6}', '2026-01-03 09:00:23', 2095);
INSERT INTO `o_shop_pull_logs` VALUES (2007363351869005826, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-03 00:00:01,endTime:2026-01-03 23:59:59}', '{insert:2,update:0,fail:0}', '2026-01-03 16:08:09', 3437);
INSERT INTO `o_shop_pull_logs` VALUES (2007370800982339585, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-03 00:00:01,endTime:2026-01-03 23:59:59}', '{insert:2,update:0,fail:0}', '2026-01-03 16:37:48', 635);
INSERT INTO `o_shop_pull_logs` VALUES (2007447856453763074, 1007, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-03 00:00:01,endTime:2026-01-03 23:59:59}', '{insert:0,update:0,fail:0}', '2026-01-03 21:32:54', 666229);
INSERT INTO `o_shop_pull_logs` VALUES (2008496609809797121, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-06 00:00:01,endTime:2026-01-06 23:59:59}', 'access_token已过期', '2026-01-06 19:11:22', 676);
INSERT INTO `o_shop_pull_logs` VALUES (2008707706382864386, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-07 00:00:01,endTime:2026-01-07 23:59:59}', 'access_token已过期', '2026-01-07 09:10:11', 642);
INSERT INTO `o_shop_pull_logs` VALUES (2008714936729620482, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-07 00:00:01,endTime:2026-01-07 23:59:59}', '{insert:1,update:0,fail:0}', '2026-01-07 09:38:55', 527);
INSERT INTO `o_shop_pull_logs` VALUES (2009901871078502401, 1007, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-10 00:00:01,endTime:2026-01-10 23:59:59}', '{insert:20,update:0,fail:0}', '2026-01-10 16:15:11', 12093);
INSERT INTO `o_shop_pull_logs` VALUES (2009910634514636802, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-10 00:00:01,endTime:2026-01-10 23:59:59}', 'access_token已过期', '2026-01-10 16:50:12', 442);
INSERT INTO `o_shop_pull_logs` VALUES (2009911128167440386, 1007, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-10 00:00:01,endTime:2026-01-10 23:59:59}', '{insert:20,update:0,fail:0}', '2026-01-10 16:52:07', 2776);
INSERT INTO `o_shop_pull_logs` VALUES (2009913752577007617, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-10T16:32:35.464937100,endTime:2026-01-10T17:02:35.464937100}', 'access_token已过期', '2026-01-10 17:02:35', 205);
INSERT INTO `o_shop_pull_logs` VALUES (2010260827449835522, 1007, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T15:31:44.398163600,endTime:2026-01-11T16:01:44.398163600}', 'client下线或者clientId不正确', '2026-01-11 16:01:44', 381);
INSERT INTO `o_shop_pull_logs` VALUES (2010260991505842178, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T15:32:23.833770,endTime:2026-01-11T16:02:23.833770}', 'access_token已过期', '2026-01-11 16:02:24', 53);
INSERT INTO `o_shop_pull_logs` VALUES (2010261581912850433, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T15:34:44.393857900,endTime:2026-01-11T16:04:44.393857900}', 'access_token已过期', '2026-01-11 16:04:44', 251);
INSERT INTO `o_shop_pull_logs` VALUES (2010265533236625410, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T15:50:26.490873,endTime:2026-01-11T16:20:26.490873}', 'access_token已过期', '2026-01-11 16:20:26', 223);
INSERT INTO `o_shop_pull_logs` VALUES (2010266195034882049, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T15:53:04.274583900,endTime:2026-01-11T16:23:04.274583900}', 'access_token已过期', '2026-01-11 16:23:04', 226);
INSERT INTO `o_shop_pull_logs` VALUES (2010271269001871362, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T16:13:13.998540900,endTime:2026-01-11T16:43:13.998540900}', 'access_token已过期', '2026-01-11 16:43:14', 227);
INSERT INTO `o_shop_pull_logs` VALUES (2010271580433137666, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T16:14:28.283560,endTime:2026-01-11T16:44:28.283560}', 'access_token已过期', '2026-01-11 16:44:28', 194);
INSERT INTO `o_shop_pull_logs` VALUES (2010274563875016705, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T16:26:19.437398400,endTime:2026-01-11T16:56:19.437398400}', 'access_token已过期', '2026-01-11 16:56:19', 353);
INSERT INTO `o_shop_pull_logs` VALUES (2010278286693113858, 1011, 400, 'REFUND', '主动拉取退款', '{startTime:2026-01-11T16:41:06.042973100,endTime:2026-01-11T17:11:06.042973100}', 'access_token已过期', '2026-01-11 17:11:06', 1346);
INSERT INTO `o_shop_pull_logs` VALUES (2010283597885743106, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-11 00:00:01,endTime:2026-01-11 23:59:59}', 'access_token已过期', '2026-01-11 17:32:11', 3047);
INSERT INTO `o_shop_pull_logs` VALUES (2010284550957531138, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-11 00:00:01,endTime:2026-01-11 00:30:01}', 'access_token已过期', '2026-01-11 17:35:58', 3052);
INSERT INTO `o_shop_pull_logs` VALUES (2010284791379222530, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-11 00:00:01,endTime:2026-01-11 00:30:01}', 'access_token已过期', '2026-01-11 17:36:55', 2835);
INSERT INTO `o_shop_pull_logs` VALUES (2010284958715105282, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-11 00:00:01,endTime:2026-01-11 00:30:01}', 'access_token已过期', '2026-01-11 17:37:37', 607);
INSERT INTO `o_shop_pull_logs` VALUES (2010285247979474945, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-11 00:00:01,endTime:2026-01-11 00:30:01}', 'access_token已过期', '2026-01-11 17:38:47', 185);
INSERT INTO `o_shop_pull_logs` VALUES (2010294751483899906, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 23:30:01,endTime:2026-01-02 00:00:01}', '{insert:2,update:0,fail:0}', '2026-01-11 18:16:25', 8075);
INSERT INTO `o_shop_pull_logs` VALUES (2010295071924535298, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 23:30:01,endTime:2026-01-02 00:00:01}', '{insert:0,update:2,fail:0}', '2026-01-11 18:17:44', 4980);
INSERT INTO `o_shop_pull_logs` VALUES (2010549065976889345, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 00:00:01,endTime:2026-01-01 00:30:01}', 'access_token已过期', '2026-01-12 11:07:06', 579);
INSERT INTO `o_shop_pull_logs` VALUES (2010549402704007170, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 00:00:01,endTime:2026-01-01 00:30:01}', 'access_token已过期', '2026-01-12 11:08:24', 2888);
INSERT INTO `o_shop_pull_logs` VALUES (2010549952480694273, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 00:00:01,endTime:2026-01-01 00:30:01}', '{insert:0,update:0,fail:0}', '2026-01-12 11:10:37', 582);
INSERT INTO `o_shop_pull_logs` VALUES (2010550533484089345, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-01 00:00:01,endTime:2026-01-01 23:59:59}', '{insert:2,update:0,fail:0}', '2026-01-12 11:12:55', 737);
INSERT INTO `o_shop_pull_logs` VALUES (2010556108850737154, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 23:30:01,endTime:2026-01-02 00:00:01}', '{insert:2,update:0,fail:0}', '2026-01-12 11:35:00', 4983);
INSERT INTO `o_shop_pull_logs` VALUES (2010556830820478978, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 23:30:01,endTime:2026-01-02 00:00:01}', '{insert:2,update:0,fail:0}', '2026-01-12 11:37:53', 4611);
INSERT INTO `o_shop_pull_logs` VALUES (2010571284937408513, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-10 23:30:01,endTime:2026-01-11 00:00:01}', '{insert:0,update:0,fail:0}', '2026-01-12 12:35:19', 4462);
INSERT INTO `o_shop_pull_logs` VALUES (2010571702497148929, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-09 23:30:01,endTime:2026-01-10 00:00:01}', '{insert:1,update:0,fail:0}', '2026-01-12 12:36:59', 4060);
INSERT INTO `o_shop_pull_logs` VALUES (2010572726247092226, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-03 00:00:01,endTime:2026-01-03 23:59:59}', '{insert:4,update:0,fail:0}', '2026-01-12 12:41:06', 735);
INSERT INTO `o_shop_pull_logs` VALUES (2010572794240954370, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-09 23:30:01,endTime:2026-01-10 00:00:01}', '{insert:1,update:0,fail:0}', '2026-01-12 12:41:19', 4243);
INSERT INTO `o_shop_pull_logs` VALUES (2010573046608031746, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-09 23:30:01,endTime:2026-01-10 00:00:01}', '{insert:1,update:0,fail:0}', '2026-01-12 12:42:20', 3979);
INSERT INTO `o_shop_pull_logs` VALUES (2010574125080903681, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-09 23:30:01,endTime:2026-01-10 00:00:01}', '{insert:1,update:0,fail:0}', '2026-01-12 12:46:03', 37237);
INSERT INTO `o_shop_pull_logs` VALUES (2010574605563613186, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-09 23:30:01,endTime:2026-01-10 00:00:01}', '{insert:1,update:0,fail:0}', '2026-01-12 12:48:31', 4522);
INSERT INTO `o_shop_pull_logs` VALUES (2010574666464907265, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-01 23:30:01,endTime:2026-01-02 00:00:01}', '{insert:2,update:0,fail:0}', '2026-01-12 12:48:46', 4123);
INSERT INTO `o_shop_pull_logs` VALUES (2010576395528982530, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-06 00:00:01,endTime:2026-01-06 23:59:59}', '{insert:2,update:0,fail:0}', '2026-01-12 12:55:42', 437);
INSERT INTO `o_shop_pull_logs` VALUES (2010576713297842178, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-10 23:30:01,endTime:2026-01-11 00:00:01}', '{insert:0,update:0,fail:0}', '2026-01-12 12:56:53', 4567);
INSERT INTO `o_shop_pull_logs` VALUES (2010576757304479745, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-11 23:30:01,endTime:2026-01-12 00:00:01}', '{insert:2,update:0,fail:0}', '2026-01-12 12:57:04', 4056);
INSERT INTO `o_shop_pull_logs` VALUES (2010612537896984578, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-12 15:18:26', 53241);
INSERT INTO `o_shop_pull_logs` VALUES (2010613525395529730, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-12 15:19:23', 231453);
INSERT INTO `o_shop_pull_logs` VALUES (2010616549547438082, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-12 15:34:44', 31710);
INSERT INTO `o_shop_pull_logs` VALUES (2010618045009723393, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-12 15:40:58', 13708);
INSERT INTO `o_shop_pull_logs` VALUES (2010618334911627266, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-12 15:42:13', 8095);
INSERT INTO `o_shop_pull_logs` VALUES (2010618799195934721, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-12 15:44:11', 537);
INSERT INTO `o_shop_pull_logs` VALUES (2010618880892588034, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-12 15:44:31', 186);
INSERT INTO `o_shop_pull_logs` VALUES (2010621440244314113, 1011, 300, 'REFUND', '更新退款', '18148057136940', 'SUCCESS', '2026-01-12 15:54:41', 513);
INSERT INTO `o_shop_pull_logs` VALUES (2010623618224746497, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-02 23:30:01,endTime:2026-01-03 00:00:01}', '{insert:0,update:0,fail:0}', '2026-01-12 16:03:16', 4357);
INSERT INTO `o_shop_pull_logs` VALUES (2010623661145059329, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-03 23:30:01,endTime:2026-01-04 00:00:01}', '{insert:1,update:0,fail:0}', '2026-01-12 16:03:27', 3952);
INSERT INTO `o_shop_pull_logs` VALUES (2010624734295461889, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-04 23:30:01,endTime:2026-01-05 00:00:01}', '{insert:0,update:0,fail:0}', '2026-01-12 16:07:42', 5059);
INSERT INTO `o_shop_pull_logs` VALUES (2010624778486648833, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-05 23:30:01,endTime:2026-01-06 00:00:01}', '{insert:0,update:0,fail:0}', '2026-01-12 16:07:53', 4171);
INSERT INTO `o_shop_pull_logs` VALUES (2010624829141258242, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-06 23:30:01,endTime:2026-01-07 00:00:01}', '{insert:0,update:0,fail:0}', '2026-01-12 16:08:06', 4000);
INSERT INTO `o_shop_pull_logs` VALUES (2010624872233537538, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-07 23:30:01,endTime:2026-01-08 00:00:01}', '{insert:0,update:0,fail:0}', '2026-01-12 16:08:16', 4047);
INSERT INTO `o_shop_pull_logs` VALUES (2010902199752433665, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-13 00:00:01,endTime:2026-01-13 00:30:01}', 'access_token已过期', '2026-01-13 10:30:05', 15008);
INSERT INTO `o_shop_pull_logs` VALUES (2010903028253302786, 1011, 300, 'REFUND', '主动拉取退款', '{startTime:2026-01-13 23:30:01,endTime:2026-01-14 00:00:01}', '{insert:1,update:0,fail:0}', '2026-01-13 10:31:59', 98462);
INSERT INTO `o_shop_pull_logs` VALUES (2010903159501463553, 1011, 300, 'REFUND', '更新退款', '18267421812292', 'SUCCESS', '2026-01-13 10:33:57', 11236);
INSERT INTO `o_shop_pull_logs` VALUES (2010903477412929537, 1011, 300, 'REFUND', '更新退款', '18094162708216', 'SUCCESS', '2026-01-13 10:34:32', 52946);
INSERT INTO `o_shop_pull_logs` VALUES (2010905363838910466, 1011, 300, 'REFUND', '更新退款', '18078171104251', 'SUCCESS', '2026-01-13 10:42:51', 3574);
INSERT INTO `o_shop_pull_logs` VALUES (2010905699152543745, 1011, 300, 'REFUND', '更新退款', '18267421812292', 'SUCCESS', '2026-01-13 10:44:14', 401);
INSERT INTO `o_shop_pull_logs` VALUES (2010905717511012353, 1011, 300, 'REFUND', '更新退款', '18094162708216', 'SUCCESS', '2026-01-13 10:44:18', 190);
INSERT INTO `o_shop_pull_logs` VALUES (2010905729053736961, 1011, 300, 'REFUND', '更新退款', '17958668300087', 'SUCCESS', '2026-01-13 10:44:21', 176);
INSERT INTO `o_shop_pull_logs` VALUES (2010905754399916033, 1011, 300, 'REFUND', '更新退款', '18104483624816', 'SUCCESS', '2026-01-13 10:44:27', 177);
INSERT INTO `o_shop_pull_logs` VALUES (2010905779217612801, 1011, 300, 'REFUND', '更新退款', '17958668300087', 'SUCCESS', '2026-01-13 10:44:33', 196);
INSERT INTO `o_shop_pull_logs` VALUES (2010905785949470722, 1011, 300, 'REFUND', '更新退款', '17894479236915', 'SUCCESS', '2026-01-13 10:44:35', 161);
INSERT INTO `o_shop_pull_logs` VALUES (2010908149578186754, 1011, 300, 'ORDER', '主动拉取订单', '{startTime:2026-01-13 00:00:01,endTime:2026-01-13 23:59:59}', '{insert:1,update:0,fail:0}', '2026-01-13 10:53:58', 390);
INSERT INTO `o_shop_pull_logs` VALUES (2011043185107099650, 1011, 300, 'REFUND', '更新退款', '18267421812292', 'SUCCESS', '2026-01-13 19:50:33', 598);
INSERT INTO `o_shop_pull_logs` VALUES (2011043197203472386, 1011, 300, 'REFUND', '更新退款', '18148057136940', 'SUCCESS', '2026-01-13 19:50:36', 190);
INSERT INTO `o_shop_pull_logs` VALUES (2011043211082424322, 1011, 300, 'REFUND', '更新退款', '18148057136940', 'SUCCESS', '2026-01-13 19:50:39', 169);

-- ----------------------------
-- Table structure for o_shop_region
-- ----------------------------
DROP TABLE IF EXISTS `o_shop_region`;
CREATE TABLE `o_shop_region`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区名称',
  `exchange_rate` float NULL DEFAULT NULL COMMENT '汇率',
  `num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区编码',
  `status` int NULL DEFAULT NULL COMMENT '状态0正常1禁用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺地区表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of o_shop_region
-- ----------------------------
INSERT INTO `o_shop_region` VALUES (1, '中国', 1, '86', 0, '2025-02-10 10:42:54', 'system', '2025-02-10 10:42:57', NULL);

-- ----------------------------
-- Table structure for oms_shop_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `oms_shop_goods_sku`;
CREATE TABLE `oms_shop_goods_sku`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shop_id` bigint NOT NULL COMMENT '店铺id',
  `shop_type` int NOT NULL COMMENT '店铺类型',
  `product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台商品id',
  `product_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名',
  `outer_product_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家商品编码',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku名',
  `sku_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台skuId',
  `outer_sku_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商家自定义skuID。如果添加时没录入，回包可能不包含该字段',
  `sku_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku编码',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku小图',
  `price` int NULL DEFAULT NULL COMMENT '售卖价格，以分为单位',
  `stock_num` int NULL DEFAULT NULL COMMENT 'sku库存',
  `status` int NULL DEFAULT NULL COMMENT 'sku状态平台',
  `sku_attrs` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'sku_attrs',
  `add_time` bigint NULL DEFAULT NULL COMMENT '添加时间平台',
  `modify_time` bigint NULL DEFAULT NULL COMMENT '修改时间平台',
  `erp_goods_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品id',
  `erp_goods_sku_id` bigint NOT NULL DEFAULT 0 COMMENT 'erp系统商品skuid',
  `erp_status` int NOT NULL DEFAULT 0 COMMENT 'erp状态0未绑定1已绑定',
  `create_on` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_on` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1230 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '其他渠道店铺商品SKU' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oms_shop_goods_sku
-- ----------------------------
INSERT INTO `oms_shop_goods_sku` VALUES (3, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 12瓦白光 1级能效', '1740677623154', 'LEDDP00104', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 1, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (4, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 5瓦白光 1级能效', '1742373848730', 'LEDDP00102', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 0, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (5, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 18瓦白光 1级能效', '1740677623155', 'LEDDP00105', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 2, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (6, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 3瓦白光 1级能效', '1742373848729', 'LEDDP00101', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 2, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (7, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 24瓦白光 1级能效', '1742374330747', 'LEDDP00106', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 0, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (8, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 7瓦白光 1级能效', '1740677623153', 'LEDDP00103', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 1, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (9, 1011, 300, '753794079556', '雷士照明超亮LED节能灯E27大功率强光均匀三色可选一级能效护眼', 'LEDDP001', 'E27螺口 30瓦白光 1级能效', '1742374330748', 'LEDDP00107', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-28/048a06e3b11fe5e8ce5ab00e1828d77f.jpeg', 0, 2, 1, NULL, 1748374876, 1748374876, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (10, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '36W三色变光-300mm', '1742164849118', 'LEDDX00104', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 27, 1, NULL, 1748497225, 1748497225, 16, 48, 1, '2026-01-02 19:40:18', '2026-01-06 19:15:40');
INSERT INTO `oms_shop_goods_sku` VALUES (11, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '48W三色变光-330mm', '1742164849119', 'LEDDX00105', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 0, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (12, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '18W白光-175mm', '1742164849116', 'LEDDX00102', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 38, 1, NULL, 1748497225, 1748497225, 16, 46, 1, '2026-01-02 19:40:18', '2026-01-06 19:15:31');
INSERT INTO `oms_shop_goods_sku` VALUES (13, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '24W白光-215mm', '1742164849117', 'LEDDX00103', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 36, 1, NULL, 1748497225, 1748497225, 16, 47, 1, '2026-01-02 19:40:18', '2026-01-05 14:49:23');
INSERT INTO `oms_shop_goods_sku` VALUES (14, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '12W白光-135mm', '1742164849115', 'LEDDX00101', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 52, 1, NULL, 1748497225, 1748497225, 16, 45, 1, '2026-01-02 19:40:18', '2026-01-06 19:15:16');
INSERT INTO `oms_shop_goods_sku` VALUES (15, 1011, 300, '754380133868', '雷士照明LED光源灯芯正品保障客厅卧室餐厅书房吸顶灯LED灯板替换', 'LEDDX001', '60W三色变光-360mm', '1742164849120', 'LEDDX00106', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-29/1a92b78dc9240b794790f686d5186398.jpeg', 0, 0, 1, NULL, 1748497225, 1748497225, 0, 0, 0, '2026-01-02 19:40:18', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (16, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '19寸黑金刚加强筋骨抗砸耐摔旗舰款', '1741926779986', '648700666529452', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 924, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (17, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '22寸黑金刚加强筋骨抗砸耐摔旗舰款', '1741926779987', '648700666529453', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 856, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (18, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '17寸三层折叠工具箱精工款', '1741926779984', '648700666529450', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 938, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (19, 1011, 300, '755310184807', '艾瑞泽工具箱三层折叠多层多功能收纳箱汽车用家用电工五金收纳箱', '448700666150_1748700757', '21寸三层折叠工具箱精工款', '1741926779985', '648700666529451', NULL, 'https://img.pddpic.com/gaudit-image/2025-05-31/8378221ca34955ad167b22c921234f14.jpeg', 0, 933, 1, NULL, 1748700771, 1748700771, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (20, 1011, 300, '755635245980', '雷士照明led灯泡节能E27螺口球泡飞碟灯夜市地摊工矿大功率厂房灯', '', '白色款18W白光 其它', '1742372682345', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-01/c59032e87cd4a8aa1d6615eb3770bddb.jpeg', 0, 100, 1, NULL, 1748770918, 1748770918, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (21, 1011, 300, '755635245980', '雷士照明led灯泡节能E27螺口球泡飞碟灯夜市地摊工矿大功率厂房灯', '', '白色款30W白光 其它', '1742148962888', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-01/c59032e87cd4a8aa1d6615eb3770bddb.jpeg', 0, 100, 1, NULL, 1748770918, 1748770918, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (22, 1011, 300, '755635245980', '雷士照明led灯泡节能E27螺口球泡飞碟灯夜市地摊工矿大功率厂房灯', '', '白色款24W白光 其它', '1742148962887', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-01/c59032e87cd4a8aa1d6615eb3770bddb.jpeg', 0, 100, 1, NULL, 1748770918, 1748770918, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (23, 1011, 300, '756679247197', '雷士照明LED灯泡高亮E27螺口节能灯泡吊灯光源大功率护眼LED球泡', '', '【五只装】E27 18W 正白光', '1743027340565', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/1f92d0247e00defa30fe23ccc15be4fe.jpeg', 0, 100, 1, NULL, 1748965226, 1748965226, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (24, 1011, 300, '756679247197', '雷士照明LED灯泡高亮E27螺口节能灯泡吊灯光源大功率护眼LED球泡', '', '【五只装】E27 30W 正白光', '1743027340569', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/1f92d0247e00defa30fe23ccc15be4fe.jpeg', 0, 100, 1, NULL, 1748965226, 1748965226, 0, 0, 0, '2026-01-02 19:40:19', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (25, 1011, 300, '756679247197', '雷士照明LED灯泡高亮E27螺口节能灯泡吊灯光源大功率护眼LED球泡', '', '【五只装】E27 24W 正白光', '1743027340567', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/1f92d0247e00defa30fe23ccc15be4fe.jpeg', 0, 100, 1, NULL, 1748965226, 1748965226, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (26, 1011, 300, '756684220589', '雷士照明led吸顶灯灯条客厅卧室灯板磁吸灯条长条形灯芯家用节能', '', '48W白光【一拖四】 【磁铁吸附 快捷替换】', '1749116485132', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-03/8079acdcba55f2fb96b57b775b87c002.jpeg', 0, 10, 1, NULL, 1748965956, 1748965956, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (27, 1011, 300, '762810718533', '雷士照明应急灯户外露营充电灯泡地摊照明灯超亮节能家用应急灯', '', '4W USB充电式灯泡', '1748010394260', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-15/d74171a6b86b15ddf9d2adc6632a6185.jpeg', 0, 0, 1, NULL, 1749996455, 1749996455, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (28, 1011, 300, '762810718533', '雷士照明应急灯户外露营充电灯泡地摊照明灯超亮节能家用应急灯', '', '7W USB充电式灯泡', '1748010394261', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-15/d74171a6b86b15ddf9d2adc6632a6185.jpeg', 0, 100, 1, NULL, 1749996455, 1749996455, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (29, 1011, 300, '770936903345', '雷士照明LED集成吊顶灯无边框防水厨房卫生间厕所全面发光平板灯', '', '30X30【24W悬浮曲面照明】', '1754155826431', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/3a3e4097cfebbbc95462edc234c8e488.jpeg', 0, 100, 1, NULL, 1751280371, 1751280371, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (30, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*600 24W珍珠白集成款', '1754157954617', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (31, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*300 18W雾银集成款', '1754157954614', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (32, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*600 24W雾银集成款', '1754157954616', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (33, 1011, 300, '770940543534', '雷士照明led集成吊顶灯平板灯厨房浴室300*300厕所灯卫生间厨房灯', '', '300*300 18W珍珠白集成款', '1754157954615', '', NULL, 'https://img.pddpic.com/gaudit-image/2025-06-30/b6e35e30732ce30a849d2ad0d6c061e7.jpeg', 0, 100, 1, NULL, 1751280678, 1751280678, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (34, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '三色模组48W 直径30CM', '1756355886272', 'LEDDX00105', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 0, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (35, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '三色模组60W 直径30CM', '1756355886273', 'LEDDX00106', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 0, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (36, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '白光24W 直径22CM', '1756354078309', 'LEDDX00103', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 0, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (37, 1011, 300, '774317814352', '雷士led灯芯吸顶磁吸节能灯板改装光源模组圆形三色模组家用环形', '', '三色模组36W 直径23CM', '1756355886271', 'LEDDX00104', NULL, 'https://img.pddpic.com/gaudit-image/2025-07-06/64eeaa77c1d01bb91bea649e7615bd3c.jpeg', 0, 98, 1, NULL, 1751768141, 1751768141, 0, 0, 0, '2026-01-02 19:40:20', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (38, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 2XL', '3628285618986498', '0', '3101777916e7c95984525ac33a27588f2077cc1793', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 106, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (39, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 XL', '3628285618986242', '0', '3101777916ff773b20589386b71b093160f2278141', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 133, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (40, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 L', '3628285618985986', '0', '310177791641707615a062ba2af4e56fe5f739f3de', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 449, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (41, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 M', '3628285618985730', '0', '3101777916ef5287dcf85bcd35eac09ca181a7b1e6', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 464, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (42, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 2XL', '3628285618985474', '0', '31017779160aafdfee412d4e86f3baf5c2b875211f', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 251, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:37', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (43, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 XL', '3628285618985218', '0', '31017779160e0fabf19d19389323b96b26bd9a4568', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 196, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (44, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 L', '3628285618984962', '0', '31017779163b8cbfb5961ded1f3c6fcc3e8e5f37b0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 265, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (45, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 M', '3628285618984706', '0', '31017779164882fd1cc4cbb8bb15fe8d453498820d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 458, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (46, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 2XL', '3628285618984450', '0', '310177791696118a2a7d521ef75307b7f82d105db9', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 617, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (47, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 XL', '3628285618984194', '0', '310177791661d09a5c4734af472bdc3d34d9569166', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (48, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 L', '3628285618983938', '0', '31017779164af1259ef7a73891dc671d186125b1fe', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (49, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 M', '3628285618983682', '0', '3101777916d3163efeb6ff8ece2e90c256e5b62999', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1110, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (50, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 2XL', '3628285618983426', '0', '31017779168b7a4dae7733ababf5660f6dcd8b2515', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 312, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (51, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 XL', '3628285618983170', '0', '3101777916bc68bdfb475f2696c5b6cb2b3af4c9d2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (52, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 L', '3628285618982914', '0', '3101777916ce72fba1c7b206ffb0fa8af68b29ab05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 205, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (53, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 M', '3628285618982658', '0', '31017779166e9fbce2f27e992431150d9275f40a6a', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:38', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (54, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 2XL', '3628285618982402', '0', '31017779165dc1cd470cf24a64b16969e95df1463e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 297, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (55, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 XL', '3628285618982146', '0', '3101777916b00c505b3b98340ff5a4e304a092e1c2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (56, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 L', '3628285618981890', '0', '310177791626375f3b2a885181df4702094a4a3b0d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (57, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 M', '3628285618981634', '0', '310177791659ab945c1c6ca33f7c196fc6709cea75', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 282, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (58, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 2XL', '3628285618981378', '0', '3101777916ebe6270b2c78e38b1cf29a32492ecc86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 75, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (59, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 XL', '3628285618981122', '0', '3101777916f59a865fab841f543226a33a4869ee4b', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 216, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (60, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 L', '3628285618980866', '0', '310177791681abc2c13110c48f7c4c7b5102682dbd', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 394, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (61, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 M', '3628285618980610', '0', '31017779166744717b6b93c7a114b94f9fa5a10dca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 516, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (62, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 2XL', '3628285618980354', '0', '3101777916ad329013903f6dfd621d572ea5632632', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (63, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 XL', '3628285618980098', '0', '3101777916cc70b9d5f165e5759b2f99916ac17df2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 611, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (64, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 L', '3628285618979842', '0', '31017779167bc60ee657252f1afaac1f8a02a23619', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 645, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (65, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 M', '3628285618979586', '0', '310177791684facce3f925095c4104c54f6a3b4997', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1133, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (66, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 2XL', '3628285618979330', '0', '3101777916e3869515c1f8b92c7340bfce88a300e7', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 878, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:39', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (67, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 XL', '3628285618979074', '0', '310177791627da0277c857de533bebb9e02cc645f4', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 419, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (68, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 L', '3628285618978818', '0', '3101777916a44f25eef859f272250b0194da4b0896', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 247, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (69, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 M', '3628285618978562', '0', '3101777916b0527c82042f8a0239fbf34c7d794ce5', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 606, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (70, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 2XL', '3628285618978306', '0', '31017779168b2f4e290780ac75a57fe05a8bbc9d86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1104, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (71, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 XL', '3628285618978050', '0', '3101777916549966d4600eeafd839208dbb8aca76c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (72, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 L', '3628285618977794', '0', '310177791634a634124ee41cfce853161a09bcb5e0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 900, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (73, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 M', '3628285618977538', '0', '310177791636651006f01928209e4b7f267d6d9811', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 2345, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (74, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 2XL', '3628285618977282', '0', '3101777916f9cf404ce55b9d7d38bf8204d923667e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 375, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (75, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 XL', '3628285618977026', '0', '31017779164c5e118ead1250341c882648ce32e0ee', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 557, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (76, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 L', '3628285618976770', '0', '3101777916fe938577e35eb370a2c7dd64eb4960ca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 847, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (77, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 M', '3628285618976514', '0', '310177791660b1f614dbe3f077d880c7befdfb2c71', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 627, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (78, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 2XL', '3628285618976258', '0', '3101777916805b45b6ceaf6fc4b62910113c24703c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 202, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (79, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 XL', '3628285618976002', '0', '3101777916617ec907472ad0affbe25ea595ab46ac', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 193, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (80, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 L', '3628285618975746', '0', '31017779164e74574230b02b815fdff4fe2931ada2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 204, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:40', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (81, 1007, 400, '3794979969814364768', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 M', '3628285618975490', '0', '31017779162c99dbfef3c7eba8c9227a24a65c7916', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 267, 1, NULL, 1767177477, 1767177477, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (82, 1007, 400, '3794982173375856864', '【测试商品勿拍】测试国标3C充电宝大容量20000', 'tb_1688_833550355146_6DMZk54Zni', '20000mAh 标准版', '3628115019615490', '0', '3c认证版-紫色★标准版【智能数显★自带三线】20000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 7990, 630, 1, NULL, 1767177393, 1767177393, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (83, 1007, 400, '3794982173375856864', '【测试商品勿拍】测试国标3C充电宝大容量20000', 'tb_1688_833550355146_6DMZk54Zni', '10000mAh 标准版', '3628115019615234', '0', '3c认证版-紫色★标准版【智能数显★自带三线】10000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 5990, 604, 1, NULL, 1767177393, 1767177393, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (84, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 杯子+杯刷吸管刷4颗立体贴', '3628115096533506', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (85, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 500mL单杯', '3628115096533250', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (86, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 杯子+杯刷吸管刷4颗立体贴', '3628115096532994', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (87, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 500mL单杯', '3628115096532738', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (88, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 杯子+杯刷吸管刷4颗立体贴', '3628115096532482', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (89, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 500mL单杯', '3628115096532226', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (90, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 杯子+杯刷吸管刷4颗立体贴', '3628115096531970', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (91, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 500mL单杯', '3628115096531714', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (92, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 杯子+杯刷吸管刷4颗立体贴', '3628115096531458', '0', '前缀JXQ-139号毛绒儿童保温杯-红色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (93, 1007, 400, '3794976727281828284', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 500mL单杯', '3628115096531202', '0', '前缀JXQ-139号毛绒儿童保温杯-红色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767177081, 1767177081, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (94, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 3XL', '3628301544437250', '0', '3794785772951962048-07-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8885, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:41', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (95, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 2XL', '3628301544436994', '0', '3794785772951962048-07-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8882, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (96, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 XL', '3628301544436738', '0', '3794785772951962048-07-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8886, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (97, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 L', '3628301544436482', '0', '3794785772951962048-07-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8884, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (98, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 M', '3628301544436226', '0', '3794785772951962048-07-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (99, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 3XL', '3628301544435970', '0', '3794785772951962048-05-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8838, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (100, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 2XL', '3628301544435714', '0', '3794785772951962048-05-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8831, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (101, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 XL', '3628301544435458', '0', '3794785772951962048-05-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8833, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (102, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 L', '3628301544435202', '0', '3794785772951962048-05-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8851, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (103, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 M', '3628301544434946', '0', '3794785772951962048-05-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8879, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (104, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 3XL', '3628301544434690', '0', '3794785772951962048-03-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8825, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (105, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 2XL', '3628301544434434', '0', '3794785772951962048-03-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8764, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (106, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 XL', '3628301544434178', '0', '3794785772951962048-03-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8787, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (107, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 L', '3628301544433922', '0', '3794785772951962048-03-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8829, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (108, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 M', '3628301544433666', '0', '3794785772951962048-03-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8854, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:42', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (109, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 3XL', '3628301544433410', '0', '3794785772951962048-01-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (110, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 2XL', '3628301544433154', '0', '3794785772951962048-01-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8864, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (111, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 XL', '3628301544432898', '0', '3794785772951962048-01-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8845, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (112, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 L', '3628301544432642', '0', '3794785772951962048-01-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8856, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (113, 1007, 400, '3794979441717936232', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 M', '3628301544432386', '0', '3794785772951962048-01-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8883, 1, NULL, 1767177077, 1767177077, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (114, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 杯子+杯刷吸管刷4颗立体贴', '3628114613808386', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (115, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔黄色 500mL单杯', '3628114613808130', '0', '前缀JXQ-139号毛绒儿童保温杯-黄色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (116, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 杯子+杯刷吸管刷4颗立体贴', '3628114613807874', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (117, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔咖色 500mL单杯', '3628114613807618', '0', '前缀JXQ-139号毛绒儿童保温杯-棕色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (118, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 杯子+杯刷吸管刷4颗立体贴', '3628114613807362', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (119, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔绿色 500mL单杯', '3628114613807106', '0', '前缀JXQ-139号毛绒儿童保温杯-绿色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:43', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (120, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 杯子+杯刷吸管刷4颗立体贴', '3628114613806850', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (121, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔粉色 500mL单杯', '3628114613806594', '0', '前缀JXQ-139号毛绒儿童保温杯-粉色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (122, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 杯子+杯刷吸管刷4颗立体贴', '3628114613806338', '0', '前缀JXQ-139号毛绒儿童保温杯-红色+送8', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3100, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (123, 1007, 400, '3794978851134767143', '【测试勿拍】儿童保温杯可爱卡通学生双饮吸管水杯子男女幼儿园', '', '拉布兔红色 500mL单杯', '3628114613806082', '0', '前缀JXQ-139号毛绒儿童保温杯-红色', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5c48304458255e64d53c7a9171c0abf7_sx_278787_www800-800', 3010, 2, 1, NULL, 1767176725, 1767176725, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (124, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 2XL', '3628250427086082', '0', '3101777916e7c95984525ac33a27588f2077cc1793', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 106, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (125, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 XL', '3628250427085826', '0', '3101777916ff773b20589386b71b093160f2278141', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 133, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (126, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 L', '3628250427085570', '0', '310177791641707615a062ba2af4e56fe5f739f3de', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 449, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (127, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其加长款 M', '3628250427085314', '0', '3101777916ef5287dcf85bcd35eac09ca181a7b1e6', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 464, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (128, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 2XL', '3628250427085058', '0', '31017779160aafdfee412d4e86f3baf5c2b875211f', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 251, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (129, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 XL', '3628250427084802', '0', '31017779160e0fabf19d19389323b96b26bd9a4568', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 196, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (130, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 L', '3628250427084546', '0', '31017779163b8cbfb5961ded1f3c6fcc3e8e5f37b0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 265, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (131, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其小个子 M', '3628250427084290', '0', '31017779164882fd1cc4cbb8bb15fe8d453498820d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 458, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (132, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 2XL', '3628250427084034', '0', '310177791696118a2a7d521ef75307b7f82d105db9', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 617, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (133, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 XL', '3628250427083778', '0', '310177791661d09a5c4734af472bdc3d34d9569166', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:44', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (134, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 L', '3628250427083522', '0', '31017779164af1259ef7a73891dc671d186125b1fe', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 633, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (135, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '卡其常规款 M', '3628250427083266', '0', '3101777916d3163efeb6ff8ece2e90c256e5b62999', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1110, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (136, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 2XL', '3628250427083010', '0', '31017779168b7a4dae7733ababf5660f6dcd8b2515', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 312, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (137, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 XL', '3628250427082754', '0', '3101777916bc68bdfb475f2696c5b6cb2b3af4c9d2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (138, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 L', '3628250427082498', '0', '3101777916ce72fba1c7b206ffb0fa8af68b29ab05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 205, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (139, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色加长款 M', '3628250427082242', '0', '31017779166e9fbce2f27e992431150d9275f40a6a', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (140, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 2XL', '3628250427081986', '0', '31017779165dc1cd470cf24a64b16969e95df1463e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 297, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (141, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 XL', '3628250427081730', '0', '3101777916b00c505b3b98340ff5a4e304a092e1c2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (142, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 L', '3628250427081474', '0', '310177791626375f3b2a885181df4702094a4a3b0d', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 189, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (143, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色小个子 M', '3628250427081218', '0', '310177791659ab945c1c6ca33f7c196fc6709cea75', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 282, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (144, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 2XL', '3628250427080962', '0', '3101777916ebe6270b2c78e38b1cf29a32492ecc86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 75, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (145, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 XL', '3628250427080706', '0', '3101777916f59a865fab841f543226a33a4869ee4b', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 216, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:45', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (146, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 L', '3628250427080450', '0', '310177791681abc2c13110c48f7c4c7b5102682dbd', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 394, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (147, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '白色常规款 M', '3628250427080194', '0', '31017779166744717b6b93c7a114b94f9fa5a10dca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 516, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (148, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 2XL', '3628250427079938', '0', '3101777916ad329013903f6dfd621d572ea5632632', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 209, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (149, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 XL', '3628250427079682', '0', '3101777916cc70b9d5f165e5759b2f99916ac17df2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 611, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (150, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 L', '3628250427079426', '0', '31017779167bc60ee657252f1afaac1f8a02a23619', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 645, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (151, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色加长款 M', '3628250427079170', '0', '310177791684facce3f925095c4104c54f6a3b4997', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1133, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (152, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 2XL', '3628250427078914', '0', '3101777916e3869515c1f8b92c7340bfce88a300e7', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 878, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (153, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 XL', '3628250427078658', '0', '310177791627da0277c857de533bebb9e02cc645f4', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 419, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (154, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 L', '3628250427078402', '0', '3101777916a44f25eef859f272250b0194da4b0896', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 247, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (155, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色小个子 M', '3628250427078146', '0', '3101777916b0527c82042f8a0239fbf34c7d794ce5', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 606, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (156, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 2XL', '3628250427077890', '0', '31017779168b2f4e290780ac75a57fe05a8bbc9d86', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 1104, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (157, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 XL', '3628250427077634', '0', '3101777916549966d4600eeafd839208dbb8aca76c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 310, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (158, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 L', '3628250427077378', '0', '310177791634a634124ee41cfce853161a09bcb5e0', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 900, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (159, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '浅灰色常规款 M', '3628250427077122', '0', '310177791636651006f01928209e4b7f267d6d9811', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 2345, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:46', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (160, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 2XL', '3628250427076866', '0', '3101777916f9cf404ce55b9d7d38bf8204d923667e', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 375, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (161, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 XL', '3628250427076610', '0', '31017779164c5e118ead1250341c882648ce32e0ee', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 557, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (162, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 L', '3628250427076354', '0', '3101777916fe938577e35eb370a2c7dd64eb4960ca', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 847, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (163, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色加长款 M', '3628250427076098', '0', '310177791660b1f614dbe3f077d880c7befdfb2c71', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 627, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (164, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 2XL', '3628250427075842', '0', '3101777916805b45b6ceaf6fc4b62910113c24703c', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 202, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (165, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 XL', '3628250427075586', '0', '3101777916617ec907472ad0affbe25ea595ab46ac', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 193, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (166, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 L', '3628250427075330', '0', '31017779164e74574230b02b815fdff4fe2931ada2', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 204, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (167, 1007, 400, '3794979284842578041', '【测试勿拍】美式灰色运动裤女2025春秋季宽松', '', '黑色小个子 M', '3628250427075074', '0', '31017779162c99dbfef3c7eba8c9227a24a65c7916', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_83739a237a6a4c6982534d900f13ef91_sx_244975_www800-800', 9000, 267, 1, NULL, 1767176583, 1767176583, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (168, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 3XL', '3628249384985858', '0', '3794785772951962048-07-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8885, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (169, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 2XL', '3628249384985602', '0', '3794785772951962048-07-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8882, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (170, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 XL', '3628249384985346', '0', '3794785772951962048-07-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8886, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:47', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (171, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 L', '3628249384985090', '0', '3794785772951962048-07-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8884, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (172, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '长袖白色 M', '3628249384984834', '0', '3794785772951962048-07-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (173, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 3XL', '3628249384984578', '0', '3794785772951962048-05-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8838, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (174, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 2XL', '3628249384984322', '0', '3794785772951962048-05-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8831, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (175, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 XL', '3628249384984066', '0', '3794785772951962048-05-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8833, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (176, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 L', '3628249384983810', '0', '3794785772951962048-05-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8851, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (177, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35黑色 M', '3628249384983554', '0', '3794785772951962048-05-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8879, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (178, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 3XL', '3628249384983298', '0', '3794785772951962048-03-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8825, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (179, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 2XL', '3628249384983042', '0', '3794785772951962048-03-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8764, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (180, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 XL', '3628249384982786', '0', '3794785772951962048-03-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8787, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (181, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 L', '3628249384982530', '0', '3794785772951962048-03-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8829, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (182, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35卡其色 M', '3628249384982274', '0', '3794785772951962048-03-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8854, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (183, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 3XL', '3628249384982018', '0', '3794785772951962048-01-09', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8877, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (184, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 2XL', '3628249384981762', '0', '3794785772951962048-01-07', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8864, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (185, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 XL', '3628249384981506', '0', '3794785772951962048-01-05', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8845, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:48', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (186, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 L', '3628249384981250', '0', '3794785772951962048-01-03', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8856, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (187, 1007, 400, '3794971755907514823', '勿拍（48h+7d）秋季t恤男士长袖秋衣小衫休闲秋款打底衫', '', '（八伊）T35白色 M', '3628249384980994', '0', '3794785772951962048-01-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 6900, 8883, 1, NULL, 1767173876, 1767173876, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (188, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '黑色 可调节5458cm', '3628265555138818', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (189, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '灰色 可调节5458cm', '3628265555138562', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (190, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '咖啡色 可调节5458cm', '3628265555138306', '0', 'test~HamCXMNBLMeee_KFS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (191, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '杏色【1】 可调节5458cm', '3628265555138050', '0', 'test~HamCXMNBLMeee_XS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (192, 1007, 400, '3794973993509978250', 'test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜帽八角帽百搭画家', '', '摩卡色摩卡 可调节5458cm', '3628265555137794', '0', 'test~HamCXMNBLMeee_MKS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767173815, 1767173815, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (193, 1007, 400, '3794971272623030594', '[测试商品勿拍X]秋冬新款加绒束脚运动裤女士腰头松紧斜插口袋宽', '', '白蛋白 S', '3628233317459458', '0', 'HCK04910310', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_759fa940a40b17c03bbb19fe4ca116d7_sx_116476_www800-800', 6700, 65, 1, NULL, 1767173140, 1767173140, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (194, 1007, 400, '3794971272623030594', '[测试商品勿拍X]秋冬新款加绒束脚运动裤女士腰头松紧斜插口袋宽', '', '干花色 S', '3628233317459202', '0', 'HCK04908710', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_759fa940a40b17c03bbb19fe4ca116d7_sx_116476_www800-800', 6700, 55, 1, NULL, 1767173140, 1767173140, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (195, 1007, 400, '3794971272623030594', '[测试商品勿拍X]秋冬新款加绒束脚运动裤女士腰头松紧斜插口袋宽', '', '黑色 S', '3628233317458946', '0', 'HCK04900110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_759fa940a40b17c03bbb19fe4ca116d7_sx_116476_www800-800', 6700, 0, 1, NULL, 1767173140, 1767173140, 0, 0, 0, '2026-01-02 20:15:49', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (196, 1007, 400, '3794971923293798443', '【测试商品勿拍】国标3C充电宝大容量20000毫安', 'tb_1688_833550355146_A3J9En8lGP', '20000mAh 标准版', '3628233265400578', '0', '3c认证版-紫色★标准版【智能数显★自带三线】20000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 7990, 630, 1, NULL, 1767172765, 1767172765, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (197, 1007, 400, '3794971923293798443', '【测试商品勿拍】国标3C充电宝大容量20000毫安', 'tb_1688_833550355146_A3J9En8lGP', '10000mAh 标准版', '3628233265400322', '0', '3c认证版-紫色★标准版【智能数显★自带三线】10000毫安', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_84985e6135148ae77cf3937700687314_sx_132200_www800-800', 5990, 604, 1, NULL, 1767172765, 1767172765, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (198, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 140cm', '3628265252734722', '0', 'Y232-SJT-JR140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8845, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (199, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 130cm', '3628265252734466', '0', 'Y232-SJT-JR130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8841, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (200, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 120cm', '3628265252734210', '0', 'Y232-SJT-JR120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8829, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (201, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 110cm', '3628265252733954', '0', 'Y232-SJT-JR110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8830, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (202, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 100cm', '3628265252733698', '0', 'Y232-SJT-JR100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8824, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (203, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 90cm', '3628265252733442', '0', 'Y232-SJT-JR90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8830, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (204, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱+毛衣 80cm', '3628265252733186', '0', 'Y232-SJT-JR80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 8600, 8831, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (205, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 140cm', '3628265252732930', '0', 'Y232-QZ-JR140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8848, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (206, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 130cm', '3628265252732674', '0', 'Y232-QZ-JR130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8849, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:50', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (207, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 120cm', '3628265252732418', '0', 'Y232-QZ-JR120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8847, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (208, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 110cm', '3628265252732162', '0', 'Y232-QZ-JR110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8842, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (209, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 100cm', '3628265252731906', '0', 'Y232-QZ-JR100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8840, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (210, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 90cm', '3628265252731650', '0', 'Y232-QZ-JR90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8844, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (211, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '【加绒】背心裙+头纱 80cm', '3628265252731394', '0', 'Y232-QZ-JR80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 6500, 8848, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (212, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 140cm', '3628265252731138', '0', 'Y232-SJT140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8802, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (213, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 130cm', '3628265252730882', '0', 'Y232-SJT130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8806, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (214, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 120cm', '3628265252730626', '0', 'Y232-SJT120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8787, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (215, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 110cm', '3628265252730370', '0', 'Y232-SJT110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8784, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (216, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 100cm', '3628265252730114', '0', 'Y232-SJT100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8791, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (217, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 90cm', '3628265252729858', '0', 'Y232-SJT90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8783, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (218, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱+毛衣 80cm', '3628265252729602', '0', 'Y232-SJT80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 7900, 8788, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:51', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (219, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 140cm', '3628265252729346', '0', 'Y232-QZ140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8821, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (220, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 130cm', '3628265252729090', '0', 'Y232-QZ130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8807, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (221, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 120cm', '3628265252728834', '0', 'Y232-QZ120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8810, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (222, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 110cm', '3628265252728578', '0', 'Y232-QZ110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8812, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (223, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 100cm', '3628265252728322', '0', 'Y232-QZ100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8816, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (224, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 90cm', '3628265252728066', '0', 'Y232-QZ90', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8820, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (225, 1007, 400, '3794969979737211285', '勿拍@女童连衣裙2025秋冬新款女宝宝公主网纱裙周岁礼服', '', '背心裙+头纱 80cm', '3628265252727810', '0', 'Y232-QZ80', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_1a7df6cc736c5eaf06a11cccc3a91a15_sx_330250_www1500-1500', 5800, 8829, 1, NULL, 1767172605, 1767172605, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (226, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 XL', '3628078572764674', '0', 'test~A#749026384071eee_KFS_XL', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (227, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 L', '3628078572764418', '0', 'test~A#749026384071eee_KFS_L', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (228, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 M', '3628078572764162', '0', 'test~A#749026384071eee_KFS_M', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (229, 1007, 400, '3794971539011665947', '[测试商品勿拍X]test！法式灯芯绒马甲女2025春秋新款复古无袖上', '', '咖啡色 S', '3628078572763906', '0', 'test~A#749026384071eee_KFS_S', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_16576a6713bc52831bb3a13b67a0e12e_sx_131629_www800-800', 4320, 10, 1, NULL, 1767172406, 1767172406, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (230, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '黑色 可调节5458cm', '3628198405998850', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:52', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (231, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '灰色 可调节5458cm', '3628198405998594', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (232, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '咖啡色 可调节5458cm', '3628198405998338', '0', 'test~HamCXMNBLMeee_KFS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (233, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '杏色【1】& 可调节5458cm', '3628198405998082', '0', 'test~HamCXMNBLMeee_XS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (234, 1007, 400, '3794969769258647841', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '摩卡色&摩卡 可调节5458cm', '3628198405997826', '0', 'test~HamCXMNBLMeee_MKS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 2853, 10, 1, NULL, 1767172405, 1767172405, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (235, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 170', '3628113596534018', '0', 'AINI5228MIX170', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4970, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (236, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 160', '3628113596533762', '0', 'AINI5228MIX160', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4720, 40, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (237, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 150', '3628113596533506', '0', 'AINI5228MIX150', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4470, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (238, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 140', '3628113596533250', '0', 'AINI5228MIX140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4220, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (239, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 130', '3628113596532994', '0', 'AINI5228MIX130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 4000, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (240, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 120', '3628113596532738', '0', 'AINI5228MIX120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3780, 30, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (241, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 110', '3628113596532482', '0', 'AINI5228MIX110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3560, 4, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:53', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (242, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 100', '3628113596532226', '0', 'AINI5228MIX100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3360, 16, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (243, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '上衣+裙子(套装) 90', '3628113596531970', '0', 'AINI5228MIX090', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 3160, 5, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (244, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 170', '3628113596531714', '0', 'AINI5230AA170', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2280, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (245, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 160', '3628113596531458', '0', 'AINI5230AA160', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2180, 42, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (246, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 150', '3628113596531202', '0', 'AINI5230AA150', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2080, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (247, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 140', '3628113596530946', '0', 'AINI5230AA140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1980, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (248, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 130', '3628113596530690', '0', 'AINI5230AA130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1880, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (249, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 120', '3628113596530434', '0', 'AINI5230AA120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1780, 30, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (250, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 110', '3628113596530178', '0', 'AINI5230AA110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1680, 4, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (251, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 100', '3628113596529922', '0', 'AINI5230AA100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1580, 16, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (252, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '经典黑 90', '3628113596529666', '0', 'AINI5230AA090', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1480, 5, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (253, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 170', '3628113596529410', '0', 'AINI5228AA170', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2690, 53, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:54', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (254, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 160', '3628113596529154', '0', 'AINI5228AA160', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2540, 40, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (255, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 150', '3628113596528898', '0', 'AINI5228AA150', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2390, 14, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (256, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 140', '3628113596528642', '0', 'AINI5228AA140', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2240, 24, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (257, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 130', '3628113596528386', '0', 'AINI5228AA130', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2120, 0, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (258, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 120', '3628113596528130', '0', 'AINI5228AA120', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 2000, 97, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (259, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 110', '3628113596527874', '0', 'AINI5228AA110', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1880, 124, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (260, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 100', '3628113596527618', '0', 'AINI5228AA100', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1780, 161, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (261, 1007, 400, '3794970991344615654', '勿拍#法式亮片蝴蝶结卫衣秋季2025新款时髦甜美套头上衣', '', '晶蝶黑 90', '3628113596527362', '0', 'AINI5228AA090', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_c8c21c8765037259ddcb50ebac0f4865_sx_163602_www1200-1200', 1680, 72, 1, NULL, 1767172240, 1767172240, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (262, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '黑色 均码', '3628149916230146', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 662, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (263, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '米白 均码', '3628149916229890', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 664, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (264, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '灰色 均码', '3628149916229634', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 662, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:55', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (265, 1007, 400, '3794967941867504075', '勿拍@蝴蝶结V领针织马甲背心女2025春秋新款减龄叠穿', '', '浅蓝 均码', '3628149916229378', '0', '3163', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_237e0e9f942a8479cf6bf1385c6d3a49_sx_176405_www800-800', 3600, 655, 1, NULL, 1767171998, 1767171998, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (266, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '黑色 可调节5458cm', '3628059051505922', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (267, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '灰色 可调节5458cm', '3628059051505666', '0', 'test~HamCXMNBLMeee_HS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (268, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '咖啡色 可调节5458cm', '3628059051505410', '0', 'test~HamCXMNBLMeee_KFS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (269, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '杏色【1】 可调节5458cm', '3628059051505154', '0', 'test~HamCXMNBLMeee_XS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (270, 1007, 400, '3794970437218336881', '[测试商品勿拍X]test！秋冬覆古毛呢贝雷帽韩版简约字母刺绣南瓜', '', '摩卡色&摩卡 可调节5458cm', '3628059051504898', '0', 'test~HamCXMNBLMeee_MKS_KTJ54—58cm', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_cc4fe84e2a6d535642014f6d5bd85794_sx_173743_www800-800', 3353, 10, 1, NULL, 1767171306, 1767171306, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (271, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 110cm-XXL', '3628041733334018', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 7310, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (272, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 100cm-XL', '3628041733333762', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 7712, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (273, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 90cm-L', '3628041733333506', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 7745, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:56', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (274, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora蓝色 80cm-M', '3628041733333250', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 8161, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (275, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 110cm-XXL', '3628041733332994', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 6256, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (276, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 100cm-XL', '3628041733332738', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 3625, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (277, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 90cm-L', '3628041733332482', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1770, 3125, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (278, 1007, 400, '3794966919573012596', '[测试商品勿拍X]实力工厂童装女童连衣裙小香风公主裙子宝宝假两', '', 'Dora粉色 80cm-M', '3628041733332226', '0', 'Dora', 'https://p9-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_f59abc704313c3c3d67bbc227b8bb95c_sx_190712_www800-800', 1730, 4365, 1, NULL, 1767170248, 1767170248, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (279, 1007, 400, '3794964428567478515', 'test勿拍@美式复古v领套头毛衣秋冬！', '', '卡其色 均码', '3628130474780418', '0', '3794786271252054177-03-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5854d11ed633c4ef0f66c771f6213afb_sx_405366_www800-800', 3600, 10000, 1, NULL, 1767169679, 1767169679, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (280, 1007, 400, '3794964428567478515', 'test勿拍@美式复古v领套头毛衣秋冬！', '', '杏色 均码', '3628130474780162', '0', '3794786271252054177-01-01', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_5854d11ed633c4ef0f66c771f6213afb_sx_405366_www800-800', 3600, 10000, 1, NULL, 1767169679, 1767169679, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (281, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 5XL', '3628283609447170', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (282, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 4XL', '3628283609446914', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8887, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (283, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 3XL', '3628283609446658', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8885, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:57', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (284, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 2XL', '3628283609446402', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8882, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (285, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 XL', '3628283609446146', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (286, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 L', '3628283609445890', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8884, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (287, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 M', '3628283609445634', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8877, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (288, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 5XL', '3628283609445378', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8872, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (289, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 4XL', '3628283609445122', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8857, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (290, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 3XL', '3628283609444866', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8838, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (291, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 2XL', '3628283609444610', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8831, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (292, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 XL', '3628283609444354', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8833, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (293, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 L', '3628283609444098', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8851, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:58', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (294, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 M', '3628283609443842', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8879, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (295, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 5XL', '3628283609443586', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8862, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (296, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 4XL', '3628283609443330', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8844, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (297, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 3XL', '3628283609443074', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8825, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (298, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 2XL', '3628283609442818', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8764, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (299, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 XL', '3628283609442562', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8785, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (300, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 L', '3628283609442306', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8828, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (301, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 M', '3628283609442050', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8854, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (302, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 5XL', '3628283609441794', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (303, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 4XL', '3628283609441538', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8882, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (304, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 3XL', '3628283609441282', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8877, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (305, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 2XL', '3628283609441026', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8863, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (306, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 XL', '3628283609440770', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8844, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (307, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 L', '3628283609440514', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8856, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (308, 1007, 400, '3794964819493388462', '跨境新春秋季t恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 M', '3628283609440258', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169467, 1767169467, 0, 0, 0, '2026-01-02 20:15:59', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (309, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 5XL', '3628112641875714', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (310, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 4XL', '3628112641875458', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8887, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (311, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 3XL', '3628112641875202', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8885, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (312, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 2XL', '3628112641874946', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8882, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (313, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 XL', '3628112641874690', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8886, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (314, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 L', '3628112641874434', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8884, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (315, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '长袖白色 M', '3628112641874178', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 700, 8877, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (316, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 5XL', '3628112641873922', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8872, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (317, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 4XL', '3628112641873666', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8859, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (318, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 3XL', '3628112641873410', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8839, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (319, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 2XL', '3628112641873154', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8831, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (320, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 XL', '3628112641872898', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8833, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:00', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (321, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 L', '3628112641872642', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8852, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (322, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35黑色 M', '3628112641872386', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8879, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (323, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 5XL', '3628112641872130', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8865, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (324, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 4XL', '3628112641871874', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8845, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (325, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 3XL', '3628112641871618', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8826, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (326, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 2XL', '3628112641871362', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8764, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (327, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 XL', '3628112641871106', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8793, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (328, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 L', '3628112641870850', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8832, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (329, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35卡其色 M', '3628112641870594', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8855, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (330, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 5XL', '3628112641870338', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (331, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 4XL', '3628112641870082', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8882, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (332, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 3XL', '3628112641869826', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8877, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (333, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 2XL', '3628112641869570', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8864, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:01', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (334, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 XL', '3628112641869314', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8847, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:02', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (335, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 L', '3628112641869058', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8859, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:02', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (336, 1007, 400, '3794963221690056839', '跨境新春秋季T恤男士长袖秋衣打底体恤小衫休闲秋款打底衫可外穿', '', '（八伊）T35白色 M', '3628112641868802', '0', '', 'https://p3-aio.ecombdimg.com/obj/ecom-shop-material/jpeg_m_23cb22a9cc50415f5469b784d5f0dcc2_sx_209760_www800-800', 1500, 8883, 1, NULL, 1767169423, 1767169423, 0, 0, 0, '2026-01-02 20:16:02', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1224, 1012, 500, '10000239789987', '牧马人K100机械键盘黑色经典电竞游戏办公有线背光键鼠套装网吧', '', '', '3531937224', '', '', '', 19900, 100, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:24', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1225, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 18W白光', '3531475359', '', '', '', 3990, 9, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:24', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1226, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 24W白光', '3531318781', '', '', '', 4990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1227, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 36W白光', '3531485362', '', '', '', 5990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1228, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 48W白光', '3531313894', '', '', '', 6990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);
INSERT INTO `oms_shop_goods_sku` VALUES (1229, 1012, 500, '10000239803737', '雷士照明led吸顶灯灯芯替换圆形灯板节能灯芯冷光高显6W至40W护眼', '', ' 72W白光', '3531430948', '', '', '', 7990, 12, 5, NULL, NULL, 0, 0, 0, 0, '2026-01-03 09:00:25', NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '系统名称', 'sys.name', '启航电商WMS系统', 'Y', 'admin', '2023-08-07 19:31:38', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2023-08-07 19:31:38', '', NULL, '是否开启验证码功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '启航技术', 0, '老齐', '15888888888', '280645618@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2024-09-15 17:52:12');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '研发中心', 1, '老齐', '15888888888', '280645618@qq.com', '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2024-09-15 17:52:47');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '市场中心', 2, '方', '15888888888', 'market@qihangerp.cn', '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2024-09-15 17:53:28');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '至简', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2023-08-07 19:31:37', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2023-08-07 19:31:38', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2145 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '电商销售管理', 0, 10, '/sales', 'Layout', '', 1, 0, 'M', '0', '0', '', 'shop', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-01 09:22:11', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '入库管理', 0, 30, '/stock_in', 'Layout', '', 1, 0, 'M', '0', '0', '', 'edit', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-04 11:09:28', '至简官网地址');
INSERT INTO `sys_menu` VALUES (4, '商品管理', 0, 0, 'goods', 'Layout', '', 1, 0, 'M', '0', '0', '', 'international', 'admin', '2023-12-29 16:53:03', 'admin', '2025-10-01 12:16:48', '');
INSERT INTO `sys_menu` VALUES (5, '系统设置', 0, 99, '/system', 'Layout', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2023-12-27 15:00:27', 'admin', '2023-12-29 09:07:42.856856', '系统管理目录');
INSERT INTO `sys_menu` VALUES (6, '出库管理', 0, 20, 'stock_out', 'Layout', NULL, 1, 0, 'M', '0', '0', '', 'stock_out', 'admin', '2024-03-30 17:36:10', 'admin', '2026-01-05 07:17:49', '');
INSERT INTO `sys_menu` VALUES (7, '仓库设置', 0, 50, 'warehouse', 'Layout', NULL, 1, 0, 'M', '0', '0', '', 'lock', 'admin', '2024-08-25 15:54:14', 'admin', '2026-01-06 10:06:24', '');
INSERT INTO `sys_menu` VALUES (100, '店铺订单库', 1, 1, 'order_list', 'order/index', '', 1, 0, 'C', '0', '0', '', 'shopping', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-04 14:16:30', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '店铺订单下载', 1, 10, 'shop_order_pull', 'order/shop_order_pull', '', 1, 0, 'C', '1', '0', '', 'download', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-13 12:01:13', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (106, '店铺售后管理', 1, 20, 'shop_refund_list', 'refund/index', '', 1, 0, 'C', '0', '0', '', 'edit', 'admin', '2023-12-27 15:00:27', 'admin', '2026-01-11 07:58:48', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (108, '店铺管理', 1, 86, 'shop_list', 'shop/index', '', 1, 0, 'C', '0', '0', '', 'shop', 'admin', '2023-12-29 09:14:02', 'admin', '2026-01-01 07:07:02', '');
INSERT INTO `sys_menu` VALUES (110, '平台参数设置', 1, 88, 'platform/setting', 'shop/platform/index', '', 1, 0, 'C', '0', '0', '', 'system', 'admin', '2023-12-29 13:32:41', 'admin', '2025-07-11 13:59:36', '');
INSERT INTO `sys_menu` VALUES (116, '用户管理', 5, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', '', 'user', 'admin', '2023-12-27 15:00:27', '', '', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (117, '菜单管理', 5, 1, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', '', 'user', 'admin', '2023-12-27 15:00:27', '', '', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (177, '店铺商品管理', 1, 30, 'shop_goods', 'goods/shopGoods/goods_item_list', NULL, 1, 0, 'C', '0', '0', '', 'goods', 'admin', '2024-03-28 10:29:59', 'admin', '2026-01-02 02:04:37', '');
INSERT INTO `sys_menu` VALUES (401, '渠道商品管理', 4, 50, 'offline_goods_list', 'offline/goods/index', NULL, 1, 0, 'C', '0', '1', '', 'documentation', 'admin', '2024-07-27 17:33:54', 'admin', '2024-09-07 23:17:59', '');
INSERT INTO `sys_menu` VALUES (404, '商品库', 4, 0, 'goods_list', 'goods/goods/index', NULL, 1, 0, 'C', '0', '0', 'goods', 'example', 'admin', '2024-08-25 14:35:54', 'admin', '2025-09-08 20:05:25', '');
INSERT INTO `sys_menu` VALUES (407, '添加商品', 4, 99, 'create', 'goods/goods/create', NULL, 1, 0, 'C', '1', '0', '', 'checkbox', 'admin', '2024-03-18 07:59:57', 'admin', '2025-12-30 02:31:01', '');
INSERT INTO `sys_menu` VALUES (409, '商品分类管理', 4, 80, 'category_list', 'goods/category/index', NULL, 1, 0, 'C', '0', '0', '', 'edit', 'admin', '2024-08-25 18:43:28', 'admin', '2024-09-07 15:47:44', '');
INSERT INTO `sys_menu` VALUES (410, '商品品牌管理', 4, 81, 'brand_list', 'goods/brand/index', NULL, 1, 0, 'C', '0', '0', '', 'icon', 'admin', '2024-08-25 18:45:47', 'admin', '2024-09-07 15:48:31', '');
INSERT INTO `sys_menu` VALUES (412, '规格属性值', 4, 102, 'goods_category/attribute_value', 'goods/category/categoryAttributeValue', NULL, 1, 0, 'C', '1', '0', '', 'date', 'admin', '2024-08-25 18:51:55', 'admin', '2024-09-07 16:23:53', '');
INSERT INTO `sys_menu` VALUES (413, '分类规格属性', 4, 101, 'goods_category/attribute', 'goods/category/categoryAttribute', NULL, 1, 0, 'C', '1', '0', '', 'button', 'admin', '2024-08-25 18:49:22', 'admin', '2024-09-07 16:17:01', '');
INSERT INTO `sys_menu` VALUES (808, '供应商管理', 4, 90, 'supplier_list', 'goods/supplier/index', NULL, 1, 0, 'C', '0', '0', '', 'people', 'admin', '2024-08-25 18:27:55', 'admin', '2025-12-30 02:30:41', '');
INSERT INTO `sys_menu` VALUES (2079, '字典管理', 5, 9, 'dict', 'system/dict/index', NULL, 1, 0, 'C', '0', '0', '', 'dict', 'admin', '2024-03-18 08:43:55', 'admin', '2024-03-18 08:44:08', '');
INSERT INTO `sys_menu` VALUES (2088, '发货设置', 7, 9, 'ship_set', 'shipping/logistics/index', NULL, 1, 0, 'C', '0', '0', '', 'checkbox', 'admin', '2024-03-30 17:37:01', 'admin', '2025-12-30 03:01:01', '');
INSERT INTO `sys_menu` VALUES (2089, '出库商品明细', 6, 30, 'item_list', 'stockOut/item_list', NULL, 1, 0, 'C', '0', '0', '', 'list', 'admin', '2024-03-30 17:37:42', 'admin', '2026-01-07 02:52:35', '');
INSERT INTO `sys_menu` VALUES (2090, '角色管理', 5, 2, 'role', 'system/role/index', NULL, 1, 0, 'C', '0', '0', NULL, 'peoples', 'admin', '2024-03-31 12:40:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '部门管理', 5, 3, 'dept', 'system/dept/index', NULL, 1, 0, 'C', '0', '0', NULL, 'tree', 'admin', '2024-03-31 12:42:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2099, '私域订单管理', 1, 10, 'offline_order_list', 'order/private/index', NULL, 1, 0, 'C', '0', '1', '', 'checkbox', 'admin', '2024-07-27 17:33:03', 'admin', '2025-05-24 13:10:53', '');
INSERT INTO `sys_menu` VALUES (2100, '私域售后管理', 2, 3, 'offline_aftersale', 'refund/private/index', NULL, 1, 0, 'C', '0', '1', '', 'code', 'admin', '2024-07-27 17:33:33', 'admin', '2025-05-25 14:59:03', '');
INSERT INTO `sys_menu` VALUES (2103, '手动创建订单', 1, 49, 'order_create', 'order/create', NULL, 1, 0, 'C', '1', '0', '', 'date', 'admin', '2024-07-27 20:30:07', 'admin', '2026-01-03 02:48:11', '');
INSERT INTO `sys_menu` VALUES (2106, '入库管理', 2, 10, 'stock_in_list', 'stockIn/index.vue', NULL, 1, 0, 'C', '0', '0', '', 'stock-in', 'admin', '2024-08-25 15:56:04', 'admin', '2026-01-05 07:16:07', '');
INSERT INTO `sys_menu` VALUES (2114, '仓库管理', 7, 90, 'warehouse', 'warehouse/index.vue', NULL, 1, 0, 'C', '0', '0', '', 'warehouse', 'admin', '2024-09-21 20:07:26', 'admin', '2026-01-05 08:23:58', '');
INSERT INTO `sys_menu` VALUES (2115, '商品库存', 2139, 10, 'goods_stock', 'stock/goodsInventory/index', NULL, 1, 0, 'C', '0', '0', '', 'chart', 'admin', '2024-09-21 20:43:00', 'admin', '2026-01-10 07:33:28', '');
INSERT INTO `sys_menu` VALUES (2116, '出库管理', 6, 20, 'out_list', 'stockOut/index', NULL, 1, 0, 'C', '0', '0', '', 'stock_out1', 'admin', '2024-09-21 20:44:46', 'admin', '2026-01-05 07:18:55', '');
INSERT INTO `sys_menu` VALUES (2117, '仓位货架', 7, 91, 'position', 'warehouse/position', NULL, 1, 0, 'C', '0', '0', '', 'shinshop', 'admin', '2024-09-22 11:52:18', 'admin', '2026-01-05 08:25:26', '');
INSERT INTO `sys_menu` VALUES (2118, '新建入库单', 2, 11, 'create', 'stockIn/create.vue', NULL, 1, 0, 'C', '1', '0', '', '404', 'admin', '2024-09-22 14:49:40', 'admin', '2026-01-05 06:59:51', '');
INSERT INTO `sys_menu` VALUES (2135, '退货入库', 2, 20, 's', NULL, NULL, 1, 0, 'C', '1', '0', '', 'return_stock_in', 'admin', '2025-12-30 02:58:18', 'admin', '2026-01-06 00:42:04', '');
INSERT INTO `sys_menu` VALUES (2136, '采购入库', 2, 30, 'p', NULL, NULL, 1, 0, 'C', '1', '0', '', 'checkbox', 'admin', '2025-12-30 02:58:43', 'admin', '2026-01-06 00:42:09', '');
INSERT INTO `sys_menu` VALUES (2137, '入库操作', 2, 12, 'in', 'stockIn/in', NULL, 1, 0, 'C', '1', '0', '', 'stockin', 'admin', '2026-01-05 08:27:23', 'admin', '2026-01-05 08:27:32', '');
INSERT INTO `sys_menu` VALUES (2138, '入库记录', 2, 13, 'stock_in_detail', 'stockIn/detail', NULL, 1, 0, 'C', '0', '0', '', 'stockin', 'admin', '2026-01-05 13:47:02', 'admin', '2026-01-07 02:50:12', '');
INSERT INTO `sys_menu` VALUES (2139, '库存管理', 0, 40, 'stock', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'stock', 'admin', '2026-01-06 10:06:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2140, '盘点管理', 2139, 20, 'pandian', 'stockTake/index', NULL, 1, 0, 'C', '0', '0', '', 'stock_out1', 'admin', '2026-01-06 10:09:55', 'admin', '2026-01-07 13:24:04', '');
INSERT INTO `sys_menu` VALUES (2141, '库内调拨', 2139, 50, 'diaobo', 'stockTransfer/index', NULL, 1, 0, 'C', '0', '0', '', 'button', 'admin', '2026-01-06 10:10:41', 'admin', '2026-01-10 07:32:21', '');
INSERT INTO `sys_menu` VALUES (2142, '报损管理', 2139, 40, 'baosun', 'stockBad/index', NULL, 1, 0, 'C', '0', '0', '', 'bug', 'admin', '2026-01-06 10:11:14', 'admin', '2026-01-08 09:28:58', '');
INSERT INTO `sys_menu` VALUES (2143, '出库记录', 6, 50, 'stock_out_detail', 'stockOut/detail', NULL, 1, 0, 'C', '0', '0', '', 'list', 'admin', '2026-01-07 02:52:13', 'admin', '2026-01-07 02:52:44', '');
INSERT INTO `sys_menu` VALUES (2144, '店铺订单导入', 1, 12, 'shop_order_import', 'order/shop_order_import', NULL, 1, 0, 'C', '1', '0', '', 'clipboard', 'admin', '2026-01-13 12:01:53', 'admin', '2026-01-13 12:02:01', '');

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'URL地址',
  `object_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '对象名',
  `bucket` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '桶名',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------
INSERT INTO `sys_oss` VALUES (1, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/a3e935aa-d1b3-4524-bd84-e567df01f2e3.jpg', '/images/2024/09/07/a3e935aa-d1b3-4524-bd84-e567df01f2e3.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:38:57', '', NULL);
INSERT INTO `sys_oss` VALUES (2, '主图画板2.jpg', '主图画板2.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/1dbe1530-787f-4461-9f20-3efa3c332588.jpg', '/images/2024/09/07/1dbe1530-787f-4461-9f20-3efa3c332588.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:57:54', '', NULL);
INSERT INTO `sys_oss` VALUES (3, '主图画板5.jpg', '主图画板5.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/2dc06b89-8661-4a72-a7cd-7f85f4545c6e.jpg', '/images/2024/09/07/2dc06b89-8661-4a72-a7cd-7f85f4545c6e.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 18:03:24', '', NULL);
INSERT INTO `sys_oss` VALUES (4, '主图画板 4.jpg', '主图画板 4.jpg', '.jpg', 'http://127.0.0.1:9000/ecerp//images/2024/09/07/3ed00452-5973-4c7e-91ae-5e87aa32dd23.jpg', '/images/2024/09/07/3ed00452-5973-4c7e-91ae-5e87aa32dd23.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 18:03:46', '', NULL);
INSERT INTO `sys_oss` VALUES (5, '主图画板5.jpg', '主图画板5.jpg', '.jpg', 'http://127.0.0.1:9000/ecerp/images/2024/09/07/4b2583ae-65ae-45b6-9227-ebbee99d6558.jpg', '/images/2024/09/07/4b2583ae-65ae-45b6-9227-ebbee99d6558.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 18:04:47', '', NULL);
INSERT INTO `sys_oss` VALUES (6, '主图画板2.jpg', '主图画板2.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/a64ff14b-09d4-42d6-8d52-0344360efdbf.jpg', '/images/2024/09/07/a64ff14b-09d4-42d6-8d52-0344360efdbf.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 19:10:39', '', NULL);
INSERT INTO `sys_oss` VALUES (7, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/af19385d-a1dd-4efb-8257-3099706d1272.jpg', '/images/2024/09/07/af19385d-a1dd-4efb-8257-3099706d1272.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 19:26:36', '', NULL);
INSERT INTO `sys_oss` VALUES (8, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/5aac40e1-ddc1-41a8-a468-28d81e699980.jpg', '/images/2024/09/07/5aac40e1-ddc1-41a8-a468-28d81e699980.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 20:37:14', '', NULL);
INSERT INTO `sys_oss` VALUES (9, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://223.83.100.30:9001/omsimage/images/2024/09/07/b28f4e15-8997-418c-bd32-b4beb4966f6b.jpg', '/images/2024/09/07/b28f4e15-8997-418c-bd32-b4beb4966f6b.jpg', 'omsimage', 0, '0', '0', '', '2024-09-07 20:37:51', '', NULL);
INSERT INTO `sys_oss` VALUES (50, 'x4.jpg', 'x4.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/08/28/x4.jpg', '/images/2024/08/28/x4.jpg', 'ecerp', 0, '0', '0', '', '2024-08-28 22:39:05', '', NULL);
INSERT INTO `sys_oss` VALUES (51, 'x11.jpg', 'x11.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/08/28/x11.jpg', '/images/2024/08/28/x11.jpg', 'ecerp', 0, '0', '0', '', '2024-08-28 22:47:11', '', NULL);
INSERT INTO `sys_oss` VALUES (52, '主图画板 4.jpg', '主图画板 4.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/主图画板 4.jpg', '/images/2024/09/07/主图画板 4.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:31:44', '', NULL);
INSERT INTO `sys_oss` VALUES (53, '主图画板 4.jpg', '主图画板 4.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/主图画板 4.jpg', '/images/2024/09/07/主图画板 4.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:35:41', '', NULL);
INSERT INTO `sys_oss` VALUES (54, '主图画板 1.jpg', '主图画板 1.jpg', '.jpg', 'http://127.0.0.1:9000/images/2024/09/07/f35a3cb8-1b9e-41f4-8158-31d458c7efb3.jpg', '/images/2024/09/07/f35a3cb8-1b9e-41f4-8158-31d458c7efb3.jpg', 'ecerp', 0, '0', '0', '', '2024-09-07 17:36:09', '', NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2023-08-07 19:31:37', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2023-08-07 19:31:37', 'admin', '2025-12-30 02:32:13', '普通角色');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 404);
INSERT INTO `sys_role_menu` VALUES (2, 407);
INSERT INTO `sys_role_menu` VALUES (2, 409);
INSERT INTO `sys_role_menu` VALUES (2, 410);
INSERT INTO `sys_role_menu` VALUES (2, 412);
INSERT INTO `sys_role_menu` VALUES (2, 413);
INSERT INTO `sys_role_menu` VALUES (2, 808);

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task`  (
  `id` int NOT NULL,
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台任务配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
INSERT INTO `sys_task` VALUES (1, '拉取淘宝订单', '-', NULL, '定时更新淘宝订单', 0, '2024-03-07 09:52:40');
INSERT INTO `sys_task` VALUES (2, '拉取京东POP订单', '-', NULL, '拉取京东POP订单', 0, '2024-03-07 09:23:36');
INSERT INTO `sys_task` VALUES (3, '拉取拼多多订单', '0 0/1 * * * ?', NULL, '定时拉取拼多多订单', 1, '2024-04-09 11:24:14');
INSERT INTO `sys_task` VALUES (4, '拉取抖店订单', '-', NULL, '定时拉取抖店订单', 0, '2024-04-09 11:24:54');
INSERT INTO `sys_task` VALUES (5, '拉取天猫退款', '-', NULL, '定时拉取天猫退款', 0, '2024-04-09 11:25:43');
INSERT INTO `sys_task` VALUES (6, '拉取京东售后', '-', NULL, '定时拉取京东售后', 0, '2024-04-09 11:26:26');
INSERT INTO `sys_task` VALUES (7, '拉取拼多多退款', '-', NULL, '定时拉取拼多多退款', 0, '2024-04-09 11:27:01');
INSERT INTO `sys_task` VALUES (8, '拉取抖店退款', '-', NULL, '定时拉取抖店退款', 0, '2024-04-09 11:27:38');
INSERT INTO `sys_task` VALUES (11, '拉取京东自营订单', '-', NULL, '拉取京东自营订单', 0, '2024-05-27 10:57:44');
INSERT INTO `sys_task` VALUES (12, '拉取京东自营退货', '-', NULL, '拉取京东自营退货', 0, NULL);
INSERT INTO `sys_task` VALUES (21, '推送待发货订单到ERP', '-', NULL, '推送待发货订单到ERP', 0, '2024-04-22 15:48:48');
INSERT INTO `sys_task` VALUES (22, '推送待处理售后到ERP', '-', NULL, '推送待处理售后到ERP', 0, '2024-04-22 15:48:48');
INSERT INTO `sys_task` VALUES (23, '推送已取消的订单到ERP', '-', NULL, '推送已取消的订单到ERP', 0, '2024-05-29 17:57:02');

-- ----------------------------
-- Table structure for sys_task_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_task_logs`;
CREATE TABLE `sys_task_logs`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `task_id` int NULL DEFAULT NULL COMMENT '任务ID',
  `result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结果',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始运行时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `status` int NULL DEFAULT NULL COMMENT '状态1运行中，2已结束',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台任务运行日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_task_logs
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, NULL, 'admin', '启航老齐A', '00', '280645618@qq.com', '18123879144', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-01-14 08:51:17', 'admin', '2023-08-07 19:31:37', '', '2026-01-14 00:51:16', '管理员');
INSERT INTO `sys_user` VALUES (2, NULL, 'openapi', 'openApi接口专用', '00', '2806456181@qq.com', '15818590000', '0', '', '$2a$10$fHkhoqbMiyracAsTzl38H.55bu.M.of1FXk2EK7RQBjfic3tLU0Ue', '0', '0', '127.0.0.1', '2024-06-24 10:23:35', 'admin', '2024-03-17 14:55:22', 'admin', '2024-06-24 10:23:35', NULL);
INSERT INTO `sys_user` VALUES (101, 101, '15818590119', 'aaa123', '00', '', '', '0', '', '$2a$10$pXcT6cHaObMeKuYd9vZb5uEb8PyUdF2AcqqRN1cBqiA9rV4qYQW7G', '0', '2', '', NULL, 'admin', '2024-08-15 13:45:25', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (102, 101, '15818590119', '老齐', '00', '', '', '0', '', '$2a$10$ysk.zgJ8wh25c7vOjKyZ8uarM2hkG0S51j8GYdJSo2kZmc3f8HdKe', '0', '0', '', NULL, 'admin', '2024-08-15 13:49:59', 'admin', '2025-02-10 16:26:20', NULL);
INSERT INTO `sys_user` VALUES (103, 100, '18025303180', '老方', '00', '', '', '0', '', '$2a$10$QnLM3NluG5q1xpmWep0QUOFfvNrd02hwenL4HkV0uhMbm4cEX1uIG', '0', '0', '', NULL, 'admin', '2024-09-21 17:17:56', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (102, 2);
INSERT INTO `sys_user_role` VALUES (103, 2);

SET FOREIGN_KEY_CHECKS = 1;
