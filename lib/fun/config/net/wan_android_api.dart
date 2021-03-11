import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:cookie_jar/cookie_jar.dart'if (dart.library.html) 'package:campus_benefit_app/fun/config/dummy_for_web.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart' if (dart.library.html) 'package:campus_benefit_app/fun/config/dummy_for_web.dart';
import 'package:flutter/foundation.dart';
import 'package:campus_benefit_app/fun/provider/view_state.dart';
import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'https://www.wanandroid.com/';
    interceptors
      ..add(ApiInterceptor())
      // cookie持久化 异步
      ..add(CookieManager(
          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}');
//    debugPrint('---api-request--->data--->${options.data}');
    return options;
  }

  @override
  onResponse(Response response) {
//    debugPrint('---api-response--->resp----->${response.data}');
    RespData respData = RespData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      return handleFailed(respData);
    }
  }

  Future<Response> handleFailed(RespData respData) {
    debugPrint('---api-response--->error---->$respData');
    if (respData.code == -1001) {
      // 如果cookie过期,需要清除本地存储的登录信息
//      StorageManager.localStorage.deleteItem(UserModel.keyUser);
      // 需要登录
      throw const UnAuthorizedException();
    }
    return http.reject(respData.message);
  }
}

class RespData {
  dynamic data;
  int code = 0;
  String message;

  bool get success => 0 == code;

  RespData({this.data, this.code, this.message});

  @override
  String toString() {
    return 'RespData{data: $data, status: $code, message: $message}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.code;
    data['errorMsg'] = this.message;
    data['data'] = this.data;
    return data;
  }

  RespData.fromJson(Map<String, dynamic> json) {
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}
