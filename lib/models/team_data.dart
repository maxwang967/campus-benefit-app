import 'package:campus_benefit_app/models/user.dart';

class TeamFather {
  int firstNum;
  int monthAddNum;
  int monthPayNum;

  TeamFather({this.firstNum, this.monthAddNum, this.monthPayNum});

  TeamFather.fromJson(Map<String, dynamic> json) {
    firstNum = json['first_num'];
    monthAddNum = json['month_add_num'];
    monthPayNum = json['month_pay_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_num'] = this.firstNum;
    data['month_add_num'] = this.monthAddNum;
    data['month_pay_num'] = this.monthPayNum;
    return data;
  }
}


class TeamInviteList {
  List<TeamInvite> data;

  TeamInviteList({this.data});

  TeamInviteList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TeamInvite>();
      json['data'].forEach((v) {
        data.add(new TeamInvite.fromJson(v));
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

class TeamInvite {
  User invite;

  TeamInvite({this.invite});

  TeamInvite.fromJson(Map<String, dynamic> json) {
    invite =
    json['invite'] != null ? new User.fromJson(json['invite']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invite != null) {
      data['invite'] = this.invite.toJson();
    }
    return data;
  }
}

class UserData {
  User user;

  UserData({this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}