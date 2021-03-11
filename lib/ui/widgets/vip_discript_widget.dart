

import 'dart:io';

import 'package:flutter/material.dart';

class VipDiscriptWidget extends StatelessWidget{
  VipDiscriptWidget({this.levelDesignation,this.isOpening,this.isAnnual, this.iconsize}):super();
  double iconsize;
  String levelDesignation;
  bool isAnnual;
  bool isOpening;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return levelDesignation!='0'?Container(
      margin: EdgeInsets.only(left: 1,top: 0),
      child: isAnnual==false?VipIcon(
        iconsize: iconsize==null?0.6:iconsize,
        isOpen: isOpening,
      ):SVipIcon(viplevel: levelDesignation,iconsize: iconsize,),
    ):Container();
  }

}

class SVipIcon extends StatelessWidget{
  String viplevel = "0";
  double iconsize = 1;
  SVipIcon({@required this.viplevel,@required this.iconsize}):super();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 40*iconsize,
      height: 32*iconsize,
      child:
      Image(image: AssetImage("assets/images/vipYear.png"),
        fit: BoxFit.fill,
      ),
    );
  }
}

class VipIcon extends StatelessWidget{
  String viplevel = "0";
  double iconsize = 1;
  double _fontsizeauto = 14;
  bool isOpen;
  VipIcon({@required this.iconsize,@required this.isOpen}):super();
  @override
  Widget build(BuildContext context) {
    if(double.parse(viplevel)>=10){
      _fontsizeauto=12;
    }
    return viplevel!='0'?Container(
      alignment: Alignment(0.1, -0.35),
      width: 40*iconsize,
      height: 32*iconsize,
      child: Text(
        "v"+viplevel,
        style: TextStyle(color: Colors.white, fontSize: _fontsizeauto*iconsize,),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isOpen==false?AssetImage("assets/images/vipiconnone.png"):AssetImage("assets/images/vipicon.png"),
          fit: BoxFit.fill,
        ),
      ),
    ): Row(
      children: <Widget>[
        Container(
//            child: Text(
//              "未开通",
//              style: TextStyle(color: Colors.white, fontSize: _fontsizeauto*iconsize/2,),
//            ),
//            alignment: Alignment(0.1, -0.35),
            width: 40*iconsize,
            height: 32*iconsize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: isOpen==false?AssetImage("assets/images/vipNone.png"):AssetImage("assets/images/vipOpen.png"),
                fit: BoxFit.fill,
              ),
            )
        ),
      ],
    );
  }

}