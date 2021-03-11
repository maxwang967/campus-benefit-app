
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/ui/widgets/image_widget.dart';
import 'package:campus_benefit_app/view_models/user/user_page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserDistributionListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserDistributionListPageState();
}

class _UserDistributionListPageState extends State<UserDistributionListPage>
{

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInviteModel>(
      builder: (context,model,child){
        if (model.busy){
          return ViewStateBusyWidget();
        }
        // if (model.empty){
        //   return ViewStateEmptyWidget(onPressed: () {model.initData();},);
        // }
        if (model.error){
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        return 
        Scaffold(
          body: SmartRefresher(
            controller: model.refreshController,
            header: WaterDropMaterialHeader(),
            onRefresh: model.refresh,
            enablePullUp: true,
            onLoading: model.loadMore,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                        color: Colors.white,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 30),
                          dense: true,
                          title: Row(
                            children: <Widget>[
                              Container(
                                child: ClipOval(
                                    child: WrapperImage(
                                      url: '${model.list[index].invite.userinfo.headImg}',
                                      width: 40,
                                      height: 40,
                                    )),
                              ),
                              SizedBox(width: 10,),
                              Text('${model.list[index].invite.userinfo.phone}', style: TextStyle(fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: model.list.length,
                  ),
                )
              ],
            )
        )
        );
        
      },
    );

  }


}





