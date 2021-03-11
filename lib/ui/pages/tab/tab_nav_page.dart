import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart'
    if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/image_helper.dart';
import 'package:campus_benefit_app/ui/icons/icons_route4.dart';
import 'package:campus_benefit_app/ui/icons/icons_route5.dart';
import 'package:campus_benefit_app/ui/pages/course/course_home_page.dart';
import 'package:campus_benefit_app/ui/pages/job/job_home_page.dart';
import 'package:campus_benefit_app/ui/pages/shop/shop_home_page.dart';
import 'package:campus_benefit_app/ui/pages/user/user_home_page.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

List<Widget> pages = <Widget>[
  JobHomePage(),
  ShopHomePage(),
  CourseHomePage(),
  UserPage()
];

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _pageController;
  DateTime _lastPressed;
  bool loading = false;
  bool displayPWATip = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    if (kIsWeb) {
      String fatherId = Uri.base.queryParameters["fatherId"];
      if (fatherId != null) {
        StorageManager.sharedPreferences.setString(Config.FATHER_KEY, fatherId);
      }
      print("fatherId=$fatherId");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemStaticModel systemStaticModel =
        Provider.of<SystemStaticModel>(context);
    if (loading == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        systemStaticModel.tabPageController = _pageController;
      });
      loading = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: Stack(children: <Widget>[
          PageView.builder(
            itemBuilder: (ctx, index) => pages[index],
            itemCount: pages.length,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              systemStaticModel.tabPageSelectedIndex = index;
              systemStaticModel.notifyListeners();
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            child: kIsWeb
                ? (
                  displayPWATip?
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.webView,arguments: ['如何添加APP到主屏幕', '${systemStaticModel.systemStaticInfo.homePageData.pwaUrl}']);
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue.withOpacity(0.7),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "随时随地访问校园赚，请点击此处添加到主屏幕～",
                              style: TextStyle(color: Colors.white),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        displayPWATip = !displayPWATip;
                                      });
                                    },
                                    child: Icon(Icons.close,
                                        color: Colors.white, size: 14))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ):Container())
                : Container(),
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp5.task,
              size: 18,
            ),
            title: Text("兼职"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp5.cart,
              size: 19,
            ),
            title: Text("商城"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp5.book,
              size: 18,
            ),
            title: Text("代课"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              MyFlutterApp5.user,
              size: 18,
            ),
            title: Text("我的"),
          ),
        ],
        currentIndex: systemStaticModel.tabPageSelectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
