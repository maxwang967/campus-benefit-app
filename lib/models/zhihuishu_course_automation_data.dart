class ZhihuishuCourseAutomationDataList {
  List<ZhihuishuCourseAutomationData> data;

  ZhihuishuCourseAutomationDataList({this.data});

  ZhihuishuCourseAutomationDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ZhihuishuCourseAutomationData>();
      json['data'].forEach((v) {
        data.add(new ZhihuishuCourseAutomationData.fromJson(v));
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

class ZhihuishuCourseAutomationData {
  int id;
  String name;
  String detailName;
  String img;
  int status;
  String courseId;
  String recruitId;
  var currentCourseProgress;
  var aveCourseProgress;
  String date;
  String secret;
  int user;

  ZhihuishuCourseAutomationData(
      {this.id,
      this.name,
      this.detailName,
      this.img,
      this.status,
      this.courseId,
      this.recruitId,
      this.currentCourseProgress,
      this.aveCourseProgress,
      this.date,
      this.secret,
      this.user});

  ZhihuishuCourseAutomationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detailName = json['detail_name'];
    img = json['img'];
    status = json['status'];
    courseId = json['courseId'];
    recruitId = json['recruitId'];
    currentCourseProgress = json['current_course_progress'];
    aveCourseProgress = json['ave_course_progress'];
    date = json['date'];
    secret = json['secret'];
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
    data['recruitId'] = this.recruitId;
    data['current_course_progress'] = this.currentCourseProgress;
    data['ave_course_progress'] = this.aveCourseProgress;
    data['date'] = this.date;
    data['secret'] = this.secret;
    data['user'] = this.user;
    return data;
  }
}
