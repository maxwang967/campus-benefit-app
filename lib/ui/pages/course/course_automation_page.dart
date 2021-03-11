import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/config/constants.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/nets/handler.dart';
import 'package:campus_benefit_app/core/nets/net_message.dart';
import 'package:campus_benefit_app/core/nets/response_exception.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/status_bar_utils.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/service/course_repository.dart';
import 'package:campus_benefit_app/view_models/course/course_page_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class CourseListItem<T> {
  bool isSelected = false;
  T data;
  T id;
  CourseListItem(this.id, this.data);
}

class CourseAutomationPage extends StatefulWidget {
  final List types;
  const CourseAutomationPage({Key key, this.types}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CourseAutomationPageState();
}

class _CourseAutomationPageState extends State<CourseAutomationPage> {
  TextEditingController platformController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  CourseAutomationModel globalModel;

  @override
  void initState() {
    super.initState();
    platformController.text = widget.types[2] == CourseHandscraftType.no
        ? (widget.types[0] == CourseType.erya ? "平台 尔雅" : "平台 智慧树")
        : "平台 ${widget.types[3].name}";
  }

  @override
  void dispose() {
    super.dispose();
    platformController.dispose();
    schoolController.dispose();
    accountController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    globalModel = Provider.of<CourseAutomationModel>(context);
    if (loading == false) {
      globalModel.clearAll();
      loading = true;
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: StatusBarUtils.systemUiOverlayStyle(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              ButtonTheme(
                minWidth: 40,
                child: FlatButton(
                  child: Text(
                    "教程",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  color: Colors.white,
                  disabledColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.webView, arguments: [
                      "教程",
                      widget.types[widget.types.length - 1]
                    ]);
                  },
                ),
              ),
              widget.types[0] != CourseType.other
                  ? ButtonTheme(
                      minWidth: 40,
                      child: FlatButton(
                        child: Text(
                          "前往普通系统",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        color: Colors.white,
                        disabledColor: Colors.white,
                        onPressed: () async {
                          ProgressDialog pr;
                          if ((accountController.text == null ||
                                  accountController.text.trim() == "") ||
                              (passwordController.text == null ||
                                  passwordController.text.trim() == "")) {
                            showToast("请先填写账号信息，再前往普通系统。");
                            return;
                          }
                          switch (widget.types[0]) {
                            case CourseType.zhihuishu:
                              if (schoolController.text == null ||
                                  schoolController.text.trim() == "") {
                                // 智慧树手机号登录
                                try {
                                  pr = new ProgressDialog(context);
                                  pr.style(message: "正在验证账号信息，请耐心等待～");
                                  await pr.show();
                                  await CourseRepository
                                      .fetchCourseZhihuishuDataList(
                                          username: accountController.text,
                                          password: passwordController.text);
                                  await pr.hide();
                                  pr.dismiss();
                                  Navigator.pushNamed(
                                      context, RouteName.webView,
                                      arguments: [
                                        '普通系统',
                                        "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/zhihuishu/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                      ]);
                                } catch (e) {
                                  Future.microtask(
                                      () => {showToast("信息有误，请检查账号信息")});
                                } finally {
                                  await pr.hide();
                                  pr.dismiss();
                                }
                              } else {
                                // 智慧树学号登录
                                try {
                                  pr = new ProgressDialog(context);
                                  pr.style(message: "正在验证账号信息，请耐心等待～");
                                  await pr.show();
                                  await CourseRepository
                                      .fetchCourseZhihuishuDataList(
                                          school: schoolController.text,
                                          username: accountController.text,
                                          password: passwordController.text);
                                  await pr.hide();
                                  pr.dismiss();
                                  Navigator.pushNamed(
                                      context, RouteName.webView,
                                      arguments: [
                                        '普通系统',
                                        "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/zhihuishu/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                      ]);
                                } catch (e) {
                                  Future.microtask(
                                      () => {showToast("信息有误，请检查账号信息")});
                                } finally {
                                  await pr.hide();
                                  pr.dismiss();
                                }
                              }
                              break;
                            case CourseType.erya:
                              if (schoolController.text == null ||
                                  schoolController.text.trim() == "") {
                                // 尔雅手机号登录
                                try {
                                  pr = new ProgressDialog(context);
                                  pr.style(message: "正在验证账号信息，请耐心等待～");
                                  await pr.show();
                                  await CourseRepository
                                      .fetchCourseEryaDataList(
                                          username: accountController.text,
                                          password: passwordController.text);
                                  await pr.hide();
                                  pr.dismiss();
                                  Navigator.pushNamed(
                                      context, RouteName.webView,
                                      arguments: [
                                        '普通系统',
                                        "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/erya/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                      ]);
                                } catch (e) {
                                  Future.microtask(
                                      () => {showToast("信息有误，请检查账号信息")});
                                } finally {
                                  await pr.hide();
                                  pr.dismiss();
                                }
                              } else {
                                // 尔雅学号登录
                                try {
                                  pr = new ProgressDialog(context);
                                  pr.style(message: "正在验证账号信息，请耐心等待～");
                                  await pr.show();
                                  await CourseRepository
                                      .fetchCourseEryaDataList(
                                          school: schoolController.text,
                                          username: accountController.text,
                                          password: passwordController.text);
                                  await pr.hide();
                                  pr.dismiss();
                                  Navigator.pushNamed(
                                      context, RouteName.webView,
                                      arguments: [
                                        '普通系统',
                                        "https://xiaoyuanzhuan.finerit.com/webapp/pages/course/erya/index/?session_token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
                                      ]);
                                } catch (e) {
                                  Future.microtask(
                                      () => {showToast("信息有误，请检查账号信息")});
                                } finally {
                                  await pr.hide();
                                  pr.dismiss();
                                }
                              }
                              break;
                          }
                        },
                      ),
                    )
                  : Container(),
            ],
            centerTitle: false,
            title: Text(
              widget.types[2] == CourseHandscraftType.no
                  ? (widget.types[1] == CourseAutomationType.single
                      ? "自助代课"
                      : "自助代课(批量)")
                  : "人工代课",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Theme.of(context).primaryColor,
                              hintColor: Colors.blue,
                              scaffoldBackgroundColor: Colors.blue),
                          child: TextField(
                            readOnly: true,
                            style: TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black54),
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 4),
                                border: OutlineInputBorder()),
                            controller: platformController,
                            onChanged: (result) {},
                          ),
                        ),
                      ),
                      (widget.types[2] == CourseHandscraftType.type1 ||
                                  widget.types[2] ==
                                      CourseHandscraftType.type2) ||
                              widget.types[1] == CourseAutomationType.multiple
                          ? Column(
                              children: <Widget>[
                                SizedBox(height: 10),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Theme(
                                    data: ThemeData(
                                        primaryColor:
                                            Theme.of(context).primaryColor,
                                        hintColor: Colors.blue,
                                        scaffoldBackgroundColor: Colors.blue),
                                    child: TextField(
                                      // textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: "学校（手机登录勿填）",
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 2.0, horizontal: 4),
                                          border: OutlineInputBorder()),
                                      controller: schoolController,
                                      onChanged: (result) {},
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Theme(
                                    data: ThemeData(
                                        primaryColor:
                                            Theme.of(context).primaryColor,
                                        hintColor: Colors.blue,
                                        scaffoldBackgroundColor: Colors.blue),
                                    child: TextField(
                                      // textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: "账号",
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 2.0, horizontal: 4),
                                          border: OutlineInputBorder()),
                                      controller: accountController,
                                      onChanged: (result) {},
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Theme(
                                    data: ThemeData(
                                        primaryColor:
                                            Theme.of(context).primaryColor,
                                        hintColor: Colors.blue,
                                        scaffoldBackgroundColor: Colors.blue),
                                    child: TextField(
                                      // textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: "密码",
                                          hintStyle:
                                              TextStyle(color: Colors.black54),
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 2.0, horizontal: 4),
                                          border: OutlineInputBorder()),
                                      controller: passwordController,
                                      onChanged: (result) {},
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  onPressed: () {
                                    switch (widget.types[0]) {
                                      case CourseType.zhihuishu:
                                        globalModel.fetchCourseZhihuishuList(
                                            context,
                                            school:
                                                schoolController.text != null &&
                                                        schoolController.text
                                                                .trim() !=
                                                            ""
                                                    ? schoolController.text
                                                    : null,
                                            username: accountController.text,
                                            password: passwordController.text);
                                        break;
                                      case CourseType.erya:
                                        if (globalModel != null) {
                                          globalModel.fetchCourseEryaList(
                                              context,
                                              school: schoolController.text !=
                                                          null &&
                                                      schoolController.text
                                                              .trim() !=
                                                          ""
                                                  ? schoolController.text
                                                  : null,
                                              username: accountController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                        break;
                                    }
                                    switch (widget.types[2]) {
                                      case CourseHandscraftType.type1:
                                        globalModel.fetchCourseRG1List(context,
                                            school:
                                                schoolController.text != null &&
                                                        schoolController.text
                                                                .trim() !=
                                                            ""
                                                    ? schoolController.text
                                                    : null,
                                            account: accountController.text,
                                            password: passwordController.text,
                                            platformId: widget.types[3].name);
                                        break;
                                      case CourseHandscraftType.type2:
                                        if (globalModel != null) {
                                          globalModel.fetchCourseRG2List(
                                              context,
                                              school: schoolController.text !=
                                                          null &&
                                                      schoolController.text
                                                              .trim() !=
                                                          ""
                                                  ? schoolController.text
                                                  : null,
                                              account: accountController.text,
                                              password: passwordController.text,
                                              platformId: widget.types[3].id);
                                        }
                                        break;
                                    }
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: 40,
                                    child: Center(
                                      child: globalModel.busy
                                          ? SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.white),
                                              ),
                                            )
                                          : Text(
                                              "查询",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                    ),
                                  ),
                                  color: Colors.blue[400],
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(height: 10),
                      widget.types[0] != CourseType.erya &&
                              widget.types[2] == CourseHandscraftType.no
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Radio(
                                        value: 0,
                                        groupValue: globalModel.zhihuishuType,
                                        onChanged: (int value) {
                                          globalModel.zhihuishuType = value;
                                          globalModel.notifyListeners();
                                        },
                                      ),
                                      Text("每日学习25分钟")
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Radio(
                                        value: 1,
                                        groupValue: globalModel.zhihuishuType,
                                        onChanged: (int value) {
                                          globalModel.zhihuishuType = value;
                                          globalModel.notifyListeners();
                                        },
                                      ),
                                      Text("一次性刷完")
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: Text(
                          "选择课程",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10),
                      (widget.types[2] == CourseHandscraftType.type2 ||
                              widget.types[2] == CourseHandscraftType.type1)
                          ?
                          //人工代课1，2
                          Builder(
                              builder: (BuildContext context) {
                                if (globalModel.busy) {
                                  return ViewStateBusyWidget();
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          itemCount: widget.types[2] ==
                                                  CourseHandscraftType.type2
                                              ? globalModel
                                                  .displayCourseRG2List.length
                                              : globalModel
                                                  .displayCourseRG1List.length,
                                          itemExtent: 40,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    switch (widget.types[2]) {
                                                      case CourseHandscraftType
                                                          .type1:
                                                        globalModel
                                                                .displayCourseRG1List[
                                                                    index]
                                                                .isSelected =
                                                            !globalModel
                                                                .displayCourseRG1List[
                                                                    index]
                                                                .isSelected;
                                                        globalModel
                                                            .notifyListeners();
                                                        break;
                                                      case CourseHandscraftType
                                                          .type2:
                                                        globalModel
                                                                .displayCourseRG2List[
                                                                    index]
                                                                .isSelected =
                                                            !globalModel
                                                                .displayCourseRG2List[
                                                                    index]
                                                                .isSelected;
                                                        globalModel
                                                            .notifyListeners();
                                                        break;
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      (widget.types[2] ==
                                                                  CourseHandscraftType
                                                                      .type2
                                                              ? globalModel
                                                                  .displayCourseRG2List[
                                                                      index]
                                                                  .isSelected
                                                              : globalModel
                                                                  .displayCourseRG1List[
                                                                      index]
                                                                  .isSelected)
                                                          ? Icon(
                                                              Icons
                                                                  .radio_button_checked,
                                                              color:
                                                                  Colors.blue,
                                                              size: 14,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_unchecked,
                                                              color:
                                                                  Colors.white,
                                                              size: 14,
                                                            ),
                                                      SizedBox(width: 10),
                                                      Text(widget.types[2] ==
                                                              CourseHandscraftType
                                                                  .type2
                                                          ? globalModel
                                                              .displayCourseRG2List[
                                                                  index]
                                                              .data
                                                          : globalModel
                                                              .displayCourseRG1List[
                                                                  index]
                                                              .data),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      )),
                                );
                              },
                            )
                          //智慧树尔雅自动刷课
                          : Builder(
                              builder: (BuildContext context) {
                                if (globalModel.busy) {
                                  return ViewStateBusyWidget();
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.builder(
                                          itemCount: widget.types[0] ==
                                                  CourseType.zhihuishu
                                              ? globalModel
                                                  .displayCourseZhihuishuList
                                                  .length
                                              : globalModel
                                                  .displayCourseEryaList.length,
                                          itemExtent: 40,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    switch (widget.types[0]) {
                                                      case CourseType.zhihuishu:
                                                        globalModel
                                                                .displayCourseZhihuishuList[
                                                                    index]
                                                                .isSelected =
                                                            !globalModel
                                                                .displayCourseZhihuishuList[
                                                                    index]
                                                                .isSelected;
                                                        globalModel
                                                            .notifyListeners();
                                                        break;
                                                      case CourseType.erya:
                                                        globalModel
                                                                .displayCourseEryaList[
                                                                    index]
                                                                .isSelected =
                                                            !globalModel
                                                                .displayCourseEryaList[
                                                                    index]
                                                                .isSelected;
                                                        globalModel
                                                            .notifyListeners();
                                                        break;
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      (widget.types[0] ==
                                                                  CourseType
                                                                      .zhihuishu
                                                              ? globalModel
                                                                  .displayCourseZhihuishuList[
                                                                      index]
                                                                  .isSelected
                                                              : globalModel
                                                                  .displayCourseEryaList[
                                                                      index]
                                                                  .isSelected)
                                                          ? Icon(
                                                              Icons
                                                                  .radio_button_checked,
                                                              color:
                                                                  Colors.blue,
                                                              size: 14,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .radio_button_unchecked,
                                                              color:
                                                                  Colors.white,
                                                              size: 14,
                                                            ),
                                                      Text(widget.types[0] ==
                                                              CourseType
                                                                  .zhihuishu
                                                          ? globalModel
                                                              .displayCourseZhihuishuList[
                                                                  index]
                                                              .data
                                                          : globalModel
                                                              .displayCourseEryaList[
                                                                  index]
                                                              .data),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      )),
                                );
                              },
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: () {
                          switch (widget.types[2]) {
                            case CourseHandscraftType.type1:
                              if (globalModel != null) {
                                int count = 0;
                                globalModel.displayCourseRG1List
                                    .forEach((element) {
                                  if (element.isSelected) {
                                    count++;
                                  }
                                });
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: new Text("温馨提示"),
                                        actions: <Widget>[
                                          new FlatButton(
                                            child: new Text("取消"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          new FlatButton(
                                            child: new Text("确认"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              globalModel.submitCourseRG1(
                                                  context,
                                                  school: schoolController
                                                                  .text !=
                                                              null &&
                                                          schoolController.text
                                                                  .trim() !=
                                                              ""
                                                      ? schoolController.text
                                                      : null,
                                                  account:
                                                      accountController.text,
                                                  password:
                                                      passwordController.text,
                                                  platformId:
                                                      widget.types[3].name);
                                            },
                                          ),
                                        ],
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                                "是否确认提交订单，这将扣除${formatNum(double.parse(widget.types[3].currentPrice) * count, 2)}元。")
                                          ],
                                        ));
                                  },
                                );
                              }
                              break;
                            case CourseHandscraftType.type2:
                              if (globalModel != null) {
                                  int count = 0;
                                  globalModel.displayCourseRG2List
                                      .forEach((element) {
                                    if (element.isSelected) {
                                      count++;
                                    }
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: new Text("温馨提示"),
                                          actions: <Widget>[
                                            new FlatButton(
                                              child: new Text("取消"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            new FlatButton(
                                              child: new Text("确认"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                globalModel.submitCourseRG2(
                                                    context,
                                                    school: schoolController
                                                                    .text !=
                                                                null &&
                                                            schoolController
                                                                    .text
                                                                    .trim() !=
                                                                ""
                                                        ? schoolController.text
                                                        : null,
                                                    account:
                                                        accountController.text,
                                                    password:
                                                        passwordController.text,
                                                    platformId:
                                                        widget.types[3].id);
                                              },
                                            ),
                                          ],
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                  "是否确认提交订单，将扣除${formatNum(double.parse(widget.types[3].currentPrice) * count, 2)}元。")
                                            ],
                                          ));
                                    },
                                  );
                                }
                                break;
                              }
                              switch (widget.types[0]) {
                                case CourseType.zhihuishu:
                                  if (globalModel != null) {
                                    int count = 0;
                                    globalModel.displayCourseZhihuishuList
                                        .forEach((element) {
                                      if (element.isSelected) {
                                        count++;
                                      }
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: new Text("温馨提示"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("取消"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text("确认"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  globalModel
                                                      .submitCourseZhihuishu(
                                                    context,
                                                    school: schoolController
                                                                    .text !=
                                                                null &&
                                                            schoolController
                                                                    .text
                                                                    .trim() !=
                                                                ""
                                                        ? schoolController.text
                                                        : null,
                                                    account:
                                                        accountController.text,
                                                    password:
                                                        passwordController.text,
                                                  );
                                                },
                                              ),
                                            ],
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                    "是否确认提交订单，这将扣除${formatNum(double.parse(widget.types[3].currentPrice) * count, 2)}元。")
                                              ],
                                            ));
                                      },
                                    );
                                  }
                                  break;
                                case CourseType.erya:
                                  if (globalModel != null) {
                                    int count = 0;
                                    globalModel.displayCourseEryaList
                                        .forEach((element) {
                                      if (element.isSelected) {
                                        count++;
                                      }
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: new Text("温馨提示"),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("取消"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              new FlatButton(
                                                child: new Text("确认"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  globalModel.submitCourseErya(
                                                      context,
                                                      school: schoolController
                                                                      .text !=
                                                                  null &&
                                                              schoolController
                                                                      .text
                                                                      .trim() !=
                                                                  ""
                                                          ? schoolController
                                                              .text
                                                          : null,
                                                      account: accountController
                                                          .text,
                                                      password:
                                                          passwordController
                                                              .text);
                                                },
                                              ),
                                            ],
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                    "是否确认提交订单，这将扣除${formatNum(double.parse(widget.types[3].currentPrice) * count, 2)}元。")
                                              ],
                                            ));
                                      },
                                    );
                                  }
                                  break;
                              }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 40,
                          child: Center(
                            child: globalModel.busy
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : Text(
                                    "提交订单",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                          ),
                        ),
                        color: Colors.blue[400],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    }
  }
}
