class EryaCourseAutomationDataList {
  List<EryaCourseAutomationData> data;

  EryaCourseAutomationDataList({this.data});

  EryaCourseAutomationDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<EryaCourseAutomationData>();
      json['data'].forEach((v) {
        data.add(new EryaCourseAutomationData.fromJson(v));
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

class EryaCourseAutomationData {
  int id;
  String name;
  String detailName;
  String img;
  int status;
  String courseId;
  String clazzid;
  String enc;
  String cpi;
  String date;
  int user;

  EryaCourseAutomationData(
      {this.id,
      this.name,
      this.detailName,
      this.img,
      this.status,
      this.courseId,
      this.clazzid,
      this.enc,
      this.cpi,
      this.date,
      this.user});

  EryaCourseAutomationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detailName = json['detail_name'];
    img = json['img'];
    status = json['status'];
    courseId = json['courseId'];
    clazzid = json['clazzid'];
    enc = json['enc'];
    cpi = json['cpi'];
    date = json['date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['detail_name'] = this.detailName;
    data['img'] = this.img;
    data['status'] = this.status;
    data['courseId'] = this.courseId;
    data['clazzid'] = this.clazzid;
    data['enc'] = this.enc;
    data['cpi'] = this.cpi;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}
