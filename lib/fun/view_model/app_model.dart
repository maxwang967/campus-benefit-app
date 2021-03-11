import 'dart:io';

import 'package:flutter/material.dart';
import 'package:campus_benefit_app/fun/provider/view_state_model.dart';
import 'package:campus_benefit_app/fun/service/app_repository.dart';
import 'package:campus_benefit_app/fun/utils/platform_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kAppFirstEntry = 'kAppFirstEntry';

// 主要用于app启动相关
class AppModel with ChangeNotifier {
  bool isFirst = false;

  loadIsFirstEntry() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    isFirst = sharedPreferences.getBool(kAppFirstEntry);
    notifyListeners();
  }
}

class AppUpdateModel extends ViewStateModel {
  checkUpdate() async {
    String url;
    setBusy();
    try {
      var appVersion = await PlatformUtils.getAppVersion();
      url =
          await AppRepository.checkUpdate(Platform.operatingSystem, appVersion);
      setIdle();
    } catch (e,s) {
      setError(e,stackTrace: s);
    }
    return url;
  }
}
