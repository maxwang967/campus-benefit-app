import 'package:flutter/cupertino.dart';
import 'package:campus_benefit_app/fun/config/net/lean_cloud_api.dart';

/// App相关接口
class AppRepository {
  static Future checkUpdate(String platform, String version) async {
    var response = await http.get<List>('classes/appVersion',
        queryParameters: {'where': '{"platform":"$platform"}'});
    if (response.data.length > 0) {
      var result = response.data[0];
      debugPrint('当前版本为===>$version');
      if (result['version'] != version) {
        debugPrint('发现新版本===>${result['version']}\nurl:${result['url']}');
        return result['url'];
      }
    }
    return null;
  }
}
