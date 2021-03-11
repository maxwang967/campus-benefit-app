import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/config/constants.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/auth_utils.dart';
import 'package:campus_benefit_app/core/utils/chat_utils.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/ui/icons/icons_route5.dart';
import 'package:campus_benefit_app/ui/icons/my_flutter_app_icons.dart';
import 'package:campus_benefit_app/ui/widgets/banner_widget.dart';
import 'package:campus_benefit_app/ui/widgets/image_widget.dart';
import 'package:campus_benefit_app/ui/widgets/my_card.dart';
import 'package:campus_benefit_app/ui/widgets/sliver_persistent_header.dart';
import 'package:campus_benefit_app/view_models/base/login_model.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/base/user_model.dart';
import 'package:campus_benefit_app/view_models/user/user_page_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel userModel;
  EarnSumDataModel earnSumDataModel;

  @override
  void initState() {
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
//    userModel = Provider.of<UserModel>(context);
//    earnSumDataModel = Provider.of<EarnSumDataModel>(context);
//    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);

    return Consumer3<UserModel,SystemStaticModel,EarnSumDataModel>(
      builder: (BuildContext context, UserModel userModel,SystemStaticModel staticModel,EarnSumDataModel earnSumDataModel, Widget child) {

        if (staticModel.busy||earnSumDataModel.busy) {
          return ViewStateBusyWidget();
        } else if (staticModel.error) {
          return ViewStateErrorWidget(
              error: staticModel.viewStateError, onPressed: staticModel.initData);
        }else if (earnSumDataModel.error) {
          return ViewStateErrorWidget(
              error: earnSumDataModel.viewStateError, onPressed: earnSumDataModel.initData);
        }
        if (loading == false) {
          userModel.refreshUserInfo();
          earnSumDataModel.reload();
          loading = true;
        }
        return Scaffold(
            key: UniqueKey(),
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                actions: <Widget>[],
              ),
              preferredSize: Size.fromHeight(30),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    ProviderWidget<LoginModel>(
                        model: LoginModel(Provider.of(context)),
                        builder: (context, model, child) {
                          return SizedBox.shrink();
                        })
                  ],
                  backgroundColor: Colors.white,
                  expandedHeight: 90,
                  centerTitle: true,
                  flexibleSpace: Column(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (StorageManager.sharedPreferences
                                .getBool(Config.IS_LOGIN_KEY) ==
                                null ||
                                StorageManager.sharedPreferences
                                    .getBool(Config.IS_LOGIN_KEY) ==
                                    false)
                              Navigator.pushNamed(context, RouteName.login)
                                  .then((result) {
                                if (result) {
                                  userModel.refreshUserInfo();
                                }
                              });
                          },
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: ClipOval(
                                            child: WrapperImage(
                                              url: staticModel.systemStaticInfo.myPageData.headImg,
                                              width: 80,
                                              height: 80,
                                            )),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 6),
                                            child: Text(
                                              userModel.user == null
                                                  ? "去登录"
                                                  : userModel.user.userinfo.phone,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              child: Text(
                                                "${staticModel.systemStaticInfo.myPageData.point}",
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  pinned: false,
                ),
                SliverPersistentHeader(
                  pinned: false,
                  delegate: SliverAppBarDelegate(
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  ErrorUtils.auth401Error(context, () {
                                    Navigator.pushNamed(context, RouteName.userDistribution);
                                  });
                                },
                                child: Container(
                                  width: (MediaQuery.of(context).size.width -
                                      30 -
                                      16) /
                                      2,
                                  child: MyCard(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  12, 12, 12, 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "分销 ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.black87),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  12, 4, 12, 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "盈利 ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black45),
                                                  ),
                                                  Text(
                                                      "${earnSumDataModel.earnSumData == null ? "0.00" : earnSumDataModel.earnSumData.earnSum}",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14)),
                                                  Text(" 元",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 14))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  ErrorUtils.auth401Error(context, () {
                                    Navigator.pushNamed(
                                        context, RouteName.userWalletRMB);
                                  });
                                },
                                child: Container(
                                  width: (MediaQuery.of(context).size.width -
                                      30 -
                                      16) /
                                      2,
                                  child: MyCard(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  12, 12, 12, 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "钱包 ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                        color: Colors.black87),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  12, 4, 12, 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "余额 ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black45),
                                                  ),
                                                  Text(
                                                      "${userModel.user == null ? 0 : userModel.user.userinfo.money}",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14)),
                                                  Text(" 元",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 14))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      100),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Gaps.vGap8,
                        _buildBanner(),
                        Gaps.vGap16,
                        AspectRatio(
                          aspectRatio: 2.9,
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
                                            Text("我的收入",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                            GestureDetector(
                                              onTap: () {
                                                ErrorUtils.auth401Error(
                                                    context, () {
                                                  Navigator.pushNamed(context, RouteName.userDistributionDetail);
                                                });
                                              },
                                              child: Text("查看详情",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                            ),
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "${earnSumDataModel.earnSumData == null ? "0.00" : earnSumDataModel.earnSumData.yesterdaySum}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "昨日收入",
                                              style:
                                              TextStyle(color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            width: 0.8,
                                            height: 35,
                                            color: Colors.white),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "${earnSumDataModel.earnSumData == null ? "0.00" : earnSumDataModel.earnSumData.daySum}",
                                              style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "今日收入",
                                              style:
                                              TextStyle(color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            width: 0.8,
                                            height: 35,
                                            color: Colors.white),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "${earnSumDataModel.earnSumData == null ? "0.00" : earnSumDataModel.earnSumData.mouthSum}",
                                              style: TextStyle(
                                                  color: Colors.greenAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "本月收入",
                                              style:
                                              TextStyle(color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(top: 8),
                  sliver: UserListWidget(),
                ),
              ],
            ));
      },

    );

  }

  Widget _buildBanner() {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: PhysicalModel(
        color: Colors.white, //设置背景底色透明
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias, //注意这个属性
        child: BannerWidget(
          list: staticModel.systemStaticInfo.myPageData.cardPage,
          height: 70,
        ),
      ),
    );
  }
}

class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginModel>(
      model: LoginModel(Provider.of(context)),
      builder: (BuildContext context, LoginModel loginModel, Widget child) {
        return ListTileTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          child: SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "开通会员",
                          style: TextStyle(fontSize: 16),
                        ),
                        MyFlutterApp5.vip,
                      ),
                      onTap: () {
                        ErrorUtils.auth401Error(context, () {
                          Navigator.pushNamed(
                              context, RouteName.userVipInfo);
                        });
                      },
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "联系我们",
                          style: TextStyle(fontSize: 16),
                        ),
                        MyFlutterApp.kefu,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.appInfo);
                      },
                    ),
                    // ListTile(
                    //   title: ListTileCustom(
                    //     Text(
                    //       "收入排行",
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //     MyFlutterApp.location,
                    //   ),
                    //   onTap: () async {},
                    // ),
                    // Divider(height: 0),
//                    kIsWeb
//                        ? Container()
//                        : ListTile(
//                            title: ListTileCustom(
//                              Text(
//                                "联系我们",
//                                style: TextStyle(fontSize: 16),
//                              ),
//                              MyFlutterApp.kefu,
//                            ),
//                            onTap: () async {
//                              ChatUtils.qqChat(context);
//                            },
//                          ),
                    Divider(height: 0),
                    kIsWeb
                        ? Container()
                        : ListTile(
                            title: ListTileCustom(
                              Text(
                                "分享APP",
                                style: TextStyle(fontSize: 16),
                              ),
                              MyFlutterApp.share,
                            ),
                            onTap: () async {
                              SystemStaticModel model = Provider.of<SystemStaticModel>(context);
                              ChatUtils.shareGrid(context
                                  ,url: model.systemStaticInfo.myPageData.share.url
                                  ,title: model.systemStaticInfo.myPageData.share.title
                                  ,content: model.systemStaticInfo.myPageData.share.content);
                            },
                          ),
                    Divider(height: 0),
                    ListTile(
                      title: ListTileCustom(
                        Text(
                          "APP官网",
                          style: TextStyle(fontSize: 16),
                        ),
                        MyFlutterApp.logo,
                      ),
                      onTap: () async {
                        var model = Provider.of<SystemStaticModel>(context);
                        if (kIsWeb) {
                          Navigator.pushNamed(context, RouteName.webView,
                              arguments: [
                                "APP官网",
                                "${model.systemStaticInfo.myPageData.website}"
                              ]);
                        } else {
                          if (await canLaunch(
                              model.systemStaticInfo.myPageData.website)) {
                            await launch(
                                model.systemStaticInfo.myPageData.website);
                          } else {
                            throw 'Could not launch ${model.systemStaticInfo.myPageData.website}';
                          }
                        }
                      },
                    ),
                    Divider(height: 0),

                    loginModel.userModel.user != null
                        ? ListTile(
                            title: ListTileCustom(
                              Text(
                                "修改密码",
                                style: TextStyle(fontSize: 16),
                              ),
                              MyFlutterApp.lock,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.changePassword);
                            },
                          )
                        : Container(),
                    Divider(height: 0),
                    loginModel.userModel.user != null
                        ? ListTile(
                            title: ListTileCustom(
                              Text(
                                "切换账号",
                                style: TextStyle(fontSize: 16),
                              ),
                              MyFlutterApp.alter,
                            ),
                            onTap: () {
                              loginModel.logout();
                              Navigator.pushNamed(context, RouteName.login);
                            },
                          )
                        : Container(),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }
}

class ListTileCustom extends StatelessWidget {
  final Text title;
  final IconData icon;

  const ListTileCustom(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                this.icon,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              SizedBox(
                height: 40,
                width: 5,
              ),
              this.title,
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Icon(Icons.chevron_right)],
            ),
          )
        ],
      ),
    );
  }
}
