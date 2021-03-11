class CourseRG1DataList {
  String msg;
  int code;
  List<CourseRG1Data> data;

  CourseRG1DataList({this.msg, this.code, this.data});

  CourseRG1DataList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<CourseRG1Data>();
      json['data'].forEach((v) {
        data.add(new CourseRG1Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseRG1Data {
  String id;
  String pId;
  String name;
  String title;
  bool checked;
  bool open;
  bool nocheck;
  List<CourseRg1DataChildren> children;

  CourseRG1Data(
      {this.id,
      this.pId,
      this.name,
      this.title,
      this.checked,
      this.open,
      this.nocheck,
      this.children});

  CourseRG1Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pId = json['pId'];
    name = json['name'];
    title = json['title'];
    checked = json['checked'];
    open = json['open'];
    nocheck = json['nocheck'];
    if (json['children'] != null) {
      children = new List<CourseRg1DataChildren>();
      json['children'].forEach((v) {
        children.add(new CourseRg1DataChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pId'] = this.pId;
    data['name'] = this.name;
    data['title'] = this.title;
    data['checked'] = this.checked;
    data['open'] = this.open;
    data['nocheck'] = this.nocheck;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseRg1DataChildren {
  String id;
  String pId;
  String name;
  String title;
  bool checked;
  bool open;
  bool nocheck;

  CourseRg1DataChildren(
      {this.id,
      this.pId,
      this.name,
      this.title,
      this.checked,
      this.open,
      this.nocheck});

  CourseRg1DataChildren.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pId = json['pId'];
    name = json['name'];
    title = json['title'];
    checked = json['checked'];
    open = json['open'];
    nocheck = json['nocheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pId'] = this.pId;
    data['name'] = this.name;
    data['title'] = this.title;
    data['checked'] = this.checked;
    data['open'] = this.open;
    data['nocheck'] = this.nocheck;
    return data;
  }
}
