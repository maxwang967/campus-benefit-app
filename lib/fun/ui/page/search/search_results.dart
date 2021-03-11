import 'package:flutter/material.dart';
import 'package:campus_benefit_app/fun/ui/helper/refresh_helper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:campus_benefit_app/fun/model/article.dart';
import 'package:campus_benefit_app/fun/provider/provider_widget.dart';
import 'package:campus_benefit_app/fun/ui/widget/article_list_Item.dart';
import 'package:campus_benefit_app/fun/provider/view_state_widget.dart';
import 'package:campus_benefit_app/fun/view_model/search_model.dart';

class SearchResults extends StatelessWidget {
  final String keyword;
  final SearchHistoryModel searchHistoryModel;

  SearchResults({this.keyword, this.searchHistoryModel});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SearchResultModel>(
      model: SearchResultModel(
          keyword: keyword, searchHistoryModel: searchHistoryModel),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        if (model.busy) {
          return ViewStateBusyWidget();
        } else if (model.error) {
          return ViewStateWidget(onPressed: model.initData);
        } else if (model.empty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return SmartRefresher(
            controller: model.refreshController,
            header: WaterDropHeader(),
            footer: RefresherFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  Article item = model.list[index];
                  return ArticleItemWidget(item);
                }));
      },
    );
  }
}
