import 'package:campus_benefit_app/core/nets/http.dart';
import 'package:campus_benefit_app/models/banner_data_list.dart';
import 'package:campus_benefit_app/models/qqz_job_data_list.dart';

class JobRepositroy {
  static Future fetchBannerList(int pageNum) async {
    var response = await http.netFetch('job/job_banner/', method: 'get');
    return BannerDataList.fromJson(response.data).data;
  }

  static Future fetchBaseQQZJobDataList(int pageNum, {String search}) async {
    Map<String, dynamic> data = {
      'page': pageNum,
    };

    if (search != null && search != '') {
      data['search'] = search;
    }

    var response = await http.netFetch('job/base_qqz_jobs_data_json/',
        params: data, method: 'get');
    return JobQQZDataList.fromJson(response.data).data;
  }

  static Future fetchQQZJobDataList(int pageNum,
      {String search, String level, String catId, String type}) async {
    Map<String, dynamic> data = {
      'page': pageNum,
    };

    if (search != null && search != '') {
      data['search'] = search;
    }

    if (level != null) {
      data['level'] = level;
    }

    if (catId != null) {
      data['cat_id'] = level;
    }

    if (type != null) {
      data['type'] = level;
    }

    var response = await http.netFetch('job/qqz_jobs_data_json/',
        params: data, method: 'get');
    return JobQQZDataList.fromJson(response.data).data;
  }

  static Future fetchQQZJobCategory() async {
    var response = await http.netFetch('job/qqz_category/', method: 'get');
    return response.data;
  }

  static Future refreshChangeOrder(String orderId) async{
    var response = await http.netFetch('shop/yy_change_order/', method: 'get', params: {
      'id': orderId
    });
    return response.data;
  }
}
