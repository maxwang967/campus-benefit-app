class ZhihuishuOrderDetailDataList {
  List<ZhihuishuOrderDetailData> data;

  ZhihuishuOrderDetailDataList({this.data});

  ZhihuishuOrderDetailDataList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ZhihuishuOrderDetailData>();
      json['data'].forEach((v) {
        data.add(new ZhihuishuOrderDetailData.fromJson(v));
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

class ZhihuishuOrderDetailData {
  int id;
  String status;
  Task task;
  String updateTime;
  String addTime;
  String currentInfo;
  int userTask;

  ZhihuishuOrderDetailData(
      {this.id,
      this.status,
      this.task,
      this.updateTime,
      this.addTime,
      this.currentInfo,
      this.userTask});

  ZhihuishuOrderDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    task = json['task'] != null ? new Task.fromJson(json['task']) : null;
    updateTime = json['update_time'];
    addTime = json['add_time'];
    currentInfo = json['current_info'];
    userTask = json['user_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    if (this.task != null) {
      data['task'] = this.task.toJson();
    }
    data['update_time'] = this.updateTime;
    data['add_time'] = this.addTime;
    data['current_info'] = this.currentInfo;
    data['user_task'] = this.userTask;
    return data;
  }
}

class Task {
  int id;
  String name;
  String updateTime;
  String addTime;

  Task({this.id, this.name, this.updateTime, this.addTime});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    updateTime = json['update_time'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['update_time'] = this.updateTime;
    data['add_time'] = this.addTime;
    return data;
  }
}
