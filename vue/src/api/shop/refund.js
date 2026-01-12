import request from '@/utils/request'

// 拉取退款列表
export function pullRefund(data) {
  return request({
    url: '/shop/refund/pull_list',
    method: 'post',
    data: data
  })
}

export function pullRefundUpdate(data) {
  return request({
    url: '/shop/refund/pull_detail',
    method: 'post',
    data: data
  })
}

