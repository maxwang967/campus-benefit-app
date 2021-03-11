class EryaOrderDataList {
  List<EryaOrderData> data;

  EryaOrderDataList({this.data});

  EryaOrderDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<EryaOrderData>();
      json['data'].forEach((v) {
        data.add(new EryaOrderData.fromJson(v));
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

class EryaOrderData {
  int id;
  String achive;
  Course course;
  User user;
  String updateTime;
  String addTime;
  int baseUser;

  EryaOrderData(
      {this.id,
      this.achive,
      this.course,
      this.user,
      this.updateTime,
      this.addTime,
      this.baseUser});

  EryaOrderData.fromJson(Map<String, dynamic> json) {
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
  String clazzid;
  String enc;
  String cpi;
  String date;
  int user;

  Course(
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

  Course.fromJson(Map<String, dynamic> json) {
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

class User {
  int id;
  String school;
  String name;
  String img;
  String phonenum;
  String email;
  String password;
  String date;
  String code;
  String stuNum;
  String password2;
  List<int> user;

  User(
      {this.id,
      this.school,
      this.name,
      this.img,
      this.phonenum,
      this.email,
      this.password,
      this.date,
      this.code,
      this.stuNum,
      this.password2,
      this.user});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    school = json['school'];
    name = json['name'];
    img = json['img'];
    phonenum = json['phonenum'];
    email = json['email'];
    password = json['password'];
    date = json['date'];
    code = json['code'];
    stuNum = json['stu_num'];
    password2 = json['password2'];
    user = json['user'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school'] = this.school;
    data['name'] = this.name;
    data['img'] = this.img;
    data['phonenum'] = this.phonenum;
    data['email'] = this.email;
    data['password'] = this.password;
    data['date'] = this.date;
    data['code'] = this.code;
    data['stu_num'] = this.stuNum;
    data['password2'] = this.password2;
    data['user'] = this.user;
    return data;
  }
}

