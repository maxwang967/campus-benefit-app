import 'package:campus_benefit_app/models/good_data_list.dart';
import 'package:campus_benefit_app/providers/view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/service/shop_repository.dart';

class YYCategoryDataListModel extends ViewStateRefreshListModel {
  int selectedCategoryIndex = 0;
  YYCategoryDataListModel(){
    initData();
  }
  @override
  Future<List> loadData({int pageNum}) async {
    return await ShopRepository.fetchCategoryDataList();
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

class YYGoodListModel extends ViewStateRefreshListModel {
  int selectedCid=0;
  String search="";
  List<GoodData> data;
  YYGoodListModel(){
    initData();
  }
  @override
  Future<List> loadData({int pageNum}) async {
    List<GoodData> goodDataList = await ShopRepository.fetchGoodDataList();
    data=goodDataList;
    return goodDataList;
  }
  @override
  Future<List> refreshData({int pageNum}) async {
    list=data;
    if (selectedCid != null&&selectedCid != 0) {
      list =
          list.where((element) => element.cid == selectedCid).toList();
    }
    if(search!=null&&search!=""){
      list =
          list.where((element) => element.name.contains(search)).toList();

    }
    notifyListeners();
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

class OrderListModel extends ViewStateRefreshListModel {

  @override
  Future<List> loadData({int pageNum}) async {
    return await ShopRepository.fetchOrderList(pageNum);
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
