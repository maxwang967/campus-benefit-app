class EarnDataList {
  EarnDataInfo data;

  EarnDataList({this.data});

  EarnDataList.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new EarnDataInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class EarnDataInfo {
  double income;
  List<EarnDataInfoDetail> data;

  EarnDataInfo({this.income, this.data});

  EarnDataInfo.fromJson(Map<String, dynamic> json) {
    income = json['income'];
    if (json['data'] != null) {
      data = new List<EarnDataInfoDetail>();
      json['data'].forEach((v) {
        data.add(new EarnDataInfoDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['income'] = this.income;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class EarnDataInfoDetail {
  int id;
  String childUser;
  String date;
  String incident;
  double fineritCode;

  EarnDataInfoDetail({this.id, this.childUser, this.date, this.incident, this.fineritCode});

  EarnDataInfoDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childUser = json['child_user'];
    date = json['date'];
    incident = json['incident'];
    fineritCode = json['finer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_user'] = this.childUser;
    data['date'] = this.date;
    data['incident'] = this.incident;
    data['finer_code'] = this.fineritCode;
    return data;
  }
}