class User {
  Userinfo userinfo;
  Withdrawaccount withdrawaccount;
  int id;
  Vipuserinfo vipuserinfo;

  User({this.userinfo, this.withdrawaccount, this.id, this.vipuserinfo});

  User.fromJson(Map<String, dynamic> json) {
    userinfo = json['userinfo'] != null
        ? new Userinfo.fromJson(json['userinfo'])
        : null;
    withdrawaccount = json['withdrawaccount'] != null
        ? new Withdrawaccount.fromJson(json['withdrawaccount'])
        : null;
    id = json['id'];
    vipuserinfo = json['vipuserinfo'] != null
        ? new Vipuserinfo.fromJson(json['vipuserinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userinfo != null) {
      data['userinfo'] = this.userinfo.toJson();
    }
    if (this.withdrawaccount != null) {
      data['withdrawaccount'] = this.withdrawaccount.toJson();
    }
    data['id'] = this.id;
    if (this.vipuserinfo != null) {
      data['vipuserinfo'] = this.vipuserinfo.toJson();
    }
    return data;
  }
}

class Userinfo {
  int id;
  String money;
  String phone;
  String nickName;
  String headImg;
  String date;
  String updateDate;
  int user;

  Userinfo(
      {this.id,
      this.money,
      this.phone,
      this.nickName,
      this.headImg,
      this.date,
      this.updateDate,
      this.user});

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    money = json['money'];
    phone = json['phone'];
    nickName = json['nick_name'];
    headImg = json['head_img'];
    date = json['date'];
    updateDate = json['update_date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['money'] = this.money;
    data['phone'] = this.phone;
    data['nick_name'] = this.nickName;
    data['head_img'] = this.headImg;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['user'] = this.user;
    return data;
  }
}

class Withdrawaccount {
  int id;
  String alyPayAccount;
  String weixinPayAccount;
  String date;
  String updateDate;
  int user;

  Withdrawaccount(
      {this.id,
      this.alyPayAccount,
      this.weixinPayAccount,
      this.date,
      this.updateDate,
      this.user});

  Withdrawaccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alyPayAccount = json['aly_pay_account'];
    weixinPayAccount = json['weixin_pay_account'];
    date = json['date'];
    updateDate = json['update_date'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['aly_pay_account'] = this.alyPayAccount;
    data['weixin_pay_account'] = this.weixinPayAccount;
    data['date'] = this.date;
    data['update_date'] = this.updateDate;
    data['user'] = this.user;
    return data;
  }
}

class Vipuserinfo {
  int id;
  bool isOpening;
  bool isAnnual;
  String startTime;
  String endTime;
  int user;

  Vipuserinfo(
      {this.id,
      this.isOpening,
      this.isAnnual,
      this.startTime,
      this.endTime,
      this.user});

  Vipuserinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isOpening = json['is_opening'];
    isAnnual = json['is_annual'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_opening'] = this.isOpening;
    data['is_annual'] = this.isAnnual;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['user'] = this.user;
    return data;
  }
}
