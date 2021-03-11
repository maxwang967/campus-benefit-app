
import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/nets/constants/code.dart';
import 'package:campus_benefit_app/core/nets/handler.dart';
import 'package:campus_benefit_app/core/nets/interceptors/error_interceptor.dart';
import 'package:campus_benefit_app/core/nets/interceptors/head_interceptor.dart';
import 'package:campus_benefit_app/core/nets/interceptors/log_interceptor.dart';
import 'package:campus_benefit_app/core/nets/interceptors/response_interceptor.dart';
import 'package:campus_benefit_app/core/nets/interceptors/token_interceptor.dart';
import 'package:campus_benefit_app/core/nets/net_message.dart';
import 'package:campus_benefit_app/core/nets/response_data.dart';
import 'package:campus_benefit_app/core/nets/response_exception.dart';
import 'package:dio/browser_imp.dart';
import 'package:dio/dio.dart';

class Http extends DioForBrowser {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

//  Dio _dio = new Dio(); // 使用默认配置

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  Http() {
    options.baseUrl = Config.BASE_URL;
    options.connectTimeout = 300000; //5s
    options.receiveTimeout = 300000;

    this.interceptors.add(new HeaderInterceptors());

    this.interceptors.add(_tokenInterceptors);

    this.interceptors.add(new LogsInterceptors());

    this.interceptors.add(new ErrorInterceptors());

    this.interceptors.add(new ResponseInterceptors());
  }

  Future<ResponseData> netFetch(url,
      {Map<String, dynamic> header,
      Map<String, dynamic> params,
      method = 'get'}) async {
    Map<String, dynamic> headers = Map();
    if (header != null) {
      headers.addAll(header);
    }
    print(this.options);
    Options _option = new Options(method: method);
    _option.headers = headers;

    Response response;
    try {
      if (method == 'post' || method == "put") {
        response = await this.request(url, data: params, options: _option);
      } else {
        response = await this.request(url,
            data: params, queryParameters: params, options: _option);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == Code.AUTH_ERROR) {
        throw UnAuthorizedException();
      }
      throw NotSuccessException.fromRespData(ResponseMessage(
          Handler.errorHandleFunction(e.response.statusCode), e.response.data));
    }
    return response.data;
  }

  ResponseData resultError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = new Response(statusCode: 666);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    }
    return new ResponseData(e.response.data, false, errorResponse.statusCode);
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

