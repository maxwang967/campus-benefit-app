
import 'package:campus_benefit_app/core/nets/http.dart';
import 'package:campus_benefit_app/models/system_static_info.dart';

class SystemRepository {
  static Future getStaticInfo() async {
    var response = await http.netFetch('user_client_static/', method: 'get');
    return SystemStaticInfo.fromJson(response.data);
  }

  static Future getVersion() async {
    var response = await http.netFetch('version/', method: 'get');
    return response.data;
  }
}
