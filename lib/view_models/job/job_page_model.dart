import 'package:campus_benefit_app/providers/view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/service/job_repository.dart';

class BaseQQZJobDataListModel extends ViewStateRefreshListModel{
  String search;
  BaseQQZJobDataListModel(){
    initData();
  }
  @override
  Future<List> loadData({int pageNum}) async{
    return await JobRepositroy.fetchBaseQQZJobDataList(pageNum, search: search);
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

class QQZJobDataListModel extends ViewStateRefreshListModel{
  String search;
  String level;
  String catId;
  String type;
  @override
  Future<List> loadData({int pageNum}) async{
    return await JobRepositroy.fetchQQZJobDataList(pageNum, search: search, level: level, catId: catId, type: type);
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