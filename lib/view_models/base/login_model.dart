


import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/nets/http.dart';
import 'package:campus_benefit_app/models/user.dart';
import 'package:campus_benefit_app/providers/view_state_model.dart';
import 'package:campus_benefit_app/service/user_repository.dart';
import 'package:campus_benefit_app/view_models/base/user_model.dart';

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);


  Future<bool> loginUsernamePassword(username, password, context) async {
    setBusy();
    try {
      var token = await UserRepository.loginUsernamePassword(username, password);
      await StorageManager.sharedPreferences.setString(Config.TOKEN_KEY, token);
      User user = await UserRepository.getUserInfo(username);
      userModel.saveUser(user);
      userModel.refreshUserInfo();
      await StorageManager.sharedPreferences.setBool(Config.IS_LOGIN_KEY, true);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      showErrorMessage(context);
      setIdle();
      return false;
    }
  }

  Future<bool> loginUsernameCode(username, code, context) async {
    setBusy();
    try {
      var token = await UserRepository.loginUsernameCode(username, code);
      await StorageManager.sharedPreferences.setString(Config.TOKEN_KEY, token);
      var user = await UserRepository.getUserInfo(username);
      userModel.saveUser(user);
      userModel.refreshUserInfo();
      await StorageManager.sharedPreferences.setBool(Config.IS_LOGIN_KEY, true);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      showErrorMessage(context);
      setIdle();
      return false;
    }
  }

  Future<bool> changePassword(code, password, context) async {
    setBusy();
    int id = userModel.user.id;
    try {
      await UserRepository.changePassword(id, password, code);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      showErrorMessage(context);
      return false;
    }
  }

  Future<bool> register(code, password, username, context) async {
    setBusy();
    try {
      await UserRepository.register(username, password, code);
      var user = await UserRepository.getUserInfo(username);
      userModel.saveUser(user);
      StorageManager.sharedPreferences.setBool(Config.IS_LOGIN_KEY, true);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      showErrorMessage(context);
      return false;
    }
  }

  Future<bool> logout() async {
    if (!userModel.hasUser) {
      //防止递归
      return false;
    }
    setBusy();
    try {
      userModel.clearUser();
      http.clearAuthorization();
      await StorageManager.sharedPreferences.setBool(Config.IS_LOGIN_KEY, false);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e,s);
      return false;
    }
  }
}
