import request from '@/utils/request'

// 查询财务流水列表
export function list(params) {
  return request({
    url: '/api/erp-api/finance/flow/list',
    method: 'get',
    params: params
  })
}

// 添加财务流水
export function add(data) {
  return request({
    url: '/api/erp-api/finance/flow/add',
    method: 'post',
    data: data
  })
}

// 作废财务流水
export function voidFlow(data) {
  return request({
    url: '/api/erp-api/finance/flow/void',
    method: 'post',
    data: data
  })
}
