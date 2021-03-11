class ZhihuishuOrderDataList {
  List<ZhihuishuOrderData> data;

  ZhihuishuOrderDataList({this.data});

  ZhihuishuOrderDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ZhihuishuOrderData>();
      json['data'].forEach((v) {
        data.add(new ZhihuishuOrderData.fromJson(v));
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

class ZhihuishuOrderData {
  int id;
  String achive;
  Course course;
  User user;
  String updateTime;
  String addTime;
  int baseUser;

  ZhihuishuOrderData(
      {this.id,
      this.achive,
      this.course,
      this.user,
      this.updateTime,
      this.addTime,
      this.baseUser});

  ZhihuishuOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    achive = json['achive'];
    course =
        json['course'] != null ? new Course.fromJson(json['course']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    updateTime = json['update_time'];
    addTime = json['add_time'];
    baseUser = json['base_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['achive'] = this.achive;
    if (this.course != null) {
      data['course'] = this.course.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['update_time'] = this.updateTime;
    data['add_time'] = this.addTime;
    data['base_user'] = this.baseUser;
    return data;
  }
}

class Course {
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

  Course(
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

  Course.fromJson(Map<String, dynamic> json) {
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

class User {
  int id;
  String name;
  String img;
  String schoolName;
  int schoolCode;
  String stuNum;
  String passwordStunum;
  String phonenum;
  String passwordPhonenum;
  String uuid;
  var schoolId;
  String date;
  List<int> user;

  User(
      {this.id,
      this.name,
      this.img,
      this.schoolName,
      this.schoolCode,
      this.stuNum,
      this.passwordStunum,
      this.phonenum,
      this.passwordPhonenum,
      this.uuid,
      this.schoolId,
      this.date,
      this.user});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    schoolName = json['school_name'];
    schoolCode = json['school_code'];
    stuNum = json['stu_num'];
    passwordStunum = json['password_stunum'];
    phonenum = json['phonenum'];
    passwordPhonenum = json['password_phonenum'];
    uuid = json['uuid'];
    schoolId = json['school_id'];
    date = json['date'];
    user = json['user'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['school_name'] = this.schoolName;
    data['school_code'] = this.schoolCode;
    data['stu_num'] = this.stuNum;
    data['password_stunum'] = this.passwordStunum;
    data['phonenum'] = this.phonenum;
    data['password_phonenum'] = this.passwordPhonenum;
    data['uuid'] = this.uuid;
    data['school_id'] = this.schoolId;
    data['date'] = this.date;
    data['user'] = this.user;
    return data;
  }
}
