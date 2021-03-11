import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/nets/handler.dart';
import 'package:campus_benefit_app/core/nets/net_message.dart';
import 'package:campus_benefit_app/models/user.dart';
import 'package:campus_benefit_app/service/user_repository.dart';
import 'package:campus_benefit_app/service/wallet_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = Config.USER_KEY;

  bool hasInitPush = false;

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel() {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? User.fromJson(userMap) : null;
  }

  saveUser(User user) async {
    _user = user;
    notifyListeners();
    await StorageManager.localStorage.setItem(kUser, user);
  }

  /// 清除持久化的用户数据
  clearUser() async {
    _user = null;
    hasInitPush = false;
    notifyListeners();
    await StorageManager.localStorage.deleteItem(kUser);
    await StorageManager.localStorage.deleteItem(Config.IS_LOGIN_KEY);
  }


  refreshUserInfo() async {
    var newUser = await UserRepository.getUserInfo("1");
    saveUser(newUser);
    notifyListeners();
  }

  updateUserWithdrawAccount(context, {String alipayAccount, String wxPayAccount}) async {
    String username = user.userinfo.phone;
    try {
      await WalletRepository.updateWithdrawAccount(alipayAccount: alipayAccount, wxPayAccount: wxPayAccount, user: user);
      var newUser = await UserRepository.getUserInfo(username);
      saveUser(newUser);
      Future.microtask(() {
        showToast("信息修改成功！", context: context);
      });
    } catch (e) {
      showErrorByResponse(e,context);
    }
  }

  showErrorByResponse(var e,BuildContext context) {
    Future.microtask(() {
      showToast(
          ResponseMessage(Handler.errorHandleFunction(e.response.statusCode)
              , e.response.data).message, context: context);
    });
  }




}
