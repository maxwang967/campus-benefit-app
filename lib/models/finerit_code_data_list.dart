class FineirtCodeInfoList {
  FineirtCodeInfo data;

  FineirtCodeInfoList({this.data});

  FineirtCodeInfoList.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new FineirtCodeInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class FineirtCodeInfo {
  double outcome;
  double income;
  List<FineirtCodeInfoDetail> data;

  FineirtCodeInfo({this.outcome, this.income, this.data});

  FineirtCodeInfo.fromJson(Map<String, dynamic> json) {
    outcome = json['outcome'];
    income = json['income'];
    if (json['data'] != null) {
      data = new List<FineirtCodeInfoDetail>();
      json['data'].forEach((v) {
        data.add(new FineirtCodeInfoDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outcome'] = this.outcome;
    data['income'] = this.income;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FineirtCodeInfoDetail {
  int id;
  String fineritCode;
  String incident;
  String operate;
  String date;
  int user;

  FineirtCodeInfoDetail(
      {this.id,
        this.fineritCode,
        this.incident,
        this.operate,
        this.date,
        this.user});

  FineirtCodeInfoDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fineritCode = json['finer_code'];
    incident = json['incident'];
    operate = json['operate'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['finer_code'] = this.fineritCode;
    data['incident'] = this.incident;
    data['operate'] = this.operate;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}
