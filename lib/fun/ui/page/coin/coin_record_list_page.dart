import 'package:flutter/material.dart';
import 'package:campus_benefit_app/fun/config/router_manger.dart';
import 'package:campus_benefit_app/fun/model/coin_record.dart';
import 'package:campus_benefit_app/fun/provider/provider_widget.dart';
import 'package:campus_benefit_app/fun/provider/view_state_widget.dart';
import 'package:campus_benefit_app/fun/ui/helper/refresh_helper.dart';
import 'package:campus_benefit_app/fun/ui/widget/skeleton.dart';
import 'package:campus_benefit_app/fun/view_model/coin_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 积分记录
class CoinRecordListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('积分明细'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '排行榜',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, RouteName.coinRankingList);
            },
          )
        ],
      ),
      body: ProviderWidget<CoinRecordListModel>(
        model: CoinRecordListModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.busy) {
            return SkeletonList(
              length: 11,
              builder: (context, index) => CoinRecordItemSkeleton(),
            );
          } else if (model.error) {
            return ViewStateWidget(onPressed: model.initData);
          } else if (model.empty) {
            return ViewStateEmptyWidget(onPressed: model.initData);
          }
          return SmartRefresher(
              controller: model.refreshController,
              header: WaterDropHeader(),
              footer: RefresherFooter(),
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: true,
              child: ListView.separated(
                  itemCount: model.list.length,
                  separatorBuilder: (context, index) => Divider(
                        indent: 10,
                        endIndent: 10,
                        height: 1,
                      ),
                  itemBuilder: (context, index) {
                    // desc": "2019-08-28 10:09:15 签到,积分：10 + 12"
                    // desc 提出 bug #issues/174 ,积分+10
                    CoinRecord item = model. list[index];
                    String dateTime =
                        DateTime.fromMillisecondsSinceEpoch(item.date)
                            .toString()
                            .substring(0, 19);
                    String title;
                    String coin;
                    if (item.type == 1) {
                      //签到
                      title = '签到';
                      coin = item.desc.substring(item.desc.indexOf('：') + 1);
                    } else if (item.type == 99) {
                      //修复bug
                      title = item.desc.substring(0,item.desc.indexOf(','));
                      coin= item.coinCount.toString();
                    }else{
                      title ='其他类型';
                      coin= item.coinCount.toString();
                    }
                    return ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      onTap: () {},
                      title: Text(title),
                      subtitle: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(dateTime)),
                      trailing: Text(
                        coin,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    );
                  }));
        },
      ),
    );
  }
}

class CoinRecordItemSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BottomBorderDecoration(),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          title: UnconstrainedBox(
              alignment: Alignment.centerLeft,
              child: SkeletonBox(width: 80, height: 10)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SkeletonBox(width: 180, height: 10),
          ),
          trailing: SkeletonBox(width: 50, height: 10)),
    );
  }
}
