import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/config/constants.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart'
    if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/auth_utils.dart';
import 'package:campus_benefit_app/models/zhihuishu_erya_user.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/service/course_repository.dart';
import 'package:campus_benefit_app/ui/widgets/banner_widget.dart';
import 'package:campus_benefit_app/ui/widgets/my_card.dart';
import 'package:campus_benefit_app/ui/widgets/sliver_persistent_header.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/course/course_page_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CourseHomePageState();
}

class CourseHomePageState extends State<CourseHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool loading = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  SystemStaticModel staticModel;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Consumer2<CourseDataListModel, SystemStaticModel>(
      builder: (BuildContext context, CourseDataListModel model,
          SystemStaticModel staticModel, Widget child) {
        if (loading == false) {
          model.refresh();
          loading = true;
        }
        if (model.busy || staticModel.busy) {
          return ViewStateBusyWidget();
        } else if (model.error) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        } else if (staticModel.error) {
          return ViewStateErrorWidget(
              error: staticModel.viewStateError,
              onPressed: staticModel.initData);
        }

        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              actions: <Widget>[
                FlatButton(
                  child: Text("注意事项"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: new Text("温馨提示"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("我知道了"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[Text("${model.limit}")],
                            ));
                      },
                    );
                  },
                  color: Colors.white,
                )
              ],
              title: Row(
                children: <Widget>[
                  Text(
                    '代课系统',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white, image: null),
                    child: Container(
                      color: Colors.white,
                      child: Container(
                        width: width,
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[100],
                            ),
                            width: width,
                            height: 35,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: new Icon(
                                    Icons.search,
                                    color: Colors.grey[300],
                                    size: 18,
                                  ),
//                                            padding: EdgeInsets.only(left: 10,right: 10),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '免费搜题',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400]),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.webView,
                                arguments: [
                                  '${staticModel.systemStaticInfo.coursePageData.cardPage[3].name}',
                                  '${staticModel.systemStaticInfo.coursePageData.cardPage[3].nav}/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}'
                                ]);
                          },
                        ),
                      ),
                    ),
                  ),
                  55.0),
            ),
            SliverToBoxAdapter(
              child: _buildBanner(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: MyCard(
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("${model.list[index].name}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Text("使用教程",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, RouteName.webView,
                                                  arguments: [
                                                    "教程",
                                                    model.list[index].guide_url
                                                  ]);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            child: Text(
                                                model.list[index].name == "自助代课"
                                                    ? "我的账号"
                                                    : "查看订单",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            onTap: () {
                                              ErrorUtils.auth401Error(context,
                                                  () {
                                                if (model.list[index].name ==
                                                    "自助代课") {
                                                  CourseRepository
                                                          .fetchZhihuishuEryaUser()
                                                      .then((value) {
                                                    ZhihuishuEryaUser item =
                                                        value
                                                            as ZhihuishuEryaUser;
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        // return object of type Dialog
                                                        return AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    new BorderRadius.circular(
                                                                        10.0)),
                                                            title: new Text(
                                                                "我的账号"),
                                                            actions: <Widget>[
                                                              new FlatButton(
                                                                child: new Text(
                                                                    "我知道了"),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                            content: Container(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    "学习通|尔雅",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  MyCard(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          ListTile(
                                                                            title:
                                                                                Text("学校"),
                                                                            trailing:
                                                                                Text(item.eryaSchool == "" ? "暂无" : item.eryaSchool, style: TextStyle(color: Colors.grey)),
                                                                          ),
                                                                          ListTile(
                                                                            title:
                                                                                Text("账号"),
                                                                            trailing:
                                                                                Text(item.eryaUsername == "" ? "暂无" : item.eryaUsername, style: TextStyle(color: Colors.grey)),
                                                                          ),
                                                                          ListTile(
                                                                            title:
                                                                                Text("密码"),
                                                                            trailing:
                                                                                Text(item.eryaPassword == "" ? "暂无" : item.eryaPassword, style: TextStyle(color: Colors.grey)),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    "知到|智慧树",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  MyCard(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          ListTile(
                                                                            title:
                                                                                Text("学校"),
                                                                            trailing:
                                                                                Text(item.zhihuishuSchool == "" ? "暂无" : item.zhihuishuSchool, style: TextStyle(color: Colors.grey)),
                                                                          ),
                                                                          ListTile(
                                                                            title:
                                                                                Text("账号"),
                                                                            trailing:
                                                                                Text(item.zhihuishuUsername == "" ? "暂无" : item.zhihuishuUsername, style: TextStyle(color: Colors.grey)),
                                                                          ),
                                                                          ListTile(
                                                                            title:
                                                                                Text("密码"),
                                                                            trailing:
                                                                                Text(item.zhihuishuPassword == "" ? "暂无" : item.zhihuishuPassword, style: TextStyle(color: Colors.grey)),
                                                                          ),
                                                                        ],
                                                                      ))
                                                                ],
                                                              ),
                                                            ));
                                                      },
                                                    );
                                                  });
                                                } else {
                                                  if (model.list[index].name ==
                                                      "") {
                                                  } else if (model
                                                          .list[index].name ==
                                                      "自助代课（批量提交）") {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouteName
                                                            .courseZhihuishuEryaOrder);
                                                  } else if (model
                                                          .list[index].name ==
                                                      "人工代课一") {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouteName
                                                            .courseRG1Order);
                                                  } else if (model
                                                          .list[index].name ==
                                                      "人工代课二") {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RouteName
                                                            .courseRG2Order);
                                                  }
                                                }
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                                "${model.list[index].value[i].name}"),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "${model.list[index].value[i].currentPrice}元/科",
                                                  style: TextStyle(
                                                      color: Colors.deepOrange),
                                                ),
                                                SizedBox(width: 10),
                                                GestureDetector(
                                                  child: new Container(
                                                    width: 60,
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.only(
                                                        top: 2,
                                                        bottom:
                                                            3), //只是为了给 Text 加一个内边距，好看点~
                                                    child: Text(
                                                      '刷课',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.0),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    ErrorUtils.auth401Error(
                                                        context, () {
                                                      if (model.list[index]
                                                              .name ==
                                                          "自助代课") {
                                                        CourseType type = model
                                                                .list[index]
                                                                .value[i]
                                                                .name
                                                                .toString()
                                                                .contains('学习通')
                                                            ? CourseType.erya
                                                            : CourseType
                                                                .zhihuishu;
                                                        if (type ==
                                                            CourseType.erya) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteName.webView,
                                                              arguments: [
                                                                '${staticModel.systemStaticInfo.coursePageData.cardPage[2].name}',
                                                                '${staticModel.systemStaticInfo.coursePageData.cardPage[2].nav}/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}'
                                                              ]);
                                                        } else if (type ==
                                                            CourseType
                                                                .zhihuishu) {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteName.webView,
                                                              arguments: [
                                                                '${staticModel.systemStaticInfo.coursePageData.cardPage[1].name}',
                                                                '${staticModel.systemStaticInfo.coursePageData.cardPage[1].nav}/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}'
                                                              ]);
                                                        }
                                                      } else if (model
                                                              .list[index]
                                                              .name ==
                                                          "自助代课（批量提交）") {
                                                        CourseType type = model
                                                                .list[index]
                                                                .value[i]
                                                                .name
                                                                .toString()
                                                                .contains('学习通')
                                                            ? CourseType.erya
                                                            : CourseType
                                                                .zhihuishu;

                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteName
                                                                .courseAutomation,
                                                            arguments: [
                                                              type,
                                                              CourseAutomationType
                                                                  .multiple,
                                                              CourseHandscraftType
                                                                  .no,
                                                              model.list[index]
                                                                  .value[i],
                                                              model.list[index]
                                                                  .guide_url
                                                            ]);
                                                      } else if (model
                                                              .list[index]
                                                              .name ==
                                                          "人工代课一") {
                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteName
                                                                .courseAutomation,
                                                            arguments: [
                                                              CourseType.other,
                                                              CourseAutomationType
                                                                  .multiple,
                                                              CourseHandscraftType
                                                                  .type1,
                                                              model.list[index]
                                                                  .value[i],
                                                              model.list[index]
                                                                  .guide_url
                                                            ]);
                                                      } else if (model
                                                              .list[index]
                                                              .name ==
                                                          "人工代课二") {
                                                        Navigator.pushNamed(
                                                            context,
                                                            RouteName
                                                                .courseAutomation,
                                                            arguments: [
                                                              CourseType.other,
                                                              CourseAutomationType
                                                                  .multiple,
                                                              CourseHandscraftType
                                                                  .type2,
                                                              model.list[index]
                                                                  .value[i],
                                                              model.list[index]
                                                                  .guide_url
                                                            ]);
                                                      }
                                                    });
                                                  },
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: model.list[index].value.length,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                },
                childCount: model.list.length,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 20),
            )
          ],
        );
      },
    );
  }

  String headImg = "";
  String nickName = "";
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  Widget _buildBanner() {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: PhysicalModel(
        color: Colors.white, //设置背景底色透明
        borderRadius: BorderRadius.circular(12),

        clipBehavior: Clip.antiAlias, //注意这个属性
        child: BannerWidget(
          list: staticModel.systemStaticInfo.coursePageData.cardPage
              .sublist(0, 1),
          height: 70,
        ),
      ),
    );
  }
}

class ProfileCommenWidget extends StatelessWidget {
  IconData icon;
  String text;
  Function callback;
  Widget message;

  ProfileCommenWidget(
      {Key key,
      @required this.icon,
      @required this.text,
      @required this.callback,
      this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.only(top: 2),
        color: Colors.white,
        child: FlatButton(
          onPressed: callback,
          child: new Row(
            children: <Widget>[
              Container(
                child: Profile_gradient_icon_widget(
                  icon: icon,
                ),
                margin: EdgeInsets.only(right: 5),
              ),
              Container(
                  child: new Text(text,
                      style: new TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ))),
              message == null
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: new Icon(
                          Icons.navigate_next,
                          size: 20,
                          color: Colors.black38,
                        ),
                      ),
                    )
                  : message
            ],
          ),
        ));
  }
}

class Profile_gradient_icon_widget extends StatelessWidget {
  IconData icon;
  Profile_gradient_icon_widget({Key key, @required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      key: key,
      padding: EdgeInsets.only(top: 4, left: 4, bottom: 4, right: 4),
      child: new Icon(
        icon,
        size: 15,
        color: Colors.white,
      ),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: new LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.tealAccent,
              Colors.lightBlueAccent,
            ]),
      ),
    );
  }
}
