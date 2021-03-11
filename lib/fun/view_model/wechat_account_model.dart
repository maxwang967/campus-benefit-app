import 'package:campus_benefit_app/fun/model/article.dart';
import 'package:campus_benefit_app/fun/model/tree.dart';
import 'package:campus_benefit_app/fun/provider/view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/fun/provider/view_state_list_model.dart';
import 'package:campus_benefit_app/fun/service/wan_android_repository.dart';

import 'favourite_model.dart';

/// 微信公众号
class WechatAccountCategoryModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await WanAndroidRepository.fetchWechatAccounts();
  }
}

/// 微信公众号文章
class WechatArticleListModel extends ViewStateRefreshListModel<Article> {
  /// 公众号id
  final int id;

  WechatArticleListModel(this.id);

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return await WanAndroidRepository.fetchWechatAccountArticles(pageNum, id);
  }

  @override
  onCompleted(List data) {
    GlobalFavouriteStateModel.refresh(data);
  }
}
