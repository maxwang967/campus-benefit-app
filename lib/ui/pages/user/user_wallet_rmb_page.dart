import 'dart:async';
import 'dart:html'
    if (dart.library.io) 'package:campus_benefit_app/core/config/constants.dart'
    show window;
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/navigator_helper.dart';
import 'package:campus_benefit_app/models/pay_order.dart';
import 'package:campus_benefit_app/models/system_static_info.dart';
import 'package:campus_benefit_app/service/wallet_repository.dart';
import 'package:campus_benefit_app/ui/pages/commons/input_text_page.dart';
import 'package:campus_benefit_app/ui/widgets/common_shadow_container.dart';
import 'package:campus_benefit_app/ui/widgets/hint_widget.dart';
import 'package:campus_benefit_app/ui/widgets/my_card.dart';
import 'package:campus_benefit_app/ui/widgets/sliver_persistent_header.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/base/user_model.dart';
import 'package:dio/dio.dart';
import 'package:fake_alipay/fake_alipay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class UserWalletRMBPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserWalletRMBPageState();
}

class _UserWalletRMBPageState extends State<UserWalletRMBPage> {
  Alipay _alipay = Alipay();

  StreamSubscription<AlipayResp> _pay;
  UserModel model;

  @override
  void initState() {
    super.initState();
    _pay = _alipay.payResp().listen(_listenPay);
  }

  void _listenPay(AlipayResp resp) {
    if (resp.resultStatus == 9000) {
      showToast("支付成功！");
      model.refreshUserInfo();
    } else {
      showToast("支付失败:${resp.result}");
    }
  }

  @override
  void dispose() {
    if (_pay != null) {
      _pay.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<UserModel>(context);
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(model),
      ),
    );
  }

  _sliverBuilder(UserModel model) {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    var primaryColor = Theme.of(context).primaryColor;
    return <Widget>[
      SliverAppBar(
        leading: BackButton(),
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1.0,
        expandedHeight: 20.0,
        pinned: true,
        title: Text(
          "账户余额",
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[],
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            Column(
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: null,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 100.0,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "账户余额",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          RouteName.userWalletRMBDetail);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          model.user.userinfo.money.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.35,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Stack(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(14.0),
                                                            child: Align(
                                                              alignment:
                                                                  FractionalOffset
                                                                      .center,
                                                              child: Text("提现"),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: Align(
                                                              alignment:
                                                                  FractionalOffset
                                                                      .centerRight,
                                                              child: FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "取消")),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      new Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            WithdrawNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.withdrawFinerCodeRange[0].toDouble(),
                                                              model: model,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.withdrawFinerCodeRange[1].toDouble(),
                                                              model: model,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.withdrawFinerCodeRange[2].toDouble(),
                                                              model: model,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      new Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            WithdrawNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.withdrawFinerCodeRange[3].toDouble(),
                                                              model: model,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.withdrawFinerCodeRange[4].toDouble(),
                                                              model: model,
                                                            ),
                                                            WithdrawNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.withdrawFinerCodeRange[5].toDouble(),
                                                              model: model,
                                                            ),
                                                          ],
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 60,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(500),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text("提现",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14)),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.35,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Stack(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(14.0),
                                                            child: Align(
                                                              alignment:
                                                                  FractionalOffset
                                                                      .center,
                                                              child: Text("充值"),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: Align(
                                                              alignment:
                                                                  FractionalOffset
                                                                      .centerRight,
                                                              child: FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "取消")),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          child: Text(
                                                            "充值金额仅限云智校使用",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[400]),
                                                          ),
                                                        ),
                                                      ),
                                                      new Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            MoneyPrepaidNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.rechargeFinerCodeRange[0].toDouble(),
                                                              alipay: _alipay,
                                                              model: model,
                                                            ),
                                                            MoneyPrepaidNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.rechargeFinerCodeRange[1].toDouble(),
                                                              alipay: _alipay,
                                                              model: model,
                                                            ),
                                                            MoneyPrepaidNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.rechargeFinerCodeRange[2].toDouble(),
                                                              alipay: _alipay,
                                                              model: model,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      new Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            MoneyPrepaidNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.rechargeFinerCodeRange[3].toDouble(),
                                                              alipay: _alipay,
                                                              model: model,
                                                            ),
                                                            MoneyPrepaidNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.rechargeFinerCodeRange[4].toDouble(),
                                                              alipay: _alipay,
                                                              model: model,
                                                            ),
                                                            MoneyPrepaidNumWidget(
                                                              money: staticModel.systemStaticInfo
                                                                  .myPageData.moneyPage.rechargeFinerCodeRange[5].toDouble(),
                                                              alipay: _alipay,
                                                              model: model,
                                                            ),
                                                          ],
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: 60,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(500),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 1)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text("充值",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14)),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      image: null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                      Icon(Icons.person, color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "提取账户",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("支付宝",
                                    style: TextStyle(color: Colors.white)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Container(),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            150.0),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _WalletHomeBindAccountTab(model),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "规则介绍",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              

            ]..addAll(buidHind()),
          ),
        ),
      )
    ];
  }
  buidHind(){
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return staticModel.systemStaticInfo.myPageData.moneyPage.hint.
        map((e) {
      return HintWidget(title: e.title,subtitle: e.subtitle,content: e.content);
    }).toList();
  }
}


class _WalletHomeBindAccountTab extends StatelessWidget {
  final UserModel model;

  _WalletHomeBindAccountTab(this.model);

  @override
  Widget build(BuildContext context) {
    return CommonShadowContainer(
        child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("绑定支付账户",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  height: 0,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "支付宝账户",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      model.user.withdrawaccount.alyPayAccount,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  NavigatorHelper.pushResult(
                      context,
                      InputTextPage(
                        title: '绑定支付宝账号',
                        hintText: '请填写支付宝账号',
                        textMaxLength: 30,
                        content:
                            model.user.withdrawaccount.alyPayAccount == "未设置"
                                ? ""
                                : model.user.withdrawaccount.alyPayAccount,
                      ), (result) {
                    model.updateUserWithdrawAccount(context,
                        alipayAccount: result);
                  });
                },
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class MoneyPrepaidNumWidget extends StatelessWidget {
  final double money;
  final Alipay alipay;
  UserModel model;
  MoneyPrepaidNumWidget({Key key, this.money, this.alipay, this.model})
      : super();

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () async {
        PayCreateOrder payCreateOrder =
            await WalletRepository.createPayOrder(money);
        PayReadOrder payReadOrder =
            await WalletRepository.readPayOrder(payCreateOrder.id);
        if (kIsWeb) {
           window.location.assign(
            payReadOrder.alipayWebUrl,
            );
          // Navigator.pushNamed(context, RouteName.webView,
          //     arguments: ["完成支付后点击左上角返回", payReadOrder.alipayWebUrl]);

        } else {
          alipay.payOrderSign(
              orderInfo: payReadOrder.alipayUrl, isShowLoading: true);
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(  
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: Colors.amber,
                ),
                Text(
                  "${money}元",
                  style: TextStyle(fontSize: 16),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.25,
      ),
    );
  }
}

class WithdrawNumWidget extends StatelessWidget {
  final double money;
  UserModel model;
  WithdrawNumWidget({Key key, this.money, this.model}) : super();

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        WalletRepository.withdraw(money).then((value) {
          showToast(value['info']);
          model.refreshUserInfo();
        }, onError: (e) {
          showToast(e.message);
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: Colors.amber,
                ),
                Text(
                  "${money}元",
                  style: TextStyle(fontSize: 16),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.25,
      ),
    );
  }
}
