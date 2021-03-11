class PayCreateOrder {
  int id;
  String payTime;
  String date;
  String payStatus;
  Null tradeNo;
  String orderMount;
  String orderNo;
  double fineritCode;

  PayCreateOrder(
      {this.id,
        this.payTime,
        this.date,
        this.payStatus,
        this.tradeNo,
        this.orderMount,
        this.orderNo,
        this.fineritCode});

  PayCreateOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payTime = json['pay_time'];
    date = json['date'];
    payStatus = json['pay_status'];
    tradeNo = json['trade_no'];
    orderMount = json['order_mount'];
    orderNo = json['order_no'];
    fineritCode = json['finer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pay_time'] = this.payTime;
    data['date'] = this.date;
    data['pay_status'] = this.payStatus;
    data['trade_no'] = this.tradeNo;
    data['order_mount'] = this.orderMount;
    data['order_no'] = this.orderNo;
    data['finer_code'] = this.fineritCode;
    return data;
  }
}

class PayReadOrder {
  int id;
  String alipayUrl;
  String alipayWebUrl;
  String orderNo;
  String tradeNo;
  String payStatus;
  double orderMount;
  double fineritCode;
  String payTime;
  String date;
  int user;

  PayReadOrder(
      {this.id,
        this.alipayUrl,
        this.alipayWebUrl,
        this.orderNo,
        this.tradeNo,
        this.payStatus,
        this.orderMount,
        this.fineritCode,
        this.payTime,
        this.date,
        this.user});

  PayReadOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alipayUrl = json['alipay_url'];
    alipayWebUrl = json['alipay_web_url'];
    orderNo = json['order_no'];
    tradeNo = json['trade_no'];
    payStatus = json['pay_status'];
    orderMount = json['order_mount'];
    fineritCode = json['finer_code'];
    payTime = json['pay_time'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alipay_url'] = this.alipayUrl;
    data['alipay_web_url'] = this.alipayWebUrl;
    data['order_no'] = this.orderNo;
    data['trade_no'] = this.tradeNo;
    data['pay_status'] = this.payStatus;
    data['order_mount'] = this.orderMount;
    data['finer_code'] = this.fineritCode;
    data['pay_time'] = this.payTime;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}
