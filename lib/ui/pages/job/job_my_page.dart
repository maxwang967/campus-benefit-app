import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/auth_utils.dart';
import 'package:campus_benefit_app/core/utils/image_helper.dart';
import 'package:campus_benefit_app/ui/icons/FineritIcons.dart';
import 'package:campus_benefit_app/ui/icons/icons_route4.dart';
import 'package:campus_benefit_app/ui/icons/icons_route5.dart';
import 'package:campus_benefit_app/ui/pages/course/course_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobMyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JobMyPageState();
}

class JobMyPageState extends State<JobMyPage>
    with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: new Container(
              padding: EdgeInsets.only(top: 10),
              color: Colors.grey[100],
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileCommenWidget(
                    icon: MyFlutterApp4.addressbook,
                    text: '已完成的任务',
                    callback: () {
                      navigateToWebView(
                          '${Config.BASE_URL}job/qqz_join/'
                              '?status=3&token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}',
                          '已完成的任务');
                    },
                  ),
                  ProfileCommenWidget(
                    icon: MyFlutterApp4.pause,
                    text: '进行中的任务',
                    callback: () {
                      navigateToWebView(
                          '${Config.BASE_URL}job/qqz_join/'
                              '?status=5&token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}',
                          '进行中的任务');
                    },
                  ),
                  ProfileCommenWidget(
                    icon: MyFlutterApp4.fail,
                    text: '未通过的任务',
                    callback: () {
                      navigateToWebView(
                          '${Config.BASE_URL}job/qqz_join/'
                              '?status=4&token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}',
                          '未通过的任务');
                    },
                  ),
                ],
              ))),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey[800],
        ),
        title: Text(
          "我的任务",
          style: TextStyle(color: Colors.grey[800]),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
    );
  }

  navigateToWebView(url, title) {
    ErrorUtils.auth401Error(context, (){
      Navigator.pushNamed(context, RouteName.webView, arguments: [
        title, url
      ]);
    });
  }
}
