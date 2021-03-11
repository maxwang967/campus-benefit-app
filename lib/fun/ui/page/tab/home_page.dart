import 'dart:io';

import 'package:flutter/material.dart' hide Banner, showSearch;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:campus_benefit_app/fun/generated/i18n.dart';
import 'package:campus_benefit_app/fun/ui/helper/refresh_helper.dart';
import 'package:campus_benefit_app/fun/ui/widget/skeleton.dart';
import 'package:campus_benefit_app/fun/utils/status_bar_utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:campus_benefit_app/fun/config/router_manger.dart';
import 'package:campus_benefit_app/fun/flutter/search.dart';
import 'package:campus_benefit_app/fun/model/article.dart';
import 'package:campus_benefit_app/fun/provider/provider_widget.dart';
import 'package:campus_benefit_app/fun/view_model/scroll_controller_model.dart';
import 'package:campus_benefit_app/fun/ui/widget/animated_provider.dart';
import 'package:campus_benefit_app/fun/ui/widget/banner_image.dart';
import 'package:campus_benefit_app/fun/provider/view_state_widget.dart';
import 'package:campus_benefit_app/fun/ui/widget/article_list_Item.dart';
import 'package:campus_benefit_app/fun/ui/widget/article_skeleton.dart';
import 'package:campus_benefit_app/fun/view_model/home_model.dart';

import 'package:campus_benefit_app/fun/ui/page/search/search_delegate.dart';

const double kHomeRefreshHeight = 180.0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bannerHeight = MediaQuery.of(context).size.width * 5 / 11;
    return ProviderWidget2<HomeModel, TapToTopModel>(
      model1: HomeModel(),
      // 使用PrimaryScrollController保留iOS点击状态栏回到顶部的功能
      model2: TapToTopModel(PrimaryScrollController.of(context),
          height: bannerHeight - kToolbarHeight),
      onModelReady: (homeModel, tapToTopModel) {
        homeModel.initData();
        tapToTopModel.init();
      },
      builder: (context, homeModel, tapToTopModel, child) {
        return Scaffold(
          body: MediaQuery.removePadding(
              context: context,
              removeTop: false,
              child: Builder(builder: (_) {
                if (homeModel.error) {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: StatusBarUtils.systemUiOverlayStyle(context),
                    child: ViewStateWidget(
                      onPressed: homeModel.initData,
                      message: homeModel.errorMessage,
                    ),
                  );
                }
                return RefreshConfiguration.copyAncestor(
                  context: context,
                  // 下拉触发二楼距离
                  twiceTriggerDistance: kHomeRefreshHeight - 15,
                  //最大下拉距离,android默认为0,这里为了触发二楼
                  maxOverScrollExtent: kHomeRefreshHeight,
                  child: SmartRefresher(
                      controller: homeModel.refreshController,
                      header: HomeRefreshHeader(),
                      enableTwoLevel: homeModel.idle,
                      onTwoLevel: () async {
                        await Navigator.of(context)
                            .pushNamed(RouteName.homeSecondFloor);
                        await Future.delayed(Duration(milliseconds: 300));
                        Provider.of<HomeModel>(context)
                            .refreshController
                            .twoLevelComplete();
                      },
                      footer: RefresherFooter(),
                      enablePullDown: homeModel.idle,
                      onRefresh: homeModel.refresh,
                      onLoading: homeModel.loadMore,
                      enablePullUp: homeModel.list.isNotEmpty,
                      child: CustomScrollView(
                        controller: tapToTopModel.scrollController,
                        slivers: <Widget>[
                          SliverToBoxAdapter(),
                          SliverAppBar(
                            // 加载中并且亮色模式下,状态栏文字为黑色
                            brightness: Theme.of(context).brightness ==
                                        Brightness.light &&
                                    homeModel.busy
                                ? Brightness.light
                                : Brightness.dark,
                            actions: <Widget>[
                              EmptyAnimatedSwitcher(
                                display: tapToTopModel.showTopBtn,
                                child: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    showSearch(
                                        context: context,
                                        delegate: DefaultSearchDelegate());
                                  },
                                ),
                              ),
                            ],
                            flexibleSpace: FlexibleSpaceBar(
                              background: BannerWidget(),
                              centerTitle: true,
                              title: GestureDetector(
                                onDoubleTap: tapToTopModel.scrollToTop,
                                child: EmptyAnimatedSwitcher(
                                  display: tapToTopModel.showTopBtn,
                                  child: Text(Platform.isIOS
                                      ? '校园赚'
                                      : S.of(context).appName),
                                ),
                              ),
                            ),
                            expandedHeight: bannerHeight,
                            pinned: true,
                          ),
                          if (homeModel.empty)
                            SliverToBoxAdapter(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: ViewStateEmptyWidget(
                                  onPressed: homeModel.initData),
                            )),
                          if (homeModel.idle) HomeTopArticleList(),
                          HomeArticleList(),
                        ],
                      )),
                );
              })),
          floatingActionButton: ScaleAnimatedSwitcher(
            child: tapToTopModel.showTopBtn &&
                    homeModel.refreshController.headerStatus !=
                        RefreshStatus.twoLevelOpening
                ? FloatingActionButton(
                    heroTag: 'homeEmpty',
                    key: ValueKey(Icons.vertical_align_top),
                    onPressed: () {
                      tapToTopModel.scrollToTop();
                    },
                    child: Icon(
                      Icons.vertical_align_top,
                    ),
                  )
                : FloatingActionButton(
                    heroTag: 'homeFab',
                    key: ValueKey(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: DefaultSearchDelegate());
                    },
                    child: Icon(
                      Icons.search,
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Consumer<HomeModel>(builder: (_, homeModel, __) {
        if (homeModel.busy) {
          return CupertinoActivityIndicator();
        } else {
          var banners = homeModel?.banners ?? [];
          return Swiper(
            loop: true,
            autoplay: true,
            autoplayDelay: 5000,
            pagination: SwiperPagination(),
            itemCount: banners.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                  onTap: () {
                    var banner = banners[index];
                    Navigator.of(context).pushNamed(RouteName.articleDetail,
                        arguments: Article()
                          ..id = banner.id
                          ..title = banner.title
                          ..link = banner.url
                          ..collect = false);
                  },
                  child: BannerImage(banners[index].imagePath));
            },
          );
        }
      }),
    );
  }
}

class HomeTopArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Article item = homeModel.topArticles[index];
          return ArticleItemWidget(
            item,
            index: index,
            top: true,
          );
        },
        childCount: homeModel.topArticles?.length ?? 0,
      ),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeModel homeModel = Provider.of(context);
    if (homeModel.busy) {
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => ArticleSkeletonItem(),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Article item = homeModel.list[index];
          return ArticleItemWidget(
            item,
            index: index,
          );
        },
        childCount: homeModel.list?.length ?? 0,
      ),
    );
  }
}
