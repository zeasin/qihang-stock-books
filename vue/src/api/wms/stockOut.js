import request from '@/utils/request'

// 查询出库单列表
export function listStockOut(query) {
  return request({
    url: '/erp-api/stockOut/list',
    method: 'get',
    params: query
  })
}

// 查询出库单详细
export function getStockOutEntry(id) {
  return request({
    url: '/erp-api/stockOut/' + id,
    method: 'get'
  })
}

export function getStockOutItem(query) {
  return request({
    url: '/erp-api/stockOut/item_list',
    method: 'get',
    params: query
  })
}

export function getStockOutItemDetail(id) {
  return request({
    url: '/erp-api/stockOut/item/'+id,
    method: 'get'
  })
}


// 出库
export function stockOut(data) {
  return request({
    url: '/erp-api/stockOut/out',
    method: 'post',
    data: data
  })
}

// 查询入库单列表
export function listStockOutDetail(query) {
  return request({
    url: '/erp-api/stockOut/detail_list',
    method: 'get',
    params: query
  })
}
