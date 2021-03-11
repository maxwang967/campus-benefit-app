import 'package:campus_benefit_app/core/nets/http.dart';
import 'package:campus_benefit_app/models/course_data_list.dart';
import 'package:campus_benefit_app/models/course_rg_1_data_list.dart';
import 'package:campus_benefit_app/models/course_rg_2_data_list.dart';
import 'package:campus_benefit_app/models/erya_course_automation_data_list.dart';
import 'package:campus_benefit_app/models/erya_order_data_list.dart';
import 'package:campus_benefit_app/models/erya_order_detail_data_list.dart';
import 'package:campus_benefit_app/models/rg1_order_data_list.dart';
import 'package:campus_benefit_app/models/rg2_order_data_list.dart';
import 'package:campus_benefit_app/models/zhihuishu_course_automation_data.dart';
import 'package:campus_benefit_app/models/zhihuishu_erya_user.dart';
import 'package:campus_benefit_app/models/zhihuishu_order_data_list.dart';
import 'package:campus_benefit_app/models/zhihuishu_order_detail_data_list.dart';

class CourseRepository {
  static Future fetchZhihuishuEryaUser() async {
    var response = await http.netFetch('zhihuishu_erya_user/', method: 'get');
    return ZhihuishuEryaUser.fromJson(response.data);
  }

  static Future fetchCourseDataList() async {
    var response = await http.netFetch('course/course_data/', method: 'get');
    return CourseDataList.fromJson(response.data);
  }

  static Future fetchCourseRG1DataList(
      {String account, String school, String password, String platform}) async {
    Map<String, dynamic> data = {
      "account": account,
      "password": password,
      "platform": platform
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch('course/ak_search_course/',
        method: 'get', params: data);
    return CourseRG1DataList.fromJson(response.data);
  }

  static Future submitCourseRG1(
      {String account,
      String school,
      String password,
      String platform,
      String courses,
      String courseids}) async {
    Map<String, dynamic> data = {
      "account": account,
      "password": password,
      "platform": platform,
      "courses": courses,
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch('course/ak_submit_order/',
        method: 'get', params: data);
    return response.data;
  }

  static Future fetchCourseRG2DataList(
      {String account, String school, String password, String platform}) async {
    Map<String, dynamic> data = {
      "account": account,
      "password": password,
      "platform": platform
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch('course/search_course/',
        method: 'get', params: data);
    return CourseRG2DataList.fromJson(response.data);
  }

  static Future submitCourseRG2(
      {String account,
      String school,
      String password,
      String platform,
      String courses,
      String courseids}) async {
    Map<String, dynamic> data = {
      "account": account,
      "password": password,
      "platform": platform,
      "courses": courses,
      "courseids": courseids
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch('course/submit_order/',
        method: 'get', params: data);
    return response.data;
  }

  static Future fetchCourseZhihuishuDataList(
      {String username, String school, String password}) async {
    Map<String, dynamic> data = {
      "username": username,
      "password": password,
      "school": school
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch(
        'course_automation/zhihuishu_course_query/',
        method: 'get',
        params: data);
    return ZhihuishuCourseAutomationDataList.fromJson(response.data);
  }

  static Future submitCourseZhihuishu(
      {String account,
      String school,
      String password,
      int type,
      String course}) async {
    Map<String, dynamic> data = {
      "account": account,
      "password": password,
      "type": type,
      "course": course,
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch(
        'course_automation/zhihuishu_task_submit/',
        method: 'get',
        params: data);
    return response.data;
  }

  static Future fetchCourseEryaDataList(
      {String username, String school, String password}) async {
    Map<String, dynamic> data = {
      "username": username,
      "password": password,
      "school": school
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch('course_automation/erya_course_query/',
        method: 'get', params: data);
    return EryaCourseAutomationDataList.fromJson(response.data);
  }

  static Future submitCourseErya(
      {String account, String school, String password, String course}) async {
    Map<String, dynamic> data = {
      "account": account,
      "password": password,
      "course": course,
    };
    if (school != null) {
      data["school"] = school;
    }
    var response = await http.netFetch('course_automation/erya_task_submit/',
        method: 'get', params: data);
    return response.data;
  }

  static Future fetchZhihuishuOrderDataList() async {
    var response = await http
        .netFetch('course_automation/zhihuishu_task_user_info/', method: 'get');
    return ZhihuishuOrderDataList.fromJson(response.data).data;
  }

  static Future fetchZhihuishuOrderDetailList(int id) async {
    var response = await http.netFetch(
        'course_automation/zhihuishu_relation_ship/',
        method: 'get',
        params: {"id": id});
    return ZhihuishuOrderDetailDataList.fromJson(response.data).data;
  }

  static Future extraBrushZhihuishuOrder(int id) async {
    var response = await http.netFetch('course_automation/zhihuishu_reset/',
        method: 'get', params: {"id": id});
    return response.data;
  }

  static Future deleteZhihuishuOrder(int id) async {
    var response = await http.netFetch('course_automation/zhihuishu_delete/',
        method: 'get', params: {"id": id});
    return response.data;
  }

  static Future fetchEryaOrderDataList() async {
    var response = await http.netFetch('course_automation/erya_task_user_info/',
        method: 'get');
    return EryaOrderDataList.fromJson(response.data).data;
  }

  static Future fetchEryaOrderDetailList(int id) async {
    var response = await http.netFetch('course_automation/erya_relation_ship/',
        method: 'get', params: {"id": id});
    return EryaOrderDetailDataList.fromJson(response.data).data;
  }

  static Future extraBrushEryaOrder(int id) async {
    var response = await http.netFetch('course_automation/erya_reset/',
        method: 'get', params: {"id": id});
    return response.data;
  }

  static Future deleteEryaOrder(int id) async {
    var response = await http.netFetch('course_automation/erya_delete/',
        method: 'get', params: {"id": id});
    return response.data;
  }

  static Future fetchRG1OrderDataList() async {
    var response = await http.netFetch('ak_orders/', method: 'get');
    return RG1OrderDataList.fromJson(response.data).data;
  }

  static Future fetchRG1OrderCourseDataList(String account) async {
    var response = await http.netFetch('course/ak_search_order_list/',
        method: 'get', params: {"account": account});
    return RG1OrderCourseDataList.fromJson(response.data).rows;
  }

  static Future extraBrushRG1Order(int id) async {
    var response = await http
        .netFetch('course/ak_reset/', method: 'get', params: {"id": id});
    return response.data;
  }

  static Future fetchRG2OrderDataList() async {
    var response =
        await http.netFetch('course/search_order_list/', method: 'get');
    return RG2OrderDataList.fromJson(response.data).data;
  }

  static Future extraBrushRG2Order(String id) async {
    var response =
        await http.netFetch('course/reset/', method: 'get', params: {"id": id});
    return response.data;
  }

  static Future zhihuishuLoginWithPhone(
      String username, String password) async {
    var response = await http.netFetch('zhihuishu/login_with_phone/ ',
        method: 'post', params: {"username": username, "password": password});
    return response.data;
  }

  static Future zhihuishuLoginWithSchool(
      String school, String username, String password) async {
    var response = await http.netFetch('zhihuishu/login_with_school/ ',
        method: 'post',
        params: {"username": username, "password": password, "school": school});
    return response.data;
  }

  static Future eryaLoginWithPhone(
      String username, String password) async {
    var response = await http.netFetch('erya/login_with_phone/ ',
        method: 'post', params: {"username": username, "password": password});
    return response.data;
  }

  static Future eryaLoginWithSchool(
      String school, String username, String password) async {
    var response = await http.netFetch('erya/login_with_school/ ',
        method: 'post',
        params: {"username": username, "password": password, "school": school});
    return response.data;
  }

}
