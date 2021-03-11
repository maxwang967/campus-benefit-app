class GoodDataList {
  int status;
  String message;
  List<GoodData> data;

  GoodDataList({this.status, this.message, this.data});

  GoodDataList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<GoodData>();
      json['data'].forEach((v) {
        data.add(new GoodData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoodData {
  int gid;
  int cid;
  String name;
  String image;
  int modelId;
  int close;
  double originalPrice;
  double currentPrice;
  double substationPrice;
  GoodData({this.gid, this.cid, this.name, this.image, this.modelId, this.close, this.originalPrice, this.currentPrice, this.substationPrice});

  GoodData.fromJson(Map<String, dynamic> json) {
    gid = json['gid'];
    cid = json['cid'];
    name = json['name'];
    image = json['image'];
    modelId = json['model_id'];
    close = json['close'];
    originalPrice = json['original_price'];
    currentPrice = json['current_price'];
    substationPrice = json['substation_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this.gid;
    data['cid'] = this.cid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['model_id'] = this.modelId;
    data['close'] = this.close;
    data['original_price'] = this.originalPrice;
    data['current_price'] = this.currentPrice;
    data['substation_price'] = this.substationPrice;
    return data;
  }
}