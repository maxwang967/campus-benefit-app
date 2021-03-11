import 'package:campus_benefit_app/models/earn_sum_data.dart';
import 'package:campus_benefit_app/models/team_data.dart';
import 'package:campus_benefit_app/providers/custom/finerit_code_info_view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/providers/view_state_model.dart';
import 'package:campus_benefit_app/providers/view_state_refresh_list_model.dart';
import 'package:campus_benefit_app/service/user_repository.dart';
import 'package:campus_benefit_app/service/wallet_repository.dart';

class EarnSumDataModel extends ViewStateModel {
  EarnSumData earnSumData;

  EarnSumDataModel() {
    initData();
  }

  initData() async {
    setBusy();
    try {
      earnSumData = await UserRepository.getUserEarnSumData();
      notifyListeners();
    } catch (e, s) {} finally {
      setIdle();
    }
  }
  reload() async{
    earnSumData = await UserRepository.getUserEarnSumData();
    notifyListeners();
  }
}

class FineritCodeInfoListModel
    extends FineritCodeInfoViewStateRefreshListModel {
  @override
  Future<List> loadData({int pageNum, int year, int month}) async {
    return await WalletRepository.fetchFineritCodeInfoDetail(
        page: pageNum, year: year, month: month);
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

class EarnCodeInfoListModel extends ViewStateRefreshListModel {
  int _year = DateTime.now().year;
  int _month = DateTime.now().month;
  int _day = DateTime.now().day;

  @override
  Future<List> loadData({int pageNum, int year, int month, int day}) async {
    return await WalletRepository.fetchEarnCodeInfoDetail(
        page: pageNum, year: _year, month: _month, day: _day);
  }

  @override
  initData() {
    return super.initData();
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }

  onRefreshEarnCodeInfo(int year, int month, int day) {
    _year = year;
    _month = month;
    _day = day;
    this.refresh();
  }
}

class UserInviteModel extends ViewStateRefreshListModel{
  String type;
  TeamFather fatherData;
  UserInviteModel({this.type});
  @override
  Future<List> loadData({int pageNum}) async {
    fatherData=await UserRepository.getFatherInviteAndInviteNum();
    return await UserRepository.getChildInvite(pageNum,type: type);
  }

}
