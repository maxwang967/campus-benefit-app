import 'package:campus_benefit_app/core/nets/http.dart';
import 'package:campus_benefit_app/models/earn_data_list.dart';
import 'package:campus_benefit_app/models/finerit_code_data_list.dart';
import 'package:campus_benefit_app/models/pay_order.dart';
import 'package:campus_benefit_app/models/user.dart';

class WalletRepository {
  static Future withdraw(code) async {
    var response = await http
        .netFetch('withdraw/', method: 'post', params: {'code': code});
    return response.data;
  }

  static Future updateWithdrawAccount(
      {String alipayAccount, String wxPayAccount, User user}) async {
    var response =
        await http.netFetch('withdraw_account/1/', method: 'put', params: {
      "aly_pay_account": alipayAccount == null
          ? user.withdrawaccount.alyPayAccount
          : alipayAccount,
      "weixin_pay_account": wxPayAccount == null
          ? user.withdrawaccount.weixinPayAccount
          : wxPayAccount
    });
    return response.data;
  }

  static Future fetchFineritCodeInfoDetail(
      {int page, int year, int month}) async {
    var response = await http.netFetch('finercodeinfos/',
        params: {
          "page": page == null ? 1 : page,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month
        },
        method: 'get');
    return FineirtCodeInfoList.fromJson(response.data).data.data;
  }

  static Future fetchFineritCodeInfo({int year, int month}) async {
    var response = await http.netFetch('finercodeinfos/',
        params: {
          "page": 1,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month
        },
        method: 'get');
    return FineirtCodeInfoList.fromJson(response.data).data;
  }

  static Future createPayOrder(double campus_code) async {
    var response = await http.netFetch('pay_orders/',
        params: {'finer_code': campus_code}, method: 'post');
    return PayCreateOrder.fromJson(response.data);
  }

  static Future readPayOrder(int id) async {
    var response = await http.netFetch('pay_orders/${id}/', method: 'get');
    return PayReadOrder.fromJson(response.data);
  }

  static Future fetchEarnCodeInfoDetail(
      {int page, int year, int month, int day}) async {
    var response = await http.netFetch('earncodeinfos/',
        params: {
          "page": page == null ? 1 : page,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month,
          "day": day == null ? '' : day
        },
        method: 'get');
    return EarnDataList.fromJson(response.data).data.data;
  }

  static Future fetchEarnCodeInfo(
      {int page, int year, int month, int day}) async {
    var response = await http.netFetch('earncodeinfos/',
        params: {
          "page": page == null ? 1 : page,
          "year": year == null ? '' : year,
          "month": month == null ? '' : month,
          "day": day == null ? '' : day
        },
        method: 'get');
    return EarnDataList.fromJson(response.data).data;
  }

  static Future openVip() async {
    var response = await http.netFetch('openvip/', method: 'get');
    return response.data;
  }

  static Future openYearVip() async {
    var response = await http.netFetch('openannualvip/', method: 'get');
    return response.data;
  }
}
