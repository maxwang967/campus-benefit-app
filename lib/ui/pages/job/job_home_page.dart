import 'dart:ui';

import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/ui/widgets/banner_widget.dart';
import 'package:campus_benefit_app/ui/widgets/image_widget.dart';
import 'package:campus_benefit_app/ui/widgets/qqz_base_task_card_detail.dart';
import 'package:campus_benefit_app/ui/widgets/search_bar.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/job/job_page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobHomePage extends StatefulWidget {
  @override
  _JobHomePageState createState() => _JobHomePageState();
}

class _JobHomePageState extends State<JobHomePage> {
  TextEditingController textEditingController = TextEditingController();
  bool loading = false;
  @override
  void initState() {
    loading = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<SystemStaticModel, BaseQQZJobDataListModel>(
      builder: (BuildContext context, SystemStaticModel systemStaticModel,
          BaseQQZJobDataListModel qqzJobDataListModel, _) {
        if (loading == false) {
          qqzJobDataListModel.search = '';
          qqzJobDataListModel.refresh();
          loading = true;
        }
        if (systemStaticModel.busy || qqzJobDataListModel.busy) {
          return ViewStateBusyWidget();
        } else if (qqzJobDataListModel.error) {
          return ViewStateEmptyWidget(onPressed: qqzJobDataListModel.initData);
        } 
        return Scaffold(
          backgroundColor: Colors.white,
            body: SmartRefresher(
          controller: qqzJobDataListModel.refreshController,
          onRefresh: qqzJobDataListModel.refresh,
          enablePullUp: true,
          enablePullDown: false,
          onLoading: qqzJobDataListModel.loadMore,
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              flexibleSpace: Container(
                padding: EdgeInsets.only(
                  left: 12,
                  bottom: 12,
                  right: 12,
                  top: MediaQueryData.fromWindow(window).padding.top + 12,
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
                      controller: textEditingController,
                    )),
                    GestureDetector(
                      child: new Container(
                        alignment: Alignment(0, 0),
                        margin: EdgeInsets.only(left: 12),
                        height: 32,
                        child: Text("搜索",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                      ),
                      onTap: () {
                        qqzJobDataListModel.search = textEditingController.text;
                        textEditingController.clear();
                        qqzJobDataListModel.refresh();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 12, right: 12, top: 0),
              sliver: SliverGrid.count(
                childAspectRatio: 0.9,
                crossAxisCount: 4,
                children: systemStaticModel.systemStaticInfo.homePageData.cateTypes
                    .map((product) {
                  return GestureDetector(
                      onTap: () {
                        if(product.isWeb==true){
                          Navigator.pushNamed(context, RouteName.webView,arguments: [product.nav,'${product.name}']);
                        }
                        else{
                          try{
                            Navigator.pushNamed(context, '${product.nav}');
                          } catch (e) {
                            systemStaticModel.jumpTabPageTo(int.parse(product.nav));
                          }
                        }

                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[

                            Container(
                              child: ClipOval(
                                  child: WrapperImage(
                                    url: product.image,
                                    width: 60,
                                    height: 60,
                                  )),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              child: Text(
                                product.name,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                          ],
                        ),
                      )
                      );
                }).toList(),
              ),

            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: PhysicalModel(
                  color: Colors.white, //设置背景底色透明
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.antiAlias, //注意这个属性
                  child: BannerWidget(
                    list: systemStaticModel.systemStaticInfo.homePageData.swiperPage,
                    height: 70,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12, top: 4, bottom: 4),
                child: Text(
                  "任务推荐",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return QQZBaseTaskCardDetail(
                    qqzJobDataListModel.list[index],
                  );
                },
                childCount: qqzJobDataListModel.list.length,
              ),
            )
          ]),
        ));
      },
    );
  }
}
