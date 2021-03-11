
import 'package:campus_benefit_app/models/system_static_info.dart';
import 'package:campus_benefit_app/providers/view_state_model.dart';
import 'package:campus_benefit_app/service/system_repository.dart';
import 'package:flutter/cupertino.dart';

class SystemStaticModel extends ViewStateModel {

  int tabPageSelectedIndex = 0;
  PageController tabPageController;
  SystemStaticInfo _systemStaticInfo;

  SystemStaticInfo get systemStaticInfo => _systemStaticInfo;

  SystemStaticModel() {
    initData();
  }
  initData() async {
    setBusy();
    _systemStaticInfo =await SystemRepository.getStaticInfo() as SystemStaticInfo;
    setIdle();
  }

  jumpTabPageTo(int index){
    if (tabPageController != null) {
      tabPageSelectedIndex = index;
      notifyListeners();
      tabPageController.jumpToPage(index);
    }
  }

}