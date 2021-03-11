import 'package:campus_benefit_app/core/nets/http.dart';
import 'package:campus_benefit_app/models/category_data_list.dart';
import 'package:campus_benefit_app/models/good_data_list.dart';
import 'package:campus_benefit_app/models/good_detail_data.dart';
import 'package:campus_benefit_app/models/order_data_list.dart';

class ShopRepository {
  static Future fetchCategoryDataList() async {
    var response = await http.netFetch('shop/yy_category/', method: 'get');
    return CategoryDataList.fromJson(response.data).data;
  }  
  static Future fetchGoodDataList() async {
    var response = await http.netFetch('shop/yy_list/', method: 'get');
    return GoodDataList.fromJson(response.data).data;
  }

    static Future fetchGoodDetailData(int gid) async {
    var response = await http.netFetch('shop/yy_detail/', method: 'get', params: {
      'gid': gid
    });
    return GoodDetailData.fromJson(response.data).data;
  }

    static Future fetchOrderList(int pageNum) async {
    Map<String, dynamic> data = {
      'page': pageNum,
    };
    var response = await http.netFetch('yy_shop_orders/',
        params: data, method: 'get');
    return OrderDataList.fromJson(response.data).data;
  }
}
