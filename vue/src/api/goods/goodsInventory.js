import request from '@/utils/request'

// 查询商品库存列表
export function listGoodsInventory(query) {
  return request({
    url: '/goodsInventory/list',
    method: 'get',
    params: query
  })
}

// 查询商品库存详细
export function getGoodsInventory(id) {
  return request({
    url: '/goodsInventory/' + id,
    method: 'get'
  })
}


// 查询商品规格列表
export function searchSkuAndStock(query) {
  return request({
    url: '/goodsInventory/goods_sku_stock_search',
    method: 'get',
    params: query
  })
}
