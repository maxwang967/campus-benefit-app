import 'package:campus_benefit_app/core/config/config.dart';
import 'package:campus_benefit_app/core/managers/storage_manager_native.dart' if (dart.library.html) 'package:campus_benefit_app/core/managers/storage_manager_web.dart';
import 'package:campus_benefit_app/core/routers/app_router.dart';
import 'package:campus_benefit_app/core/utils/auth_utils.dart';
import 'package:campus_benefit_app/models/qqz_job_data_list.dart';
import 'package:flutter/material.dart';

class QQZBaseTaskCardDetail extends StatefulWidget{
  final JobQQZData data;
  QQZBaseTaskCardDetail(this.data);

  @override
  State<StatefulWidget> createState() {
    return QQZBaseTaskCardDetailState();
  }
}
class QQZBaseTaskCardDetailState extends State<QQZBaseTaskCardDetail>{

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10,bottom: 10),
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black12, width: 0.5), // 边色与边宽度
        //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
      ),
      child: new FlatButton(
          onPressed: (){
            ErrorUtils.auth401Error(context, () {
            Navigator.pushNamed(context, RouteName.webView, arguments: [
              "任务",
              "${Config.BASE_URL}job/qqz_job_detail/${widget.data.rewardId}/?token=${StorageManager.sharedPreferences.getString(Config.TOKEN_KEY)}"
            ]);
          });
          },
          child:new Column(
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
                          margin: EdgeInsets.only(top: 4,bottom: 4),
                          child: Text(widget.data.rewardTitle,style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w400,fontSize: 15),),
                        ),
                        new Container(
                          child: Text('${widget.data.totalVotes}人已赚,剩余${widget.data.surplusVotes}个',style: TextStyle(color: Colors.grey),),
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
                              child: Text('赏${widget.data.applyPrice}元',style: TextStyle(fontSize: 15,color: Colors.blue),),
                            ),
                          ],
                        ),
                      )
                  ),
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
                    child: Text(widget.data.catName,style: TextStyle(fontSize: 12,color: Colors.black54),),
                  ),
                  Container(width: 8,),
                  new Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0x10000000),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(widget.data.tagsName,style: TextStyle(fontSize: 12,color:Colors.black54),),
                  ),
                ],
              )
            ],
          )
//          child: new Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  CircleAvatar(
//                    backgroundImage: new NetworkImage(model.baseJobQQZDataList[index].avatar),
//                    radius: 18,
//                  ),
//                  new Container(
//                    margin: EdgeInsets.only(left: 8),
//                    child: new Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        new Container(
//                          margin: EdgeInsets.only(top: 4,bottom: 4),
//                          child: Text(model.baseJobQQZDataList[index].rewardTitle,style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.w400,fontSize: 15),),
//                        ),
//                        new Container(
//                          child: Text('${model.baseJobQQZDataList[index].totalVotes}人已赚,剩余${model.baseJobQQZDataList[index].surplusVotes}个',style: TextStyle(color: Colors.grey),),
//                        ),
//                      ],
//                    ),
//                  ),
//                  new Expanded(
//                      child: Container(
//                        alignment: Alignment.centerRight,
//                        child: new Column(
//                          crossAxisAlignment: CrossAxisAlignment.end,
//                          children: <Widget>[
//                            Container(
//                              child: Text('赏${model.baseJobQQZDataList[index].applyPrice}凡尔币',style: TextStyle(fontSize: 15,color: Colors.red),),
//                            ),
//                          ],
//                        ),
//                      )
//                  ),
//                ],
//
//              ),
//              Row(
//                children: <Widget>[
//                  new Container(
//                    padding: EdgeInsets.all(5),
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                      color: Color(0x10000000),
//                      borderRadius: BorderRadius.circular(3),
//                    ),
//                    child: Text('${model.baseJobQQZDataList[index].catName}',style: TextStyle(fontSize: 12,color: Colors.black54),),
//                  ),
//                  Container(width: 8,),
//                  new Container(
//                    padding: EdgeInsets.all(5),
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                      color: Color(0x10000000),
//                      borderRadius: BorderRadius.circular(3),
//                    ),
//                    child: Text('${model.baseJobQQZDataList[index].tagsName}',style: TextStyle(fontSize: 12,color:Colors.black54),),
//                  ),
//                ],
//              )
//            ],
//          )

      ),
    );
  }

}