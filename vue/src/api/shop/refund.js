import request from '@/utils/request'

// 查询退款列表
export function pullRefund(data) {
  return request({
    url: '/shop/refund/pull_list',
    method: 'post',
    data: data
  })
}
