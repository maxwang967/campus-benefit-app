import 'package:campus_benefit_app/fun/model/article.dart';
import 'package:campus_benefit_app/fun/model/tree.dart';
import 'package:campus_benefit_app/fun/provider/view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/fun/provider/view_state_list_model.dart';
import 'package:campus_benefit_app/fun/service/wan_android_repository.dart';

import 'favourite_model.dart';

class ProjectCategoryModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await WanAndroidRepository.fetchProjectCategories();
  }
}

class ProjectListModel extends ViewStateRefreshListModel<Article> {
  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchArticles(pageNum, cid: 294);
  }
  @override
  onCompleted(List data) {
    GlobalFavouriteStateModel.refresh(data);
  }
}
