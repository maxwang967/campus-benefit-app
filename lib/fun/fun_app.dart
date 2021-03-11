
import 'package:campus_benefit_app/fun/config/provider_manager.dart';
import 'package:campus_benefit_app/fun/config/router_manger.dart';
import 'package:campus_benefit_app/fun/generated/i18n.dart';
import 'package:campus_benefit_app/fun/view_model/locale_model.dart';
import 'package:campus_benefit_app/fun/view_model/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
            providers: providers,
            child: Consumer2<ThemeModel, LocaleModel>(
                builder: (context, themeModel, localeModel, child) {
              return RefreshConfiguration(
                hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: themeModel.themeData(),
                  darkTheme: themeModel.themeData(platformDarkMode: true),
                  locale: localeModel.locale,
                  localizationsDelegates: const [
                    S.delegate,
                    RefreshLocalizations.delegate, //下拉刷新
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  onGenerateRoute: Router.generateRoute,
                  initialRoute: RouteName.splash,
                ),
              );
            })));
  }
}
