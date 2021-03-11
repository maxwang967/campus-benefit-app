class GoodDetailData {
  int status;
  String message;
  GoodDetail data;

  GoodDetailData({this.status, this.message, this.data});

  GoodDetailData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GoodDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}



class GoodDetail {
  int gid;
  int cid;
  int modelId;
  String name;
  List<String> desc;
  String image;
  List<List> inputs;
  double price;
  int limitMin;
  int limitMax;
  int rate;
  int close;
  List<String> allowGm;
  List<String> allowBd;
  List<String> allowTd;

  GoodDetail(
      {this.gid,
        this.cid,
        this.modelId,
        this.name,
        this.desc,
        this.image,
        this.inputs,
        this.price,
        this.limitMin,
        this.limitMax,
        this.rate,
        this.close,
        this.allowGm,
        this.allowBd,
        this.allowTd});

  GoodDetail.fromJson(Map<String, dynamic> json) {
    gid = json['gid'];
    cid = json['cid'];
    modelId = json['model_id'];
    name = json['name'];
    desc = json['desc'].cast<String>();
    image = json['image'];
    if (json['inputs'] != null) {
      inputs = new List<List>();
      json['inputs'].forEach((v) {
        inputs.add(v.cast<String>());
      });
    }
    price = json['price'];
    limitMin = json['limit_min'];
    limitMax = json['limit_max'];
    rate = json['rate'];
    close = json['close'];
    allowGm = json['allow_gm'].cast<String>();
    allowBd = json['allow_bd'].cast<String>();
    allowTd = json['allow_td'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gid'] = this.gid;
    data['cid'] = this.cid;
    data['model_id'] = this.modelId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['inputs']=this.inputs;
    data['price'] = this.price;
    data['limit_min'] = this.limitMin;
    data['limit_max'] = this.limitMax;
    data['rate'] = this.rate;
    data['close'] = this.close;
    data['allow_gm'] = this.allowGm;
    data['allow_bd'] = this.allowBd;
    data['allow_td'] = this.allowTd;
    return data;
  }
}