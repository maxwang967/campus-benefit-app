import 'dart:io';
import 'dart:ui';

import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/auth_utils.dart';
import 'package:campus_benefit_app/models/qqz_job_data_list.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/service/job_repository.dart';
import 'package:campus_benefit_app/ui/icons/finerit_color.dart';
import 'package:campus_benefit_app/ui/widgets/search_bar.dart';
import 'package:campus_benefit_app/view_models/job/job_page_model.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class JobTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return JobTaskPageState();
  }
}

class JobTaskPageState extends State<JobTaskPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: QQZJobTaskPage(),
    );
  }
}

class QQZJobTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QQZJobTaskPageState();
  }
}

class QQZJobTaskPageState extends State<QQZJobTaskPage> {
  QQZJobDataListModel globalModel;
  GZXDropdownMenuController _dropdownMenuController =
      GZXDropdownMenuController();
  List<String> _dropDownHeaderItemStrings = ['恢复默认', '全部类型', '综合排序', '等级过滤'];
  GlobalKey _stackKey = GlobalKey();
  List _typeConditions = [];
  List _synthesizeConditions = [];
  List _priceConditions = [];
  var _selectTypeSortCondition;
  var _selectSynthesizeSortCondition;
  var _selectPriceSortCondition;
  TextEditingController controller = TextEditingController();
  bool loading = false;
  String search = '';
  Future<void> loadCategory() async {
    _typeConditions = [];
    _synthesizeConditions = [];
    _priceConditions = [];
    var data = await JobRepositroy.fetchQQZJobCategory();
    for (var item in data['category']) {
      item['isSelected'] = false;
      _typeConditions.add(item);
    }
    for (var item in data['random_reward_level']) {
      item['isSelected'] = false;
      _priceConditions.add(item);
    }
    for (var item in data['filter']) {
      item['isSelected'] = false;
      _synthesizeConditions.add(item);
    }
    data['filter'][0]['isSelected'] = true;
    data['random_reward_level'][0]['isSelected'] = true;
    data['category'][0]['isSelected'] = true;
    _selectTypeSortCondition = null;
    _selectSynthesizeSortCondition = null;
    _selectPriceSortCondition = null;
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      loadCategory();
      loading = true;
    }
    return new Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.white,
            title: Text(
              '全部任务',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: const Text(
          '领奖',
          style: TextStyle(color: Colors.white),
        ),
        heroTag: null,
        foregroundColor: FineritColor.color1_normal,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 10.0,
        highlightElevation: 14.0,
        onPressed: () {
          ErrorUtils.auth401Error(context, () {
            Navigator.pushNamed(context, RouteName.webView, arguments: [
              "兼职任务",
              "${Config.BASE_URL}job/qqz_join/?status=3&token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
            ]);
          });
        },
        shape: new CircleBorder(),
        isExtended: false,
      ),
      body: Stack(
        key: _stackKey,
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      padding: EdgeInsets.only(
                        top: Platform.isIOS?0:MediaQueryData.fromWindow(window).padding.top,
                      ),
                      child: Center(
                        child: new Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20),
                                width: 40,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Expanded(
                              child: SearchBar(
                                searchBarWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                                controller: controller,
                              ),
                            ),
                            GestureDetector(
                              child: new Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                margin: EdgeInsets.only(right: 20),
                                height: 32,
                                child: Text("搜索",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                              ),
                              onTap: () {
                                for (var item in _typeConditions) {
                                  item['isSelected'] = false;
                                }
                                for (var item in _synthesizeConditions) {
                                  item['isSelected'] = false;
                                }
                                for (var item in _priceConditions) {
                                  item['isSelected'] = false;
                                }
                                _dropDownHeaderItemStrings = [
                                  '恢复默认',
                                  '全部类型',
                                  '综合排序',
                                  '难度过滤'
                                ];
                                _selectTypeSortCondition = null;
                                _selectSynthesizeSortCondition = null;
                                _selectPriceSortCondition = null;
                                search = controller.text;
                                controller.clear();
                                //TODO refresh model
                                if (globalModel != null || globalModel.idle) {
                                  globalModel.search = search;
                                  globalModel.level = null;
                                  globalModel.type = null;
                                  globalModel.catId = null;
                                  globalModel.refresh();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GZXDropDownHeader(
                // 下拉的头部项，目前每一项，只能自定义显示的文字、图标、图标大���������修改
                items: [
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[1]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[2]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[3]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[0],
                      iconData: Icons.remove_circle_outline, iconSize: 0),
                ],
                // GZXDropDownHeader对应第一父级Stack的key
                stackKey: _stackKey,
                // controller用于控制menu的显示或隐藏
                controller: _dropdownMenuController,
                // 当点击头部项的事件，在这里可以进行页面跳转或openEndDrawer
                onItemTap: (index) {
                  if (index == 3) {
                    for (var item in _typeConditions) {
                      item['isSelected'] = false;
                    }
                    for (var item in _synthesizeConditions) {
                      item['isSelected'] = false;
                    }
                    for (var item in _priceConditions) {
                      item['isSelected'] = false;
                    }
                    _dropDownHeaderItemStrings = [
                      '恢复默认',
                      '全部类型',
                      '综合排序',
                      '难度过滤'
                    ];
                    _selectTypeSortCondition = null;
                    _selectSynthesizeSortCondition = null;
                    _selectPriceSortCondition = null;
                    search = '';
                    _dropdownMenuController.hide();
                    if (globalModel != null || globalModel.idle) {
                      globalModel.search = search;
                      globalModel.level = null;
                      globalModel.type = null;
                      globalModel.catId = null;
                      globalModel.refresh();
                    }
                    if (!mounted) return;
                    setState(() {});
                  }
                },
              ),
              new Expanded(child: buildListView()),
            ],
          ),
          GZXDropDownMenu(
            // controller用于控制menu的显示或隐藏
            controller: _dropdownMenuController,
            // 下拉菜单显示或隐藏动画时长
            animationMilliseconds: 200,
            // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
            menus: [
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * _typeConditions.length.toDouble(),
                  dropDownWidget:
                      _buildConditionListWidget_1(_typeConditions, (value) {
                    _selectTypeSortCondition = value;
                    _dropDownHeaderItemStrings[1] =
                        _selectTypeSortCondition['cat_name'];
                    search = '';
                    _dropdownMenuController.hide();
                    if (globalModel != null || globalModel.idle) {
                      globalModel.search = search;
                      globalModel.catId = _selectTypeSortCondition['cat_id'];
                      globalModel.refresh();
                    }
                    if (!mounted) return;
                    setState(() {});
                  })),
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * _synthesizeConditions.length.toDouble(),
                  dropDownWidget: _buildConditionListWidget_2(
                      _synthesizeConditions, (value) {
                    _selectSynthesizeSortCondition = value;
                    _dropDownHeaderItemStrings[2] =
                        _selectSynthesizeSortCondition['name'];
                    search = '';
                    _dropdownMenuController.hide();
                    if (globalModel != null || globalModel.idle) {
                      globalModel.search = search;
                      globalModel.type =
                          _selectSynthesizeSortCondition['value'];
                      globalModel.refresh();
                    }
                    if (!mounted) return;
                    setState(() {});
                  })),
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * _priceConditions.length.toDouble(),
                  dropDownWidget:
                      _buildConditionListWidget_3(_priceConditions, (value) {
                    _selectPriceSortCondition = value;
                    _dropDownHeaderItemStrings[3] =
                        _selectPriceSortCondition['name'];
                    search = '';
                    if (globalModel != null || globalModel.idle) {
                      globalModel.search = search;
                      globalModel.level = _selectPriceSortCondition['id'];
                      globalModel.refresh();
                    }
                    _dropdownMenuController.hide();
                    if (!mounted) return;
                    setState(() {});
                  })),
            ],
          ),
        ],
      ),
    );
  }

  _buildConditionListWidget_1(items, void itemOnTap(var sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        var goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value['isSelected'] = false;
            }
            goodsSortCondition['isSelected'] = true;

            itemOnTap(goodsSortCondition);
          },
          child: Container(
//            color: Colors.blue,
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    goodsSortCondition['cat_name'],
                    style: TextStyle(
                      color: goodsSortCondition['isSelected']
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
                goodsSortCondition['isSelected']
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildConditionListWidget_2(items, void itemOnTap(var sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        var goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value['isSelected'] = false;
            }
            goodsSortCondition['isSelected'] = true;

            itemOnTap(goodsSortCondition);
          },
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    goodsSortCondition['name'],
                    style: TextStyle(
                      color: goodsSortCondition['isSelected']
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
                goodsSortCondition['isSelected']
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildConditionListWidget_3(items, void itemOnTap(var sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        var goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value['isSelected'] = false;
            }
            goodsSortCondition['isSelected'] = true;

            itemOnTap(goodsSortCondition);
          },
          child: Container(
//            color: Colors.blue,
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    '${goodsSortCondition['name']}|${goodsSortCondition['desc']}',
                    style: TextStyle(
                      color: goodsSortCondition['isSelected']
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                ),
                goodsSortCondition['isSelected']
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildListView() {
    return Container(
      alignment: Alignment.topCenter,
      child: ProviderWidget<QQZJobDataListModel>(
        builder:
            (BuildContext context, QQZJobDataListModel model, Widget child) {
          if (model.busy) {
            return ViewStateBusyWidget();
          } else if (model.error) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          } else if (model.empty) {
            return Column(
              children: <Widget>[
                Expanded(child: ViewStateEmptyWidget(onPressed: model.initData))
              ],
            );
          }
          return SmartRefresher(
            controller: model.refreshController,
            onRefresh: model.refresh,
            enablePullUp: true,
            enablePullDown: false,
            onLoading: model.loadMore,
            child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: model.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return QQZTaskCardDetail(data: model.list[index]);
                }),
          );
        },
        model: QQZJobDataListModel(),
        onModelReady: (model) {
          model.initData();
          globalModel = model;
        },
      ),
    );
  }
}

class QQZTaskCardDetail extends StatefulWidget {
  final JobQQZData data;
  QQZTaskCardDetail({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return QQZTaskCardDetailState();
  }
}

class QQZTaskCardDetailState extends State<QQZTaskCardDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black12, width: 0.5), // 边色与边宽度
        //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
      ),
      child: new FlatButton(
          onPressed: () {
            ErrorUtils.auth401Error(context, () {
              Navigator.pushNamed(context, RouteName.webView, arguments: [
                "任务",
                "${Config.BASE_URL}job/qqz_job_detail/${widget.data.rewardId}/?token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
              ]);
            });
          },
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: new NetworkImage(widget.data.avatar),
                    radius: 18,
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 8),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            widget.data.rewardTitle,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ),
                        new Container(
                          child: Text(
                            '${widget.data.totalVotes}人已赚,剩余${widget.data.surplusVotes}个',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Expanded(
                      child: Container(
                    alignment: Alignment.centerRight,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '赏${widget.data.applyPrice}元',
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0x10000000),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      '${widget.data.catName}',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                  Container(
                    width: 8,
                  ),
                  new Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0x10000000),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      '${widget.data.tagsName}',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
