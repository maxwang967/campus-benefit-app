import 'package:campus_benefit_app/core/config/constants.dart';
import 'package:campus_benefit_app/core/routers/page_router_anim.dart';
import 'package:campus_benefit_app/ui/pages/course/course_account_bind_page.dart';
import 'package:campus_benefit_app/ui/pages/course/course_automation_page.dart';
import 'package:campus_benefit_app/ui/pages/course/order/course_rg1_order_page.dart';
import 'package:campus_benefit_app/ui/pages/course/order/course_rg2_order_page.dart';
import 'package:campus_benefit_app/ui/pages/course/order/course_zhihuishu_erya_order_page.dart';
import 'package:campus_benefit_app/ui/pages/job/job_my_page.dart';
import 'package:campus_benefit_app/ui/pages/job/job_task_page.dart';
import 'package:campus_benefit_app/ui/pages/login/login_page.dart';
import 'package:campus_benefit_app/ui/pages/login/login_register_page.dart';
import 'package:campus_benefit_app/ui/pages/splash_page.dart';
import 'package:campus_benefit_app/ui/pages/tab/tab_nav_page.dart';
import 'package:campus_benefit_app/ui/pages/user/distribution/user_distribution_detail_page.dart';
import 'package:campus_benefit_app/ui/pages/user/distribution/user_distribution_home_page.dart';
import 'package:campus_benefit_app/ui/pages/user/user_app_info.dart';
import 'package:campus_benefit_app/ui/pages/user/user_change_password_page.dart';
import 'package:campus_benefit_app/ui/pages/user/user_substation_page.dart';
import 'package:campus_benefit_app/ui/pages/user/user_wallet_rmb_detail_page.dart';
import 'package:campus_benefit_app/ui/pages/user/user_wallet_rmb_page.dart';
import 'package:campus_benefit_app/ui/pages/user/vip_info_page.dart';
import 'package:campus_benefit_app/ui/pages/webview_browser.dart'
    if (dart.library.io) 'package:campus_benefit_app/ui/pages/webview_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteName {
  static const String splash = '/';
  static const String tab = '/tab';
  static const String login = 'login';
  static const String changePassword = 'change_password';
  static const String webView = 'webview';
  static const String register = 'register';
  static const String appInfo = 'app_info';
  static const String jobTask = 'job_task';
  static const String jobMy = 'job_my';
  static const String userWalletRMBDetail = 'user_wallet_rmb_detail';
  static const String userWalletRMB = 'user_wallet_rmb';
  static const String userSubstation = 'user_substation';
  static const String userDistribution = 'user_distribution';
  static const String userDistributionDetail = 'user_distribution_detail';
  static const String courseBind = 'course_bind';
  static const String courseAutomation = 'course_automation';
  static const String courseZhihuishuEryaOrder = 'course_zhihuishu_erya_order';
  static const String courseRG1Order = 'course_rg1_order';
  static const String courseRG1OrderCourse = 'course_rg1_order_course';
  static const String courseRG2Order = 'course_rg2_order';
  static const String userVipInfo = 'vip_info';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.appInfo:
        return NoAnimRouteBuilder(AppInfoPage());
      case RouteName.login:
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => LoginRegisterPage());
      case RouteName.changePassword:
        return CupertinoPageRoute(builder: (_) => UserChangePasswordPage());
      case RouteName.userWalletRMB:
        return CupertinoPageRoute(builder: (_) => UserWalletRMBPage());
      case RouteName.userSubstation:
        return CupertinoPageRoute(builder: (_) => UserSubstationPage());
      case RouteName.userWalletRMBDetail:
        return CupertinoPageRoute(builder: (_) => UserWalletRMBDetailPage());
      case RouteName.userDistribution:
        return CupertinoPageRoute(builder: (_) => UserDistributionPage());
      case RouteName.userDistributionDetail:
        return CupertinoPageRoute(builder: (_) => UserDistributionDetailPage());
      case RouteName.userVipInfo:
        return CupertinoPageRoute(builder: (_) => VIPDredgePage());
      case RouteName.courseBind:
        CourseType type = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => CourseAccountBindPage(
                  type: type,
                ));
      case RouteName.courseAutomation:
        List types = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => CourseAutomationPage(
                  types: types,
                ));
      case RouteName.courseZhihuishuEryaOrder:
        return CupertinoPageRoute(
            builder: (_) => CourseZhihuishuEryaOrderPage());
      case RouteName.courseRG1Order:
        return CupertinoPageRoute(builder: (_) => CourseRG1OrderPage());
      case RouteName.courseRG1OrderCourse:
        String account = settings.arguments;
        return CupertinoPageRoute(builder: (_) => CourseRG1OrderCoursePage(account: account));
              case RouteName.courseRG2Order:
        return CupertinoPageRoute(builder: (_) => CourseRG2OrderPage());
      case RouteName.jobTask:
        return CupertinoPageRoute(builder: (_) => JobTaskPage());
      case RouteName.jobMy:
        return CupertinoPageRoute(builder: (_) => JobMyPage());
      case RouteName.tab:
        return CupertinoPageRoute(builder: (_) => TabNavigator());
      case RouteName.webView:
        List arguments = settings.arguments;
        return CupertinoPageRoute(
            builder: (_) => WebViewPage(
                  url: arguments[1],
                  title: arguments[0],
                ));
        break;
      default:
      print(settings.name);
      // throw Exception('路由未定义');
    }
  }
}
