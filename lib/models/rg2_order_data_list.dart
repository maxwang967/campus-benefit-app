class RG2OrderDataList {
  List<RG2OrderData> data;

  RG2OrderDataList({this.data});

  RG2OrderDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RG2OrderData>();
      json['data'].forEach((v) {
        data.add(new RG2OrderData.fromJson(v));
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

class RG2OrderData {
  String school;
  String schoolid;
  String sname;
  String account;
  String password;
  String comment;
  String id;
  String customerid;
  String studentid;
  String classid;
  String courseid;
  String name;
  String total;
  String daixiu;
  String complete;
  String amount;
  String tradeid;
  String status;
  String tasklist;
  String examScore;
  String examStatus;
  String courseStartTime;
  String courseEndTime;
  String examStartTime;
  String examEndTime;
  String createTime;
  String updateTime;
  String orderTime;
  String payTime;
  String completeTime;
  String platform;
  String display;

  RG2OrderData(
      {this.school,
      this.schoolid,
      this.sname,
      this.account,
      this.password,
      this.comment,
      this.id,
      this.customerid,
      this.studentid,
      this.classid,
      this.courseid,
      this.name,
      this.total,
      this.daixiu,
      this.complete,
      this.amount,
      this.tradeid,
      this.status,
      this.tasklist,
      this.examScore,
      this.examStatus,
      this.courseStartTime,
      this.courseEndTime,
      this.examStartTime,
      this.examEndTime,
      this.createTime,
      this.updateTime,
      this.orderTime,
      this.payTime,
      this.completeTime,
      this.platform,
      this.display});

  RG2OrderData.fromJson(Map<String, dynamic> json) {
    school = json['school'];
    schoolid = json['schoolid'];
    sname = json['sname'];
    account = json['account'];
    password = json['password'];
    comment = json['comment'];
    id = json['id'];
    customerid = json['customerid'];
    studentid = json['studentid'];
    classid = json['classid'];
    courseid = json['courseid'];
    name = json['name'];
    total = json['total'];
    daixiu = json['daixiu'];
    complete = json['complete'];
    amount = json['amount'];
    tradeid = json['tradeid'];
    status = json['status'];
    tasklist = json['tasklist'];
    examScore = json['exam_score'];
    examStatus = json['exam_status'];
    courseStartTime = json['course_start_time'];
    courseEndTime = json['course_end_time'];
    examStartTime = json['exam_start_time'];
    examEndTime = json['exam_end_time'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    orderTime = json['order_time'];
    payTime = json['pay_time'];
    completeTime = json['complete_time'];
    platform = json['platform'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['school'] = this.school;
    data['schoolid'] = this.schoolid;
    data['sname'] = this.sname;
    data['account'] = this.account;
    data['password'] = this.password;
    data['comment'] = this.comment;
    data['id'] = this.id;
    data['customerid'] = this.customerid;
    data['studentid'] = this.studentid;
    data['classid'] = this.classid;
    data['courseid'] = this.courseid;
    data['name'] = this.name;
    data['total'] = this.total;
    data['daixiu'] = this.daixiu;
    data['complete'] = this.complete;
    data['amount'] = this.amount;
    data['tradeid'] = this.tradeid;
    data['status'] = this.status;
    data['tasklist'] = this.tasklist;
    data['exam_score'] = this.examScore;
    data['exam_status'] = this.examStatus;
    data['course_start_time'] = this.courseStartTime;
    data['course_end_time'] = this.courseEndTime;
    data['exam_start_time'] = this.examStartTime;
    data['exam_end_time'] = this.examEndTime;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['order_time'] = this.orderTime;
    data['pay_time'] = this.payTime;
    data['complete_time'] = this.completeTime;
    data['platform'] = this.platform;
    data['display'] = this.display;
    return data;
  }
}
