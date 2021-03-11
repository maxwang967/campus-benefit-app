import 'package:campus_benefit_app/core/utils/chat_utils.dart';
import 'package:campus_benefit_app/ui/icons/finerit_color.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class AppInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppInfoPageState();
  }
}

class AppInfoPageState extends State<AppInfoPage> {
  List<String> qqWidgetNames = [
    "商务合作",
    "问题咨询",
  ];
  @override
  Widget build(BuildContext context) {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "联系我们",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 12),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 6.0,
                      spreadRadius: 2.0),
                ],
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'QQ交流群 ${staticModel.systemStaticInfo.myPageData.cantactUsPage.qqQun}',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  Container(
                    child: Text('使用问题交流/售后问题处理/内测版发布'),
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    height: 35,
                    child: InkWell(
                      onTap: () {
                        ChatUtils.qqChat(context
                            , number: staticModel.systemStaticInfo.myPageData.cantactUsPage.qqQun
                            ,isGroup: true);
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4.0), //只是为了给 Text 加一个内边距，好看点~
                        child: Text(
                          '点击前往',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        decoration: BoxDecoration(
                          color: FineritColor.login_button,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 0),
                                blurRadius: 6.0,
                                spreadRadius: 2.0),
                          ],
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              margin: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 6.0,
                      spreadRadius: 2.0),
                ],
                borderRadius: BorderRadius.circular(14.0),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 12,
                ),
                child: Column(
                  children: List.generate(
                      staticModel.systemStaticInfo.myPageData.cantactUsPage.cantact.length,
                      (index) => buildQQWidget(
                          {"name": staticModel.systemStaticInfo
                              .myPageData.cantactUsPage.cantact[index].name, "value":
                          staticModel.systemStaticInfo
                              .myPageData.cantactUsPage.cantact[index].qq})),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildQQWidget(var data) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 12),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            color: Colors.blue,
            onPressed: (){

            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[Text(data['name']), Text(data['value'])],
          ),
          Expanded(child: Container()),
          Container(
            width: 80,
            height: 30,
            child: InkWell(
              onTap: () {
                ChatUtils.qqChat(context
                    , number: data['value']
                    ,isGroup: false);
              },
              child: new Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(4.0), //只是为了给 Text 加一个内边距，好看点~
                child: Text(
                  '点击前往',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                decoration: BoxDecoration(
                  color: FineritColor.login_button,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 0),
                        blurRadius: 6.0,
                        spreadRadius: 2.0),
                  ],
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
