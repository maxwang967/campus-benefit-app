import 'dart:async';
import 'dart:html' if (dart.library.io) 'dart:io';
import 'package:campus_benefit_app/ui/widgets/appbar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;


class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  WebViewPage({this.title, this.url});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.url,
      (int viewId) => IFrameElement()
        ..width = '640'
        ..height = '360'
        ..src = widget.url == null? "https://www.baidu.com":widget.url
        ..style.border = 'none');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title == null? "测试标题":widget.title, style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: HtmlElementView(viewType: widget.url),
    );
  }
}

class WebViewTitle extends StatelessWidget {
  final String title;
  final Future<bool> future;

  WebViewTitle({this.title, this.future});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FutureBuilder<bool>(
          future: future,
          initialData: false,
          builder: (context, snapshot) => snapshot.data
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(right: 5), child: AppBarIndicator()),
        ),
        Expanded(
            child: Text(
          //移除html标签
          removeHtmlLabel(title),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16),
        ))
      ],
    );
  }
}

String removeHtmlLabel(String data) {
  return data?.replaceAll(RegExp('<[^>]+>'), '');
}
