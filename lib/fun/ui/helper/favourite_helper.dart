import 'package:flutter/cupertino.dart';
import 'package:campus_benefit_app/fun/config/router_manger.dart';
import 'package:campus_benefit_app/fun/generated/i18n.dart';
import 'package:campus_benefit_app/fun/model/article.dart';
import 'package:campus_benefit_app/fun/ui/widget/favourite_animation.dart';
import 'package:campus_benefit_app/fun/view_model/favourite_model.dart';
import 'package:campus_benefit_app/fun/view_model/user_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'dialog_helper.dart';

/// 收藏文章.
/// 如果用户未登录,需要跳转到登录界面
/// 如果执行失败,需要给与提示
///
/// 由于存在递归操作,所以抽取为方法,而且多处调用
/// 多个页面使用该方法,目前这种方式并不优雅,抽取位置有待商榷
///
///
addFavourites(BuildContext context,
    {Article article,
    FavouriteModel model,
    Object tag: 'addFavourite',
    bool playAnim: true}) async {
  await model.collect(article);
  //未登录
  if (model.unAuthorized) {
    if (await DialogHelper.showLoginDialog(context)) {
      var success = await Navigator.pushNamed(context, RouteName.login);
      if (success ?? false) {
        //登录后,判断是否已经收藏
        if (!Provider.of<UserModel>(context, listen: false)
            .user
            .collectIds
            .contains(article.id)) {
          addFavourites(context, article: article, model: model, tag: tag);
        }
      }
    }
  } else if (model.error) {
    //失败
    showToast(S.of(context).loadFailed);
  } else {
    if (playAnim) {
      ///接口调用成功播放动画
      Navigator.push(
          context,
          HeroDialogRoute(
              builder: (_) => FavouriteAnimationWidget(
                    tag: tag,
                    add: article.collect,
                  )));
    }
  }
}
