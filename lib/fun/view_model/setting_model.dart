import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:flutter/cupertino.dart';

/// 使用原生WebView
const String kUseWebViewPlugin = 'kUseWebViewPlugin';

class UseWebViewPluginModel extends ChangeNotifier {
  get value =>
      StorageManager.sharedPreferences.getBool(kUseWebViewPlugin) ?? false;

  switchValue(){
    StorageManager.sharedPreferences
        .setBool(kUseWebViewPlugin, !value);
    notifyListeners();
  }

}
