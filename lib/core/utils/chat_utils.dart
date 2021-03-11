import 'dart:html'
    if (dart.library.io) 'package:campus_benefit_app/core/config/constants.dart'
    show window;
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatUtils {
  static final ShareSDKPlatform qZone = ShareSDKPlatform(name: "QQ空间", id: 6);
  static final ShareSDKPlatform wechatSession =
      ShareSDKPlatform(name: "微信", id: 22);
  static final ShareSDKPlatform wechatTimeline =
      ShareSDKPlatform(name: "朋友圈", id: 23);
  static final ShareSDKPlatform weChatFavorites =
      ShareSDKPlatform(name: "喜欢", id: 37);
  static final ShareSDKPlatform qq = ShareSDKPlatform(name: "QQ", id: 24);
  static final ShareSDKPlatform sina = ShareSDKPlatform(name: "sina", id: 1);
  static qqChat(BuildContext context,
      {String number, bool isGroup = false}) async {
    var url;
    if (kIsWeb) {
      if (isGroup) {
        // ignore:undefined_prefixed_name
        window.open(
            'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=${number ?? 0}&card_type=group&source=qrcode',
            "调起QQ");
      } else
        // ignore:undefined_prefixed_name
        window.open(
            "mqqwpa://im/chat?chat_type=wpa&uin=${number ?? 0}&version=1&src_type=web&web_src=oicqzone.com",
            "调起QQ");
    } else {
      if (isGroup == true) {
        url =
            'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=${number ?? 0}&card_type=group&source=qrcode';
      } else {
        url =
            'mqqwpa://im/chat?chat_type=wpa&uin=${number ?? 0}&version=1&src_type=web&web_src=oicqzone.com';
      }
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        showToast("无法启动QQ", context: context);
      }
    }
  }

  static shareGrid(BuildContext context, {url, title, content}) {
    print(content);
    SystemStaticModel model = Provider.of<SystemStaticModel>(context);
    SSDKMap params = SSDKMap()
      ..setGeneral(
        title,
        content,
        [""],
        model.systemStaticInfo.myPageData.headImg,
        null,
         url,
         url,
        // null,
        // null,
        null,
        null,
        null,
        SSDKContentTypes.auto,
      );
    SharesdkPlugin.showMenu(
        [qq, qZone, wechatSession, wechatTimeline, weChatFavorites], params,
        (SSDKResponseState state, ShareSDKPlatform platform, Map userData,
            Map contentDntity, SSDKError error) {
      print(error.rawData);
    });
  }
}
