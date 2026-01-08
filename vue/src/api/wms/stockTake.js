import request from '@/utils/request'

// 列表
export function listStockTake(query) {
  return request({
    url: '/erp-api/stockTake/list',
    method: 'get',
    params: query
  })
}

// 详细
export function getStockTakeEntry(id) {
  return request({
    url: '/erp-api/stockTake/' + id,
    method: 'get'
  })
}

// 新增
export function stockTakeCreate(data) {
  return request({
    url: '/erp-api/stockTake/create',
    method: 'post',
    data: data
  })
}
export function stockTakeItem(data) {
  return request({
    url: '/erp-api/stockTake/addItem',
    method: 'post',
    data: data
  })
}
export function stockTakeComplete(id) {
  return request({
    url: '/erp-api/stockTake/complete/' + id,
    method: 'post'
  })
}
