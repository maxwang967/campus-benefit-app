import 'package:campus_benefit_app/core/nets/constants/code.dart';
import 'package:campus_benefit_app/core/nets/handler.dart';
import 'package:campus_benefit_app/core/nets/net_message.dart';
import 'package:campus_benefit_app/core/nets/response_exception.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

//const NOT_TIP_KEY = "noTip";


class ErrorInterceptors extends InterceptorsWrapper {

  ErrorInterceptors();

  @override
  onRequest(RequestOptions options) async {
    //没有网络
    // var connectivityResult = await (new Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   throw NotSuccessException.fromRespData(RequestMessage(message: Handler.errorHandleFunction(Code.NETWORK_ERROR)));
    // }
    return options;
  }
}
