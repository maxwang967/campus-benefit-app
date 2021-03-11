import 'package:campus_benefit_app/core/config/constants.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/status_bar_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CourseAccountBindPage extends StatefulWidget {
  final CourseType type;
  const CourseAccountBindPage({Key key, this.type}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CourseAccountBindPageState();
}

class _CourseAccountBindPageState extends State<CourseAccountBindPage> {
  TextEditingController schoolController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    schoolController.dispose();
    accountController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: StatusBarUtils.systemUiOverlayStyle(context),
        child: Scaffold(
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
            ],
            centerTitle: true,
            title: Text(
              widget.type == CourseType.erya ? '学习通' : '知到',
              style: TextStyle(color: Colors.black),
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
                            key: UniqueKey(),
                            // textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "学校（手机登录勿填）",
                                hintStyle: TextStyle(color: Colors.black54),
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 4),
                                border: OutlineInputBorder()),
                            controller: schoolController,
                            onChanged: (result) {},
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Theme.of(context).primaryColor,
                              hintColor: Colors.blue,
                              scaffoldBackgroundColor: Colors.blue),
                          child: TextField(
                            // textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "账号",
                                hintStyle: TextStyle(color: Colors.black54),
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 4),
                                border: OutlineInputBorder()),
                            controller: accountController,
                            onChanged: (result) {},
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Theme.of(context).primaryColor,
                              hintColor: Colors.blue,
                              scaffoldBackgroundColor: Colors.blue),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "密码",
                                hintStyle: TextStyle(color: Colors.black54),
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 4),
                                border: OutlineInputBorder()),
                            controller: passwordController,
                            onChanged: (result) {},
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 40,
                          child: Center(
                            child: Text(
                              "绑定",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        color: Colors.blue[400],
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: () {
                          if (widget.type == CourseType.zhihuishu) {
                          } else if (widget.type == CourseType.erya) {
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 40,
                          child: Center(
                            child: Text(
                              "前往刷课",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
}
