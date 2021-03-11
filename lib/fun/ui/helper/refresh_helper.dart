import 'package:flutter/material.dart';
import 'package:campus_benefit_app/fun/generated/i18n.dart';
import 'package:campus_benefit_app/fun/ui/page/tab/home_second_floor_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 首页列表的header
class HomeRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      canTwoLevelText: S.of(context).refreshTwoLevel,
      textStyle: TextStyle(color: Colors.white),
      outerBuilder: (child) => HomeSecondFloorOuter(child),
      twoLevelView: Container(),
    );
  }
}

/// 通用的footer
///
/// 由于国际化需要context的原因,所以无法在[RefreshConfiguration]配置
class RefresherFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
//      failedText: S.of(context).loadMoreFailed,
//      idleText: S.of(context).loadMoreIdle,
//      loadingText: S.of(context).loadMoreLoading,
//      noDataText: S.of(context).loadMoreNoData,
    );
  }
}
