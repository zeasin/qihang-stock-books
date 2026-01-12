package cn.qihangerp.common.enums;

/**
 * 描述：
 * 京东订单状态
 *
 * @author qlp
 * @date 2019-09-18 19:44
 */
public enum PddRefundStatusEnum {
    //售后状态 0：无售后 2：买家申请退款，待商家处理 3：退货退款，待商家处理 4：商家同意退款，退款中 5：平台同意退款，退款中
    // 6：驳回退款，待买家处理 7：已同意退货退款,待用户发货 8：平台处理中 9：平台拒绝退款，退款关闭 10：退款成功
    // 11：买家撤销 12：买家逾期未处理，退款失败 13：买家逾期，超过有效期 14：换货补寄待商家处理 15：换货补寄待用户处理
    // 16：换货补寄成功 17：换货补寄失败 18：换货补寄待用户确认完成 21：待商家同意维修 22：待用户确认发货 24：维修关闭
    // 25：维修成功 27：待用户确认收货 31：已同意拒收退款，待用户拒收 32：补寄待商家发货
    S2("买家申请退款，待商家处理",2),
    S3("退货退款，待商家处理", 3),
    S4("商家同意退款，退款中",4),
    S5("平台同意退款，退款中",5),
    S6("驳回退款，待买家处理",6),
    S7("已同意退货退款,待用户发货",7),
    S8("平台处理中",8),
    S9("平台拒绝退款，退款关闭",9),
    S10("退款成功",10),
    S11("买家撤销",11),
    S12("买家逾期未处理，退款失败",12),
    S13("买家逾期，超过有效期",13),
    S14("换货补寄待商家处理",14),
    S15("换货补寄待用户处理",15),
    S16("换货补寄成功",16),
    S17("换货补寄失败",17),
    S18("换货补寄待用户确认完成",18),
    S21("待商家同意维修",21),
    S22("待用户确认发货",22),
    S24("维修关闭",24),
    S25("维修成功",25),
    S27("待用户确认收货",27),
    S31("已同意拒收退款，待用户拒收",31),
    S32("补寄待商家发货",32),
    NOT ("无售后",0);
    private String name;
    private int code;


    // 构造方法
    private PddRefundStatusEnum(String name, int code) {
        this.name = name;
        this.code = code;
    }

    // 普通方法
    public static String getName(int code) {
        for (PddRefundStatusEnum c : PddRefundStatusEnum.values()) {
            if (c.getCode() == code) {
                return c.name;
            }
        }
        return null;
    }

    // get set 方法
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }


}
