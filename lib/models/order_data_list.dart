class OrderDataList {
  List<OrderData> data;

  OrderDataList({this.data});

  OrderDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<OrderData>();
      json['data'].forEach((v) {
        data.add(new OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class OrderData {
  int id;
  String orderId;
  String date;
  int gid;
  int cid;
  int modelId;
  String image;
  String name;
  double price;
  int num;
  var user;

  OrderData(
      {this.id,
        this.orderId,
        this.date,
        this.gid,
        this.cid,
        this.modelId,
        this.image,
        this.name,
        this.price,
        this.num,
        this.user});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    date = json['date'];
    gid = json['gid'];
    cid = json['cid'];
    modelId = json['model_id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    num = json['num'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['date'] = this.date;
    data['gid'] = this.gid;
    data['cid'] = this.cid;
    data['model_id'] = this.modelId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['num'] = this.num;
    data['user'] = this.user;
    return data;
  }
}