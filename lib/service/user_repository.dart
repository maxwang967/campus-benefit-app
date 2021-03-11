
import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/nets/http.dart';
import 'package:campus_benefit_app/models/earn_sum_data.dart';
import 'package:campus_benefit_app/models/short_url.dart';
import 'package:campus_benefit_app/models/team_data.dart';
import 'package:campus_benefit_app/models/user.dart';

class UserRepository {
  static Future loginUsernamePassword(String username, String password) async {
    var response =
        await http.post('login/', data: {
          "username": username,
          "password": password
        });
    return response.data.data["token"];
  }

  static Future changePassword(int id, String password, String code) async {
    var response =
    await http.netFetch('users/$id/', params: {
      "code": code,
      "password": password
    }, method: 'put');
    return response.data;
  }

  static Future register(String username, String password, String code) async {

    Map<String, dynamic> data = {
      "code": code,
      "username": username,
      "password": password
    };

    String fatherId = StorageManager.sharedPreferences.getString(Config.FATHER_KEY);
    if (fatherId != null) {
      data["father"] = fatherId;
    }
    var response =
    await http.netFetch('users/', params: data, method: 'post');
    return response.data;
  }

  static Future loginUsernameCode(String username, String code) async {
    var response =
        await http.get('login_with_code/', queryParameters: {
          "username": username,
          "code": code
        });
    return response.data.data["token"];
  }

  static Future getUserInfo(String username) async {
    var response = await http.get('users/$username/');
    return User.fromJson(response.data.data);
  }

  static Future getCode(String username) async {
    var response = await http.post('codes/', data: {"mobile": username});
    return response.data.data;
  }

    static Future getUserEarnSumData() async {
    var response = await http.get('earnsum/');
    return EarnSumData.fromJson(response.data.data);
  }

    static Future getFatherInviteAndInviteNum() async {
    var response =
    await http.netFetch('team_users/');
    return TeamFather.fromJson(response.data);
  }
  static Future getChildInvite(int page,{type}) async {
    var response =
    await http.netFetch('team_invited/');
    return TeamInviteList.fromJson(response.data).data;
  }

  static Future getShortUrl() async {
    var response = await http.netFetch('short_url/', method: 'get');
    return ShortUrl.fromJson(response.data);
  }
}
