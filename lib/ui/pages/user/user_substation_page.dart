import 'package:campus_benefit_app/core/utils/chat_utils.dart';
import 'package:campus_benefit_app/providers/provider_widget.dart';
import 'package:campus_benefit_app/providers/view_state_widget.dart';
import 'package:campus_benefit_app/service/user_repository.dart';
import 'package:campus_benefit_app/ui/pages/user/distribution/user_distribution_list_page.dart';
import 'package:campus_benefit_app/ui/widgets/hint_widget.dart';
import 'package:campus_benefit_app/ui/widgets/my_card.dart';
import 'package:campus_benefit_app/view_models/base/system_static_model.dart';
import 'package:campus_benefit_app/view_models/base/user_model.dart';
import 'package:campus_benefit_app/view_models/user/user_page_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class UserSubstationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserSubstationPageState();
}

class UserSubstationPageState extends State<UserSubstationPage> {

  String shortUrl;

  @override
  void initState() {
    super.initState();
    UserRepository.getShortUrl().then((value)  {
      setState(() {
        shortUrl = value.url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("分享躺赚"),
          actions: <Widget>[],
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: ListTileTheme(
                  child: Column(
                    children: <Widget>[




                    ]..addAll(buidHind())..add( SizedBox(
                        height: 10
                    ))..add( Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: MyCard(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("链接"),
                              Text("$shortUrl",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  )),
                              GestureDetector(
                                child: Text("复制",
                                    style: TextStyle(color: Colors.blue)),
                                onTap: () {
                                  showToast("复制成功");
                                  Clipboard.setData(new ClipboardData(text: shortUrl));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ))..add( SizedBox(
                        height: 10
                    ))..add(
                        kIsWeb
                            ? Container():Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                      child: FlatButton(
                        onPressed: () {
                          SystemStaticModel model = Provider.of<SystemStaticModel>(context);
                          ChatUtils.shareGrid(context
                              ,url:shortUrl
                              ,title: model.systemStaticInfo.myPageData.substationPage.share.title
                              ,content: model.systemStaticInfo.myPageData.substationPage.share.content);
                        },
                        child: Container(
                          width:
                          MediaQuery.of(context).size.width ,
                          height: 50,
                          child: Center(
                            child: Text(
                              "一键分享",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        color: Colors.blue[400],
                      ),
                    )),
                  )),
            ),
          ],
        )
    );
  }
  List<Widget> buidHind(){
    SystemStaticModel staticModel = Provider.of<SystemStaticModel>(context);
    return staticModel.systemStaticInfo.myPageData.substationPage.hint.
    map((e) {
      return HintWidget(title: e.title,subtitle: e.subtitle,content: e.content);
    }).toList();
  }
}
