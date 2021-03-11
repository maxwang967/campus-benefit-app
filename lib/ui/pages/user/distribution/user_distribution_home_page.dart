import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/models/system_static_info.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/ui/pages/user/distribution/user_distribution_list_page.dart';
import 'package:campus_benefit_app/ui/widgets/hint_widget.dart';
import 'package:campus_benefit_app/ui/widgets/my_card.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/user/user_page_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserDistributionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserDistributionPageState();
}

class UserDistributionPageState extends State<UserDistributionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("分销"),
          actions: <Widget>[
            kIsWeb
                ? Container()
                : InkWell(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 20, left: 20),
                      child: Container(
                        child: Text(
                          '分享',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    onTap: () async {
                      Navigator.pushNamed(context, RouteName.userSubstation);
                    },
                  )
          ],
        ),
        body: ProviderWidget<UserInviteModel>(
            model: UserInviteModel(),
            onModelReady: (model) {
              model.initData();
            },
            builder: (context, model, child) {
              if (model.busy) {
                return ViewStateBusyWidget();
              } else if (model.error && model.list.isEmpty) {
                return ViewStateErrorWidget(
                    error: model.viewStateError, onPressed: model.initData);
              }
              return Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: ListTileTheme(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "温馨提示",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ]
                        ..addAll(buidHind())
                        ..add(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyCard(
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${model.fatherData.firstNum}",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "累计邀请（人）",
                                          style: TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        width: 0.8,
                                        height: 35,
                                        color: Colors.white),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${model.fatherData.monthAddNum}",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "本月邀请（人）",
                                          style: TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        width: 0.8,
                                        height: 35,
                                        color: Colors.white),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${model.fatherData.monthPayNum}",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "本月消费（人）",
                                          style: TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        // ..add(Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 15.0, vertical: 5),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: <Widget>[
                        //       Text(
                        //         "累计邀请 ",
                        //         style: TextStyle(color: Colors.grey),
                        //       ),
                        //       Text(
                        //         "${model.fatherData.firstNum}",
                        //         style: TextStyle(color: Colors.red),
                        //       ),
                        //       Text(
                        //         " 人",
                        //         style: TextStyle(color: Colors.grey),
                        //       ),
                        //     ],
                        //   ),
                        // ))
                        ..add(SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: UserDistributionListPage())),
                    )),
                  ),
                ],
              );
            }));
  }

  List<Widget> buidHind() {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return staticModel.systemStaticInfo.myPageData.distributionPage.hint
        .map((e) {
      return HintWidget(
          title: e.title, subtitle: e.subtitle, content: e.content);
    }).toList();
  }
}
