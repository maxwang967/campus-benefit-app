class ZhihuishuEryaUser {
  String zhihuishuUsername;
  String zhihuishuPassword;
  String zhihuishuSchool;
  String eryaUsername;
  String eryaPassword;
  String eryaSchool;

  ZhihuishuEryaUser(
      {this.zhihuishuUsername,
      this.zhihuishuPassword,
      this.zhihuishuSchool,
      this.eryaUsername,
      this.eryaPassword,
      this.eryaSchool});

  ZhihuishuEryaUser.fromJson(Map<String, dynamic> json) {
    zhihuishuUsername = json['zhihuishu_username'];
    zhihuishuPassword = json['zhihuishu_password'];
    zhihuishuSchool = json['zhihuishu_school'];
    eryaUsername = json['erya_username'];
    eryaPassword = json['erya_password'];
    eryaSchool = json['erya_school'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zhihuishu_username'] = this.zhihuishuUsername;
    data['zhihuishu_password'] = this.zhihuishuPassword;
    data['zhihuishu_school'] = this.zhihuishuSchool;
    data['erya_username'] = this.eryaUsername;
    data['erya_password'] = this.eryaPassword;
    data['erya_school'] = this.eryaSchool;
    return data;
  }
}
