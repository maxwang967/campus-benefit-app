import 'package:campus_benefit_app/core/managers/provider_managers.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/generated/i18n.dart';
import 'package:campus_benefit_app/service/system_repository.dart';
import 'package:campus_benefit_app/ui/pages/splash_page.dart';
import 'package:campus_benefit_app/view_models/theme_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:sharesdk_plugin/sharesdk_register.dart';

import 'fun/fun_app.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  if (!kIsWeb) {
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera, PermissionGroup.photos, PermissionGroup.storage]);
  }
  Map<String, dynamic> version = await SystemRepository.getVersion();
  String versionString = version["version"];
  print(versionString);
  if (kIsWeb) {
    runApp(MyApp());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
  } 
  else if (versionString == "test" && defaultTargetPlatform == TargetPlatform.iOS) {
    runApp(App());
    // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
  } 
  else {
    runApp(MyApp());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (! kIsWeb) {
ShareSDKRegister register = ShareSDKRegister();
    register.setupWechat(
        "wx58fbd34964417acc",
        "c2d771775f6435471a47007a315edcc1",
        "https://xiaoyuanzhuan.finerit.com");
    register.setupQQ("101550785", "04b6a0568d838310fbb49104ff654828");
    SharesdkPlugin.regist(register);
    }
    

    return OKToast(
        child: MultiProvider(
            providers: providers,
            child: Consumer<ThemeModel>(builder: (context, themeModel, child) {
              return RefreshConfiguration(
                hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                child: Center(
                  child: MaterialApp(
                    title: "校园赚",
                    debugShowCheckedModeBanner: false,
                    theme: themeModel.themeData(),
                    localizationsDelegates: const [
                      S.delegate,
                      RefreshLocalizations.delegate, //下拉刷新
                      GlobalCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    darkTheme: themeModel.themeData(platformDarkMode: true),
                    onGenerateRoute: Router.generateRoute,
                    // routes: {

                    // },
                    // initialRoute: RouteName.splash,
                    // home: SplashPage()
                  ),
                ),
              );
            })));
  }
}
