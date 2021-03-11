import 'package:campus_benefit_app/models/course_data_list.dart';
import 'package:campus_benefit_app/models/course_rg_1_data_list.dart';
import 'package:campus_benefit_app/models/course_rg_2_data_list.dart';
import 'package:campus_benefit_app/models/erya_course_automation_data_list.dart';
import 'package:campus_benefit_app/models/erya_order_data_list.dart';
import 'package:campus_benefit_app/models/erya_order_detail_data_list.dart';
import 'package:campus_benefit_app/models/rg1_order_data_list.dart';
import 'package:campus_benefit_app/models/rg2_order_data_list.dart';
import 'package:campus_benefit_app/models/zhihuishu_course_automation_data.dart';
import 'package:campus_benefit_app/models/zhihuishu_order_data_list.dart';
import 'package:campus_benefit_app/models/zhihuishu_order_detail_data_list.dart';
import 'package:campus_benefit_app/providers/view_state_list_model.dart';
import 'package:campus_benefit_app/providers/view_state_model.dart';
import 'package:campus_benefit_app/providers/view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/service/course_repository.dart';
import 'package:campus_benefit_app/ui/pages/course/course_automation_page.dart';
import 'package:oktoast/oktoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CourseDataListModel extends ViewStateRefreshListModel {
  String limit = "";
  @override
  Future<List> loadData({int pageNum}) async {
    CourseDataList courseDataList =
        await CourseRepository.fetchCourseDataList();
    limit = courseDataList.limit;
    notifyListeners();
    return courseDataList.products;
  }

  @override
  initData() {
    return super.initData();
  }

  CourseDataListModel() {
    initData();
  }
  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}

class CourseAutomationModel extends ViewStateModel {
  List<CourseRG2Data> rawCourseRG2List = List<CourseRG2Data>();
  List<ZhihuishuCourseAutomationData> rawCourseZhihuishuList =
      List<ZhihuishuCourseAutomationData>();
  List<EryaCourseAutomationData> rawCourseEryaList =
      List<EryaCourseAutomationData>();
  List<CourseRg1DataChildren> rawCourseRG1List = List<CourseRg1DataChildren>();
  List<CourseListItem> displayCourseRG2List = List<CourseListItem>();
  List<CourseListItem> displayCourseRG1List = List<CourseListItem>();
  List<CourseListItem> displayCourseZhihuishuList = List<CourseListItem>();
  List<CourseListItem> displayCourseEryaList = List<CourseListItem>();
  int zhihuishuType = 0;
  ProgressDialog pr;
  CourseAutomationModel();

  fetchCourseRG1List(context,
      {String school,
      String account,
      String password,
      String platformId}) async {
    // setBusy();
    rawCourseRG1List = List<CourseRg1DataChildren>();
    displayCourseRG1List = List<CourseListItem>();
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      await pr.show();
      var list = await CourseRepository.fetchCourseRG1DataList(
          school: school,
          account: account,
          password: password,
          platform: platformId);
      rawCourseRG1List = list.data[0].children;
      displayCourseRG1List = List<CourseListItem>.generate(
          rawCourseRG1List.length,
          (index) => CourseListItem(
              rawCourseRG1List[index].id, rawCourseRG1List[index].name));
      notifyListeners();
      showToast("查询成功，请选择课程。");
      // setIdle();
    } catch (e, s) {
      print(e);
      print(s);
      setError(e, s);
      showToast(viewStateError.message);
      // setIdle();
    } finally {
      await pr.hide();
      // 
      // setIdle();
    }
  }

  submitCourseRG1(context,
      {String school,
      String account,
      String password,
      String platformId}) async {
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      // setBusy();
      await pr.show();
      String courses = "";
      displayCourseRG1List.forEach((element) {
        if (element.isSelected) {
          courses += "${element.data}~${element.id},";
        }
      });
      courses = courses.substring(0, courses.length - 1);
      await CourseRepository.submitCourseRG1(
          school: school,
          account: account,
          password: password,
          platform: platformId,
          courses: courses);
      showToast("提交成功");
    } catch (e, s) {
      print(e);
      print(s);
      setError(e, s);
      showToast(viewStateError.message);
      // showToast(viewState.erro);
    } finally {
      // setIdle();
      await pr.hide();
      // 
    }
  }

  fetchCourseRG2List(context,
      {String school,
      String account,
      String password,
      String platformId}) async {
    // setBusy();
    rawCourseRG2List = List<CourseRG2Data>();
    displayCourseRG2List = List<CourseListItem>();
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      await pr.show();
      var list = await CourseRepository.fetchCourseRG2DataList(
          school: school,
          account: account,
          password: password,
          platform: platformId);
      rawCourseRG2List = list.data;
      displayCourseRG2List = List<CourseListItem>.generate(
          rawCourseRG2List.length,
          (index) => CourseListItem(
              rawCourseRG2List[index].id, rawCourseRG2List[index].name));
      notifyListeners();
      showToast("查询成功，请选择课程。");
      // setIdle();
    } catch (e, s) {
      // showToast("查询失败！");
      setError(e, s);
      showToast(viewStateError.message);
      // setIdle();
    } finally {
      await pr.hide();
      // setIdle();
    }
  }

  submitCourseRG2(context,
      {String school,
      String account,
      String password,
      String platformId}) async {
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      // setBusy();
      await pr.show();
      String courses = "";
      String courseids = "";
      displayCourseRG2List.forEach((element) {
        if (element.isSelected) {
          courses += "${element.data},";
          courseids += "${element.id},";
        }
      });
      courses = courses.substring(0, courses.length - 1);
      courseids = courseids.substring(0, courseids.length - 1);
      await CourseRepository.submitCourseRG2(
          school: school,
          account: account,
          password: password,
          platform: platformId,
          courses: courses,
          courseids: courseids);
      showToast("提交成功");
    } catch (e, s) {
      setError(e, s);
      print(e);
      print(s);
      showToast(viewStateError.message);
      // showErrorMessage(context);
    } finally {
      // setIdle();
      await pr.hide();
      
    }
  }

  fetchCourseZhihuishuList(context,
      {String school, String username, String password}) async {
    // setBusy();
    rawCourseZhihuishuList = List<ZhihuishuCourseAutomationData>();
    displayCourseZhihuishuList = List<CourseListItem>();
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      await pr.show();
      var list = await CourseRepository.fetchCourseZhihuishuDataList(
          school: school, username: username, password: password);
      rawCourseZhihuishuList = list.data;
      displayCourseZhihuishuList = List<CourseListItem>.generate(
          rawCourseZhihuishuList.length,
          (index) => CourseListItem(rawCourseZhihuishuList[index].id,
              rawCourseZhihuishuList[index].name));
      notifyListeners();
      showToast("查询成功，请选择课程。");
      // setIdle();
    } catch (e, s) {
      // showToast("查询失败！");
      setError(e, s);
      showToast(viewStateError.message);
      // setIdle();
    } finally {
      // setIdle();
      await pr.hide();
      
    }
  }

  submitCourseZhihuishu(
    context, {
    String school,
    String account,
    String password,
  }) async {
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      // setBusy();
      await pr.show();
      String course = "";
      displayCourseZhihuishuList.forEach((element) {
        if (element.isSelected) {
          course += "${element.id},";
        }
      });
      course = course.substring(0, course.length - 1);
      await CourseRepository.submitCourseZhihuishu(
          school: school,
          account: account,
          password: password,
          type: zhihuishuType + 1,
          course: course);
      showToast("提交成功");
    } catch (e, s) {
      setError(e, s);
      print(e);
      print(s);
      showToast(viewStateError.message);
      // showErrorMessage(context);
    } finally {
      setIdle();
      await pr.hide();
      
    }
  }

  fetchCourseEryaList(context,
      {String school, String username, String password}) async {
    // setBusy();
    rawCourseEryaList = List<EryaCourseAutomationData>();
    displayCourseEryaList = List<CourseListItem>();
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      await pr.show();
      var list = await CourseRepository.fetchCourseEryaDataList(
          school: school, username: username, password: password);
      rawCourseEryaList = list.data;
      displayCourseEryaList = List<CourseListItem>.generate(
          rawCourseEryaList.length,
          (index) => CourseListItem(
              rawCourseEryaList[index].id, rawCourseEryaList[index].name));
      print(displayCourseEryaList);
      notifyListeners();
      showToast("查询成功，请选择课程。");
      // setIdle();
    } catch (e, s) {
      // showToast("查询失败！");
      setError(e, s);
      showToast(viewStateError.message);
      setIdle();
    } finally {
      // setIdle();
      await pr.hide();
      
    }
  }

  submitCourseErya(
    context, {
    String school,
    String account,
    String password,
  }) async {
    pr = new ProgressDialog(context);
    pr.style(message: "请耐心等待哦～");
    try {
      // setBusy();
      await pr.show();
      String course = "";
      displayCourseEryaList.forEach((element) {
        if (element.isSelected) {
          course += "${element.id},";
        }
      });
      course = course.substring(0, course.length - 1);
      await CourseRepository.submitCourseErya(
          school: school, account: account, password: password, course: course);
      showToast("提交成功");
    } catch (e, s) {
      setError(e, s);
      print(e);
      print(s);
      showToast(viewStateError.message);
      // showErrorMessage(context);
    } finally {
      setIdle();
      await pr.hide();
      
    }
  }

  void clearAll() {
    setBusy();
    rawCourseRG2List = List<CourseRG2Data>();
    rawCourseZhihuishuList = List<ZhihuishuCourseAutomationData>();
    rawCourseEryaList = List<EryaCourseAutomationData>();
    rawCourseRG1List = List<CourseRg1DataChildren>();
    displayCourseRG2List = List<CourseListItem>();
    displayCourseRG1List = List<CourseListItem>();
    displayCourseZhihuishuList = List<CourseListItem>();
    displayCourseEryaList = List<CourseListItem>();
    notifyListeners();
    setIdle();
  }
}

class ZhihuishuOrderDataListModel extends ViewStateListModel {
  String search;
  List<ZhihuishuOrderData> allList;
  @override
  Future<List> loadData() async {
    List<ZhihuishuOrderData> orderDataList =
        await CourseRepository.fetchZhihuishuOrderDataList();
    allList = orderDataList;
    return orderDataList;
  }

  searchRefresh() {
    if (allList.length != 0) {
      List<ZhihuishuOrderData> resultDataList =
          List<ZhihuishuOrderData>();
      if (search != null && search.trim() != "") {
        allList.forEach((element) {
          if (((element.user.stuNum ?? '').contains(search)) ||
              ((element.user.phonenum ?? '').contains(search))) {
            resultDataList.add(element);
          }
        });
        this.list = resultDataList;
        notifyListeners();
      } else {
        this.list = allList;
        notifyListeners();
      }
    }
  }

  extraBrush(int id) async {
    try {
      await CourseRepository.extraBrushZhihuishuOrder(id);
      showToast("补刷成功");
      refresh();
    } catch (e, s) {
      setError(e, s);
      showToast(viewStateError.message);
      setIdle();
    }
  }

  delete(int id) async {
    try {
      await CourseRepository.deleteZhihuishuOrder(id);
      showToast("删除成功");
      refresh();
    } catch (e, s) {
      setError(e, s);
      showToast(viewStateError.message);
      setIdle();
    }
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}

class ZhihuishuOrderDetailDataListModel extends ViewStateListModel {
  final int id;

  ZhihuishuOrderDetailDataListModel(this.id);
  @override
  Future<List> loadData() async {
    List<ZhihuishuOrderDetailData> orderDataList =
        await CourseRepository.fetchZhihuishuOrderDetailList(id);

    return orderDataList;
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}

class EryaOrderDataListModel extends ViewStateListModel {
  String search;
  List<EryaOrderData> allList;
  @override
  Future<List> loadData() async {
    List<EryaOrderData> orderDataList =
        await CourseRepository.fetchEryaOrderDataList();
    allList = orderDataList;
    return orderDataList;
  }

  searchRefresh() {
    if (allList.length != 0) {
      List<EryaOrderData> resultDataList =
          List<EryaOrderData>();
      if (search != null && search.trim() != "") {
        allList.forEach((element) {
          if (((element.user.stuNum ?? '').contains(search)) ||
              ((element.user.phonenum ?? '').contains(search))) {
            resultDataList.add(element);
          }
        });
        this.list = resultDataList;
        notifyListeners();
      } else {
        this.list = allList;
        notifyListeners();
      }
    }
  }

  extraBrush(int id) async {
    try {
      await CourseRepository.extraBrushEryaOrder(id);
      showToast("补刷成功");
      refresh();
    } catch (e, s) {
      setError(e, s);
      showToast(viewStateError.message);
      setIdle();
    }
  }

  delete(int id) async {
    try {
      await CourseRepository.deleteEryaOrder(id);
      showToast("删除成功");
      refresh();
    } catch (e, s) {
      setError(e, s);
      showToast(viewStateError.message);
      setIdle();
    }
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}

class EryaOrderDetailDataListModel extends ViewStateListModel {
  final int id;

  EryaOrderDetailDataListModel(this.id);
  @override
  Future<List> loadData() async {
    List<EryaOrderDetailData> orderDataList =
        await CourseRepository.fetchEryaOrderDetailList(id);

    return orderDataList;
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}

class RG1OrderDataListModel extends ViewStateListModel {
  String search;
  List<RG1OrderData> allList;
  @override
  Future<List> loadData() async {
    List<RG1OrderData> orderDataList =
        await CourseRepository.fetchRG1OrderDataList();
    allList = orderDataList;
    return orderDataList;
  }

  searchRefresh() {
    if (allList.length != 0) {
      List<RG1OrderData> resultDataList = List<RG1OrderData>();
      if (search != null && search.trim() != "") {
        allList.forEach((element) {
          if (((element.account ?? '').contains(search))) {
            resultDataList.add(element);
          }
        });
        this.list = resultDataList;
        notifyListeners();
      } else {
        this.list = allList;
        notifyListeners();
      }
    }
  }

  // String search;
  // @override
  // Future<List> loadData() async {
  //   setBusy();
  //   List<RG1OrderData> orderDataList =
  //       await CourseRepository.fetchRG1OrderDataList();
  //   List<RG1OrderData> resultDataList = List<RG1OrderData>();
  //   if (search != null && search.trim() != "") {
  //     orderDataList.forEach((element) {
  //       if (element.account == search) {
  //         resultDataList.add(element);
  //       }
  //     });
  //   } else {
  //     resultDataList = orderDataList;
  //   }
  //   setIdle();
  //   return resultDataList;
  // }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}

class RG1OrderCourseDataListModel extends ViewStateListModel {
  final String account;
  // String search;

  RG1OrderCourseDataListModel(this.account);

  String search;
  List<RG1OrderCourseData> allList;
  @override
  Future<List> loadData() async {
    List<RG1OrderCourseData> orderDataList =
        await CourseRepository.fetchRG1OrderCourseDataList(account);
    allList = orderDataList;
    return orderDataList;
  }

  searchRefresh() {
    if (allList.length != 0) {
      List<RG1OrderCourseData> resultDataList = List<RG1OrderCourseData>();
      if (search != null && search.trim() != "") {
        allList.forEach((element) {
          if (((element.username ?? '').contains(search))) {
            resultDataList.add(element);
          }
        });
        this.list = resultDataList;
        notifyListeners();
      } else {
        this.list = allList;
        notifyListeners();
      }
    }
  }

  // @override
  // Future<List> loadData() async {
  //   setBusy();
  //   List<RG1OrderCourseData> orderDataList =
  //       await CourseRepository.fetchRG1OrderCourseDataList(account);
  //   List<RG1OrderCourseData> resultDataList = List<RG1OrderCourseData>();
  //   if (search != null && search.trim() != "") {
  //     orderDataList.forEach((element) {
  //       if (element.username == search) {
  //         resultDataList.add(element);
  //       }
  //     });
  //   } else {
  //     resultDataList = orderDataList;
  //   }
  //   setIdle();
  //   return resultDataList;
  // }

  extraBrush(int id) async {
    try {
      await CourseRepository.extraBrushRG1Order(id);
      showToast("补刷成功");
      refresh();
    } catch (e, s) {
      setError(e, s);
      showToast(viewStateError.message);
      setIdle();
    }
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}

class RG2OrderDataListModel extends ViewStateListModel {

  String search;
  List<RG2OrderData> allList;
  @override
  Future<List> loadData() async {
    List<RG2OrderData> orderDataList =
        await CourseRepository.fetchRG2OrderDataList();
    allList = orderDataList;
    return orderDataList;
  }

  searchRefresh() {
    if (allList.length != 0) {
      List<RG2OrderData> resultDataList = List<RG2OrderData>();
      if (search != null && search.trim() != "") {
        allList.forEach((element) {
          if (((element.account ?? '').contains(search))) {
            resultDataList.add(element);
          }
        });
        this.list = resultDataList;
        notifyListeners();
      } else {
        this.list = allList;
        notifyListeners();
      }
    }
  }

  // String search;
  // @override
  // Future<List> loadData() async {
  //   setBusy();
  //   List<RG2OrderData> orderDataList =
  //       await CourseRepository.fetchRG2OrderDataList();
  //   List<RG2OrderData> resultDataList = List<RG2OrderData>();
  //   if (search != null && search.trim() != "") {
  //     orderDataList.forEach((element) {
  //       if (element.account == search) {
  //         resultDataList.add(element);
  //       }
  //     });
  //   } else {
  //     resultDataList = orderDataList;
  //   }
  //   setIdle();
  //   return resultDataList;
  // }

  extraBrush(String id) async {
    try {
      await CourseRepository.extraBrushRG2Order(id);
      showToast("补刷成功");
      refresh();
    } catch (e, s) {
      setError(e, s);
      showToast(viewStateError.message);
      setIdle();
    }
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}
