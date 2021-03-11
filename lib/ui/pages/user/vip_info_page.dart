import 'dart:io';

import 'package:campus_benefit_app/core/nets/handler.dart';
import 'package:campus_benefit_app/core/nets/net_message.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/service/wallet_repository.dart';
import 'package:campus_benefit_app/ui/icons/icons_route4.dart';
import 'package:campus_benefit_app/ui/widgets/hint_widget.dart';
import 'package:campus_benefit_app/ui/widgets/vip_discript_widget.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/base/user_model.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class VIPDredgePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VIPDredgePageState();
}

class VIPDredgePageState extends State<VIPDredgePage> {
  bool vipType = false;
  UserModel userModel;
  SystemStaticModel staticModel;
  bool loading = false;
  void changeType(bool type) {
    setState(() {
      vipType = type;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userModel = Provider.of<UserModel>(context);
    staticModel = Provider.of<SystemStaticModel>(context);
    if (loading == false) {
      loading = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black87,
        ),
        title: Text(
          "开通会员",
          style: TextStyle(color: Colors.grey[800]),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(userModel.user.userinfo.headImg),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(35.0)),
                          border: Border.all(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(left: 5),
                    child: Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Text(userModel.user.userinfo.phone,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            Container(
                              margin: EdgeInsets.only(left: 0, top: 0),
                              child: VipDiscriptWidget(
                                iconsize: 0.4,
                                isAnnual:
                                    userModel.user.vipuserinfo.isAnnual,
                                isOpening:
                                    userModel.user.vipuserinfo.isOpening,
                              ),
                            ),

                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(width: 2,),
                            new Text(
                                '到期时间：${userModel.user.vipuserinfo.endTime.split(' ')[0]}',
                                style:
                                TextStyle(color: Colors.black26, fontSize: 12)),
                          ],
                        ),
                        new Row(
                          children: <Widget>[

                            Text(
                              '余额：${userModel.user.userinfo.money.toString()}元',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: Colors.grey[100],
            ),
            new Container(
              child: Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(top: 12),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/images/vipMonth.png'),
                              width: 60,
                              height: 60,
                            ),
                            Text(
                              "开通1个月vip",
                              style: TextStyle(fontSize: 14),
                            ),
                            new GestureDetector(
                              onTap: () {
                                changeType(false);
                              },
                              child: new Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 100,
                                height: 120,
                                decoration: vipType == false
                                    ? new BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.lightBlueAccent.withOpacity(0.2),
                                            spreadRadius: 2.0,
                                            blurRadius: 3.0,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.lightBlueAccent.withOpacity(0.4),
                                          width: 0.8,
                                          style: BorderStyle.solid,
                                        ))
                                    : BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 0.8,
                                          style: BorderStyle.solid,
                                        )),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "1个月",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Container(
                                      child: Divider(
                                        color:  vipType == false?Colors.lightBlueAccent.withOpacity(0.4):Colors.black12,
                                        height: 10,
                                      ),
                                    ),
                                    Text(
                                        '${staticModel.systemStaticInfo.myPageData.vipPage.vipPrice.toString()}',
                                        style: TextStyle(fontSize: 30,color: Colors.deepOrange)),
                                    Text(
                                        " ${staticModel.systemStaticInfo.myPageData.vipPage.beforeVipPrice.toString()} ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.black38,
                                        )),
                                    Text("元"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/images/vipYear.png'),
                              width: 60,
                              height: 60,
                            ),
                            Text(
                              "开通1年vip",
                              style: TextStyle(fontSize: 14),
                            ),
                            new GestureDetector(
                              onTap: () {
                                changeType(true);
                              },
                              child: new Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 100,
                                height: 120,
                                decoration: vipType
                                    ? new BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.lightBlueAccent.withOpacity(0.2),
                                            spreadRadius: 4.0,
                                            blurRadius: 5.0,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:  Colors.lightBlueAccent.withOpacity(0.4),
                                          width: 0.8,
                                          style: BorderStyle.solid,
                                        ))
                                    : BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.grey[300],
                                          width: 0.8,
                                          style: BorderStyle.solid,
                                        )),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "1年",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Container(
                                      child: Divider(
                                        color:  !vipType == false?Colors.lightBlueAccent.withOpacity(0.4):Colors.black12,
                                        height: 10,
                                      ),
                                    ),
                                    Text(
                                        staticModel.systemStaticInfo.myPageData
                                            .vipPage.yearVipPrice
                                            .toString(),
                                        style: TextStyle(fontSize: 30,color: Colors.deepOrange)),
                                    Text(
                                        " ${staticModel.systemStaticInfo.myPageData.vipPage.beforeYearVipPrice.toString()} ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black38,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.black38,
                                        )),
                                    Text("元"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  new Container(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                '',
                style: TextStyle(color: Colors.redAccent, fontSize: 15),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  new GestureDetector(
                    child: new Container(
                      margin: EdgeInsets.only(left: 45),
                      padding:
                          EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 5),
                      child: Text("前往充值",
                          style: TextStyle(fontSize: 18, color: Colors.lightBlueAccent)),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.lightBlueAccent,
                            style: BorderStyle.solid,
                            width: 1),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onTap: () {
                      navToMoneyPage();
                    },
                  ),
                  new Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          toPay();
                        },
                        child: new Container(
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 4, bottom: 5),
                          child: Text(
                            "立刻支付:${vipType ? staticModel.systemStaticInfo.myPageData.vipPage.yearVipPrice : staticModel.systemStaticInfo.myPageData.vipPage.vipPrice}元",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          ]..addAll(buidHind()),
        ),
      ),
    );
  }

  void navToMoneyPage() {
    Navigator.pushNamed(context, RouteName.userWalletRMB);
  }

  void toPay() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, a, b) => AlertDialog(
        title: Text(
          '开通VIP',
          style: TextStyle(fontSize: 16),
        ),
        content: Container(
          child: Container(
            child: Text(
                "开通此类型VIP将要扣除${vipType ? staticModel.systemStaticInfo.myPageData.vipPage.yearVipPrice : staticModel.systemStaticInfo.myPageData.vipPage.vipPrice}元，确定开通吗？"),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('取消'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('确认'),
            onPressed: () async {
              if (vipType) {
                try {
                  await WalletRepository.openYearVip();
                  showToast("开通成功");
                  userModel.refreshUserInfo();
                } catch (e) {
                  // Future.microtask(() {
                  showToast(e.message);
                  // });
                } finally {
                  Navigator.pop(context);
                }
              } else {
                try {
                  await WalletRepository.openVip();
                  showToast("开通成功");
                  userModel.refreshUserInfo();
                } catch (e) {
                  // Future.microtask(() {
                  showToast(e.message);
                  // });
                } finally {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
      barrierDismissible: false,
      barrierLabel: '开通VIP',
      transitionDuration: Duration(milliseconds: 400),
    );
  }

    buidHind(){
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return staticModel.systemStaticInfo.myPageData.vipPage.hint.
        map((e) {
      return HintWidget(title: e.title,subtitle: e.subtitle,content: e.content);
    }).toList();
  }
}

