import 'package:campus_benefit_app/models/user.dart';

class RantingData {
  int id;
  User user;
  var sum;
  String date;

  RantingData({this.id, this.user, this.sum, this.date});

  RantingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    sum = json['sum'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['sum'] = this.sum;
    data['date'] = this.date;
    return data;
  }
}
