import 'package:flutter/material.dart';


class PlatformIcon extends StatelessWidget{
  String platformName;
  String imagePath;
  double iconsize;
  PlatformIcon({Key key,@required this.platformName,@required this.imagePath,@required this.iconsize}):super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: new Image.asset(this.imagePath,),
          height: this.iconsize*3,
          width: this.iconsize*3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        new Text(this.platformName,style: TextStyle(fontSize: this.iconsize)),
  ]);
  }
}