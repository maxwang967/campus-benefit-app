import 'dart:ui';

import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/service/course_repository.dart';
import 'package:campus_benefit_app/ui/widgets/search_bar.dart';
import 'package:campus_benefit_app/view_models/course/course_page_model.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class CourseZhihuishuEryaOrderPage extends StatefulWidget {
  @override
  _CourseZhihuishuEryaOrderPageState createState() =>
      _CourseZhihuishuEryaOrderPageState();
}

class _CourseZhihuishuEryaOrderPageState
    extends State<CourseZhihuishuEryaOrderPage> {
  TabController tabController;
  ValueNotifier<int> valueNotifier = ValueNotifier(0);

  @override
  void dispose() {
    super.dispose();
    valueNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableProvider<int>.value(
        value: valueNotifier,
        child: DefaultTabController(
            length: 2,
            initialIndex: valueNotifier.value,
            child: Builder(builder: (context) {
              if (tabController == null) {
                tabController = DefaultTabController.of(context);
                tabController.addListener(() {
                  valueNotifier.value = tabController.index;
                });
              }
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    new SliverAppBar(
                      title: Text("订单详情"),
                      pinned: true,
                      bottom: new TabBar(
                        isScrollable: false,

                        indicatorPadding:
                            EdgeInsets.only(bottom: 5, left: 3, right: 3),
                        tabs: [
                          new Tab(text: '知到'),
                          new Tab(text: '学习通'),
                        ],
                      ),
                    ),
                    new SliverFillRemaining(
                      child: TabBarView(
                        children: <Widget>[
                          CourseZhihuishuTab(),
                          CourseEryaTab()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            })));
  }
}

class CourseZhihuishuTab extends StatefulWidget {
  @override
  _CourseZhihuishuTabState createState() => _CourseZhihuishuTabState();
}

class _CourseZhihuishuTabState extends State<CourseZhihuishuTab> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ZhihuishuOrderDataListModel>(
        builder: (BuildContext context, ZhihuishuOrderDataListModel model,
            Widget child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          }
          return CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(
                  left: 12,
                  bottom: 12,
                  right: 12,
                  top: 10,
                ),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: SearchBar(
                      searchBarWidth: MediaQuery.of(context).size.width * 0.85,
                      hintText: "手机号/学号搜索",
                      controller: textEditingController,
                      onSearchTextChanged: (value) {
                        model.search = value;
                        model.searchRefresh();
                      },
                    )),
                    // GestureDetector(
                    //   child: new Container(
                    //     alignment: Alignment(0, 0),
                    //     margin: EdgeInsets.only(left: 12),
                    //     height: 32,
                    //     child: Text("搜索",
                    //         style:
                    //             TextStyle(color: Colors.black, fontSize: 14)),
                    //   ),
                    //   onTap: () {
                    //     model.search = textEditingController.text;
                    //     textEditingController.clear();
                    //     model.searchRefresh();
                    //     FocusScope.of(context).requestFocus(FocusNode());
                    //   },
                    // )
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 5,
                    columns: [
                      DataColumn(
                        label: Text("操作"),
                      ),
                      DataColumn(label: Text("完成状态")),
                      DataColumn(label: Text("课程名")),
                      DataColumn(label: Text("手机号")),
                      DataColumn(label: Text("密码")),
                      DataColumn(label: Text("学校")),
                      DataColumn(label: Text("学号")),
                      DataColumn(label: Text("密码")),
                      DataColumn(label: Text("操作时间")),
                      DataColumn(label: Text("添加时间")),
                    ],
                    rows: List<DataRow>.generate(
                        model.list.length,
                        (index) => DataRow(cells: [
                              DataCell(Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context2) {
                                          return AlertDialog(
                                            title: new Text("进度详情"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("前往普通系统"),
                                                onPressed: () async {
                                                  Navigator.pop(context2);
                                                  ProgressDialog pr;
                                                  if (model.list[index].user
                                                              .schoolName ==
                                                          null ||
                                                      model.list[index].user
                                                              .schoolName
                                                              .trim() ==
                                                          "") {
                                                    // 智慧树手机号登录
                                                    try {
                                                      pr = new ProgressDialog(
                                                          context);
                                                      pr.style(
                                                          message:
                                                              "正在验证账号信息，请耐心等待～");
                                                      await pr.show();
                                                      await CourseRepository
                                                          .fetchCourseZhihuishuDataList(
                                                              username: model
                                                                  .list[index]
                                                                  .user
                                                                  .phonenum,
                                                              password: model
                                                                  .list[index]
                                                                  .user
                                                                  .passwordPhonenum);
                                                      await pr.hide();
                                                      pr.dismiss();
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName.webView,
                                                          arguments: [
                                                            '普通系统',
                                                            "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/zhihuishu/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                                          ]);
                                                    } catch (e) {
                                                      Future.microtask(() => {
                                                            showToast(
                                                                "信息有误，请检查账号信息")
                                                          });
                                                    } finally {
                                                      await pr.hide();
                                                      pr.dismiss();
                                                    }
                                                  } else {
                                                    // 智慧树学号登录
                                                    try {
                                                      pr = new ProgressDialog(
                                                          context);
                                                      pr.style(
                                                          message:
                                                              "正在验证账号信息，请耐心等待～");
                                                      await pr.show();
                                                      await CourseRepository
                                                          .fetchCourseZhihuishuDataList(
                                                              school: model
                                                                  .list[index]
                                                                  .user
                                                                  .schoolName,
                                                              username: model
                                                                  .list[index]
                                                                  .user
                                                                  .stuNum,
                                                              password: model
                                                                  .list[index]
                                                                  .user
                                                                  .passwordStunum);
                                                      await pr.hide();
                                                      pr.dismiss();
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName.webView,
                                                          arguments: [
                                                            '普通系统',
                                                            "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/zhihuishu/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                                          ]);
                                                    } catch (e) {
                                                      Future.microtask(() => {
                                                            showToast(
                                                                "信息有误，请检查账号信息")
                                                          });
                                                    } finally {
                                                      await pr.hide();
                                                      pr.dismiss();
                                                    }
                                                  }
                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text("关闭"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            contentPadding: EdgeInsets.all(0.0),
                                            content: SizedBox(
                                              width: 450,
                                              child: ZhihuishuOrderDetailPage(
                                                  id: model.list[index].id),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '进度',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      model.extraBrush(model.list[index].id);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '补刷',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: new Text("温馨提示"),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text("确认"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    model.delete(
                                                        model.list[index].id);
                                                  },
                                                ),
                                                new FlatButton(
                                                  child: new Text("取消"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text("是否确认删除订单？")
                                                ],
                                              ));
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '删除',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              DataCell(Text("${model.list[index].achive}")),
                              DataCell(
                                  Text("${model.list[index].course.name}")),
                              DataCell(
                                  Text("${model.list[index].user.phonenum}")),
                              DataCell(Text(
                                  "${model.list[index].user.passwordPhonenum}")),
                              DataCell(
                                  Text("${model.list[index].user.schoolName}")),
                              DataCell(
                                  Text("${model.list[index].user.stuNum}")),
                              DataCell(Text(
                                  "${model.list[index].user.passwordStunum}")),
                              DataCell(Text("${model.list[index].updateTime}")),
                              DataCell(Text("${model.list[index].addTime}")),
                            ])),
                  )),
            ),
          ]);
        },
        model: ZhihuishuOrderDataListModel(),
        onModelReady: (model) => model.initData());
  }
}

class ZhihuishuOrderDetailPage extends StatefulWidget {
  final int id;

  const ZhihuishuOrderDetailPage({Key key, this.id}) : super(key: key);
  @override
  _ZhihuishuOrderDetailPageState createState() =>
      _ZhihuishuOrderDetailPageState();
}

class _ZhihuishuOrderDetailPageState extends State<ZhihuishuOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 500, minWidth: 450),
            child: Material(
              child: ProviderWidget<ZhihuishuOrderDetailDataListModel>(
                  builder: (BuildContext context,
                      ZhihuishuOrderDetailDataListModel model, Widget child) {
                    if (model.busy) {
                      return ViewStateBusyWidget();
                    } else if (model.error) {
                      return ViewStateErrorWidget(
                          error: model.viewStateError,
                          onPressed: model.initData);
                    }
                    return CustomScrollView(slivers: <Widget>[
                      SliverFillRemaining(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 5,
                              columns: [
                                DataColumn(
                                  label: Text("任务名"),
                                ),
                                DataColumn(label: Text("任务状态")),
                                DataColumn(label: Text("信息")),
                                DataColumn(label: Text("执行时间")),
                                DataColumn(label: Text("添加时间")),
                              ],
                              rows: List<DataRow>.generate(
                                  model.list.length,
                                  (index) => DataRow(cells: [
                                        DataCell(Text(
                                            "${model.list[index].task.name}")),
                                        DataCell(Text(
                                            "${model.list[index].status}")),
                                        DataCell(Text(
                                            "${model.list[index].currentInfo}")),
                                        DataCell(Text(
                                            "${model.list[index].task.updateTime}")),
                                        DataCell(Text(
                                            "${model.list[index].task.addTime}")),
                                      ])),
                            )),
                      ),
                    ]);
                  },
                  model: ZhihuishuOrderDetailDataListModel(widget.id),
                  onModelReady: (model) => model.initData()),
            ),
          ),
        ),
      ),
    );
  }
}

class CourseEryaTab extends StatefulWidget {
  @override
  _CourseEryaTabState createState() => _CourseEryaTabState();
}

class _CourseEryaTabState extends State<CourseEryaTab> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<EryaOrderDataListModel>(
        builder:
            (BuildContext context, EryaOrderDataListModel model, Widget child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          }
          return CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(
                  left: 12,
                  bottom: 12,
                  right: 12,
                  top: 10,
                ),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: SearchBar(
                      searchBarWidth: MediaQuery.of(context).size.width * 0.85,
                      hintText: "手机号/学号搜索",
                      controller: textEditingController,
                      onSearchTextChanged: (value) {
                        model.search = value;
                        model.searchRefresh();
                      },
                    )),
                    // GestureDetector(
                    //   child: new Container(
                    //     alignment: Alignment(0, 0),
                    //     margin: EdgeInsets.only(left: 12),
                    //     height: 32,
                    //     child: Text("搜索",
                    //         style:
                    //             TextStyle(color: Colors.black, fontSize: 14)),
                    //   ),
                    //   onTap: () {
                    //     model.search = textEditingController.text;
                    //     textEditingController.clear();
                    //     model.refresh();
                    //     FocusScope.of(context).requestFocus(FocusNode());
                    //   },
                    // )
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 5,
                    columns: [
                      DataColumn(
                        label: Text("操作"),
                      ),
                      DataColumn(label: Text("完成状态")),
                      DataColumn(label: Text("课程名")),
                      DataColumn(label: Text("手机号")),
                      DataColumn(label: Text("密码")),
                      DataColumn(label: Text("学校")),
                      DataColumn(label: Text("学号")),
                      DataColumn(label: Text("密码")),
                      DataColumn(label: Text("操作时间")),
                      DataColumn(label: Text("添加时间")),
                    ],
                    rows: List<DataRow>.generate(
                        model.list.length,
                        (index) => DataRow(cells: [
                              DataCell(Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context2) {
                                          return AlertDialog(
                                            title: new Text("进度详情"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("前往普通系统"),
                                                onPressed: () async {
                                                  Navigator.pop(context2);
                                                  ProgressDialog pr;
                                                  if (model.list[index].user
                                                              .school ==
                                                          null ||
                                                      model.list[index].user
                                                              .school
                                                              .trim() ==
                                                          "") {
                                                    // 尔雅手机号登录
                                                    try {
                                                      pr = new ProgressDialog(
                                                          context);
                                                      pr.style(
                                                          message:
                                                              "正在验证账号信息，请耐心等待～");
                                                      await pr.show();
                                                      await CourseRepository
                                                          .fetchCourseEryaDataList(
                                                              username: model
                                                                  .list[index]
                                                                  .user
                                                                  .phonenum,
                                                              password: model
                                                                  .list[index]
                                                                  .user
                                                                  .password);
                                                      await pr.hide();
                                                      pr.dismiss();
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName.webView,
                                                          arguments: [
                                                            '普通系统',
                                                            "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/erya/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                                          ]);
                                                    } catch (e, s) {
                                                      print(s);
                                                      Future.microtask(() => {
                                                            showToast(
                                                                "信息有误，请检查账号信息")
                                                          });
                                                    } finally {
                                                      await pr.hide();
                                                      pr.dismiss();
                                                    }
                                                  } else {
                                                    // 尔雅学号登录
                                                    try {
                                                      pr = new ProgressDialog(
                                                          context);
                                                      pr.style(
                                                          message:
                                                              "正在验证账号信息，请耐心等待～");
                                                      await pr.show();
                                                      await CourseRepository
                                                          .fetchCourseEryaDataList(
                                                              school: model
                                                                  .list[index]
                                                                  .user
                                                                  .school,
                                                              username: model
                                                                  .list[index]
                                                                  .user
                                                                  .stuNum,
                                                              password: model
                                                                  .list[index]
                                                                  .user
                                                                  .password2);
                                                      await pr.hide();
                                                      pr.dismiss();
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteName.webView,
                                                          arguments: [
                                                            '普通系统',
                                                            "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/erya/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                                          ]);
                                                    } catch (e, s) {
                                                      print(e);
                                                      print(s);
                                                      Future.microtask(() => {
                                                            showToast(
                                                                "信息有误，请检查账号信息")
                                                          });
                                                    } finally {
                                                      await pr.hide();
                                                      pr.dismiss();
                                                    }
                                                  }
                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text("关闭"),
                                                onPressed: () {
                                                  Navigator.pop(context2);
                                                },
                                              ),
                                            ],
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            contentPadding: EdgeInsets.all(0.0),
                                            content: SizedBox(
                                              width: 450,
                                              child: EryaOrderDetailPage(
                                                  id: model.list[index].id),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '进度',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      model.extraBrush(model.list[index].id);
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '补刷',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: new Text("温馨提示"),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text("确认"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    model.delete(
                                                        model.list[index].id);
                                                  },
                                                ),
                                                new FlatButton(
                                                  child: new Text("取消"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text("是否确认删除订单？")
                                                ],
                                              ));
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 20,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '删除',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              DataCell(Text("${model.list[index].achive}")),
                              DataCell(
                                  Text("${model.list[index].course.name}")),
                              DataCell(
                                  Text("${model.list[index].user.phonenum}")),
                              DataCell(
                                  Text("${model.list[index].user.password}")),
                              DataCell(
                                  Text("${model.list[index].user.school}")),
                              DataCell(
                                  Text("${model.list[index].user.stuNum}")),
                              DataCell(
                                  Text("${model.list[index].user.password2}")),
                              DataCell(Text("${model.list[index].updateTime}")),
                              DataCell(Text("${model.list[index].addTime}")),
                            ])),
                  )),
            ),
          ]);
        },
        model: EryaOrderDataListModel(),
        onModelReady: (model) => model.initData());
  }
}

class EryaOrderDetailPage extends StatefulWidget {
  final int id;

  const EryaOrderDetailPage({Key key, this.id}) : super(key: key);
  @override
  _EryaOrderDetailPageState createState() => _EryaOrderDetailPageState();
}

class _EryaOrderDetailPageState extends State<EryaOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 500, minWidth: 450),
            child: Material(
              child: ProviderWidget<EryaOrderDetailDataListModel>(
                  builder: (BuildContext context,
                      EryaOrderDetailDataListModel model, Widget child) {
                    if (model.busy) {
                      return ViewStateBusyWidget();
                    } else if (model.error) {
                      return ViewStateErrorWidget(
                          error: model.viewStateError,
                          onPressed: model.initData);
                    }
                    return CustomScrollView(slivers: <Widget>[
                      SliverFillRemaining(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 5,
                              columns: [
                                DataColumn(
                                  label: Text("任务名"),
                                ),
                                DataColumn(label: Text("任务状态")),
                                DataColumn(label: Text("信息")),
                                DataColumn(label: Text("执行时间")),
                                DataColumn(label: Text("添加时间")),
                              ],
                              rows: List<DataRow>.generate(
                                  model.list.length,
                                  (index) => DataRow(cells: [
                                        DataCell(Text(
                                            "${model.list[index].task.name}")),
                                        DataCell(Text(
                                            "${model.list[index].status}")),
                                        DataCell(Text(
                                            "${model.list[index].currentInfo}")),
                                        DataCell(Text(
                                            "${model.list[index].task.updateTime}")),
                                        DataCell(Text(
                                            "${model.list[index].task.addTime}")),
                                      ])),
                            )),
                      ),
                    ]);
                  },
                  model: EryaOrderDetailDataListModel(widget.id),
                  onModelReady: (model) => model.initData()),
            ),
          ),
        ),
      ),
    );
  }
}
