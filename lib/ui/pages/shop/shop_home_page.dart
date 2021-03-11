import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart'
    if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/auth_utils.dart';
import 'package:campus_benefit_app/models/category_data_list.dart';
import 'package:campus_benefit_app/models/good_data_list.dart';
import 'package:campus_benefit_app/models/good_detail_data.dart';
import 'package:campus_benefit_app/models/order_data_list.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/service/job_repository.dart';
import 'package:campus_benefit_app/service/shop_repository.dart';
import 'package:campus_benefit_app/ui/widgets/image_widget.dart';
import 'package:campus_benefit_app/ui/widgets/search_bar.dart';
import 'package:campus_benefit_app/view_models/shop/shop_page_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class ShopHomePage extends StatefulWidget {
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage>
    with SingleTickerProviderStateMixin {
  // CategoryBigListModel listCategory = CategoryBigListModel([]);
  TabController _tabController;
  bool loading = false;
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    _tabController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<YYCategoryDataListModel, YYGoodListModel>(builder:
        (BuildContext context, YYCategoryDataListModel yyCategoryDataListModel,
            YYGoodListModel yyGoodListModel, Widget child) {
      if (loading == false) {
        yyGoodListModel.search = '';
        yyCategoryDataListModel.refresh();
        yyGoodListModel.refresh();
        loading = true;
      }
      if (yyCategoryDataListModel.busy || yyGoodListModel.busy) {
        return ViewStateBusyWidget();
      } else if (yyCategoryDataListModel.error) {
        return ViewStateErrorWidget(
            error: yyCategoryDataListModel.viewStateError,
            onPressed: yyCategoryDataListModel.initData);
      } else if (yyCategoryDataListModel.error) {
        return ViewStateErrorWidget(
            error: yyCategoryDataListModel.viewStateError,
            onPressed: yyCategoryDataListModel.initData);
      } else if (yyCategoryDataListModel.list.length == 0) {
        return ViewStateBusyWidget();
      }

      return Scaffold(
          appBar: new AppBar(
            title: Container(
              padding: EdgeInsets.only(
                left: 12,
                bottom: 12,
                right: 12,
                top: 10,
              ),
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: SearchBar(
                    searchBarWidth: MediaQuery.of(context).size.width * 0.85,
                    hintText: "商品名搜索",
                    controller: textEditingController,
                    onSearchTextChanged: (value) {
                      yyGoodListModel.search = value;
                      yyGoodListModel.refreshData();
                    },
                  )),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            bottom: new TabBar(
              tabs: <Widget>[
                Tab(text: "商城"),
                Tab(text: "订单"),
              ],
              indicatorColor: Colors.lightBlueAccent,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.black38,
              controller: _tabController,
              indicatorPadding: new EdgeInsets.only(bottom: 0.0),
            ),
            backgroundColor: Colors.white,
            elevation: 2,
          ),
          body: new TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[LeftCategoryNav(), CategoryGoodsList()],
                ),
              ),
              OrderDetailApp()
            ],
          ));
    });
  }

  // Widget _rightInkWell(
  //     ChildCategory data,
  //     YYCategoryDataListModel yyCategoryDataListModel,
  //     YYGoodListModel yyGoodListModel,
  //     int index) {
  //   bool isCheck = false;
  //   isCheck = index == yyCategoryDataListModel.selectedChildCategoryIndex;
  //   return InkWell(
  //     onTap: () {
  //       yyCategoryDataListModel.selectedChildCategoryIndex = index;
  //       yyCategoryDataListModel.notifyListeners();
  //       if (data.cid != -1) {
  //         yyGoodListModel.selectedCid = data.cid;
  //         yyGoodListModel.refresh();
  //       }
  //     },
  //     child: Container(
  //       alignment: Alignment.center,
  //       margin: EdgeInsets.only(left: 12),
  //       child: Text(
  //         data.name,
  //         style: TextStyle(
  //             fontSize: 14, color: isCheck ? Colors.blue : Colors.black45),
  //       ),
  //     ),
  //   );
  // }
}

class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  var listIndex = 0; //索引
  bool loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<YYCategoryDataListModel, YYGoodListModel>(
      builder: (BuildContext context,
          YYCategoryDataListModel yyCategoryDataListModel,
          YYGoodListModel yyGoodListModel,
          Widget child) {
        if (loading == false) {
          yyCategoryDataListModel.refresh();
          loading = true;
        }
        if (yyCategoryDataListModel.busy || yyGoodListModel.busy) {
          return ViewStateBusyWidget();
        } else if (yyCategoryDataListModel.error) {
          return ViewStateErrorWidget(
              error: yyCategoryDataListModel.viewStateError,
              onPressed: yyCategoryDataListModel.initData);
        } else if (yyCategoryDataListModel.error) {
          return ViewStateErrorWidget(
              error: yyCategoryDataListModel.viewStateError,
              onPressed: yyCategoryDataListModel.initData);
        }
        return Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            itemCount: yyCategoryDataListModel.list.length,
            itemBuilder: (context, index) {
              return _leftInkWel(
                  index, yyCategoryDataListModel, yyGoodListModel);
            },
          ),
        );
      },
    );
  }

  Widget _leftInkWel(index, YYCategoryDataListModel yyCategoryDataListModel,
      YYGoodListModel yyGoodListModel) {
    CategoryData data = yyCategoryDataListModel.list[index];
    bool isClick = false;
    isClick =
        (index == yyCategoryDataListModel.selectedCategoryIndex) ? true : false;
    // if (index == 0) {
    //   yyGoodListModel.selectedCid = data.cid[0];
    //   yyGoodListModel.refresh();
    // }
    return InkWell(
      onTap: () {
        yyCategoryDataListModel.selectedCategoryIndex = index;
        yyCategoryDataListModel.notifyListeners();
        yyGoodListModel.selectedCid = data.cid;
        yyGoodListModel.refreshData();
      },
      child: Container(
        alignment: Alignment(0, 0),
        height: 60,
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        decoration: BoxDecoration(
          color: isClick ? Colors.lightBlueAccent : Colors.white,
        ),
        child: Text(
          data.name,
          style: TextStyle(
              fontSize: 14, color: isClick ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // var scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    YYGoodListModel yyGoodListModel = Provider.of<YYGoodListModel>(context);
    return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.width / 4 * 3,
          child: ListView.builder(
            // controller: scrollController,
            itemCount: yyGoodListModel.list.length,
            itemBuilder: (context, index) {
              return _ListWidget(yyGoodListModel.list[index]);
            },
          )),
    );
  }

  Widget _ListWidget(GoodData data) {
    return InkWell(
        onTap: () {
          // ShopRepository.fetchGoodDetailData(data.gid).then((value){
          //     var item = value as GoodDetailData;
          ErrorUtils.auth401Error(context, () {
            Navigator.pushNamed(context, RouteName.webView, arguments: [
              "商品详情",
              "${Config.BASE_URL}shop/yy_submit_html/?gid=${data.gid}&&token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
            ]);
          });
          // });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 4),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 8,
              ),
              _goodsImage(data.image),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _goodsName(data.name),
                  _goodsPrice(data.currentPrice.toString())
                ],
              )
            ],
          ),
        ));
  }

  //商品图片
  Widget _goodsImage(String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      width: 60,
      child: WrapperImage(
        url: url,
        fit: BoxFit.fill,
        height: 70,
        width: 40,
      ),
    );
  }

  //商品名称方法
  Widget _goodsName(String name) {
    return Container(
        width: MediaQuery.of(context).size.width / 4 * 3 / 1.5,
        margin: EdgeInsets.only(top: 4.0, left: 12),
        child: Text(
          name.length > 10 ? name.substring(0, 10) + "..." : name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ));
  }

  //商品价格方法
  Widget _goodsPrice(String price) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 12),
      child: Text(
        '价格:${price}元',
        style: TextStyle(color: Colors.blue, fontSize: 14),
      ),
    );
  }
}

class OrderDetailApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderDetailAppState();
}

class OrderDetailAppState extends State<OrderDetailApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<OrderListModel>(
      builder: (BuildContext context, OrderListModel model, Widget child) {
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
        } else if (model.unAuthorized) {
          return ViewStateUnAuthWidget(onPressed: () {
            Navigator.of(context).pushNamed(RouteName.login).then((result) {
              print("success=$result");
              // 登录成功,获取数据,刷新页面
              if (result) {
                model.initData();
              }
            });
          });
        }
        return Scaffold(body: _buildBody(model));
      },
      model: OrderListModel(),
      onModelReady: (model) => model.initData(),
    );
  }

  Widget _buildBody(OrderListModel model) {
    return Container(
        alignment: Alignment.topCenter,
        child: ListView.builder(
            //ListView的Item
            itemCount: model.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Column(
                  children: <Widget>[_buildCard(model.list[index])],
                ),
              );
            }));
  }

  Widget _buildCard(OrderData data) {
    return OrderCard(data);
  }
}

class OrderCard extends StatefulWidget {
  OrderData data;
  OrderCard(this.data);
  @override
  OrderCardState createState() => OrderCardState();
}

class OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FlatButton(
        onPressed: () {},
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: 60,
                    child: WrapperImage(
                        url: widget.data.image, width: 60, height: 60)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8, top: 4),
                      // width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        widget.data.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, top: 4),
                      // width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        '购买数量：${widget.data.num}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
                        // width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(children: <Widget>[
                          Text(
                            '总价: ${widget.data.price}元',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ]))
                  ],
                ),
              ],
            ),
            GestureDetector(
              child: new Container(
                width: 60,
                alignment: Alignment.center,
                padding:
                    EdgeInsets.only(top: 2, bottom: 3), //只是为了给 Text 加一个内边距，好看点~
                child: Text(
                  '补单',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              onTap: () async {
                var result =
                    await JobRepositroy.refreshChangeOrder(widget.data.orderId);
                if (result['status'] == 0) {
                  showToast('补单成功，补单进行中');
                } else {
                  showToast(result['message']);
                }
              },
            )
          ],
        ),
      ),
      margin: EdgeInsets.only(top: 3),
      padding: EdgeInsets.all(5),
    );
  }
}
