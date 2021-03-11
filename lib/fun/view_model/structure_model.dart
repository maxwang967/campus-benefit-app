import 'package:campus_benefit_app/fun/provider/view_state_list_model.dart';
import 'package:campus_benefit_app/fun/provider/view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/fun/service/wan_android_repository.dart';

import 'favourite_model.dart';

class StructureCategoryModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchTreeCategories();
  }
}

class StructureListModel extends ViewStateRefreshListModel {
  final int cid;

  StructureListModel(this.cid);

  @override
  Future<List> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchArticles(pageNum, cid: cid);
  }

  @override
  onCompleted(List data) {
    GlobalFavouriteStateModel.refresh(data);
  }
}

/// 网址导航
class NavigationSiteModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    return await WanAndroidRepository.fetchNavigationSite();
  }
}

