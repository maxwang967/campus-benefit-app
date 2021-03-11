import 'package:flutter/material.dart';
import 'dart:ui';

class SearchBar extends StatefulWidget {
  final Function onSearchTextChanged;
  double searchBarWidth;
  TextEditingController controller;
  final String hintText;
  SearchBar({Key key, @required this.searchBarWidth, this.controller, this.hintText, this.onSearchTextChanged})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => new SearchBarState(
      searchBarWidth: searchBarWidth, controller: controller);
}

class SearchBarState extends State<SearchBar> {
  SearchBarState({Key key, @required this.searchBarWidth, this.controller})
      : super();
  TextEditingController controller;
  FocusNode _focusNode = FocusNode();
  double searchBarWidth;

  @override
  void initState() {
    if (controller != null) {
      controller.addListener(() {
        if (!mounted) return;
        setState(() {});
      });
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[100],
      ),
      width: searchBarWidth,
      height: 32,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new SizedBox(
            width: 5.0,
          ),
          new Icon(
            Icons.search,
            color: Colors.grey[300],
          ),
          new Expanded(
            child: Container(
              alignment: Alignment.center,
              child: new TextField(
                controller: controller,
                focusNode: _focusNode,
                decoration: new InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: widget.hintText == null?'任务名/任务ID搜索':widget.hintText,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    )),
                onChanged: widget.onSearchTextChanged??(value){},
              ),
            ),
          ),
          _focusNode.hasFocus
              ? new IconButton(
                  icon: new Icon(Icons.cancel),
                  color: Colors.grey,
                  iconSize: 18.0,
                  onPressed: () {
                    controller.clear();
                    if(widget.onSearchTextChanged!=null){
                      widget.onSearchTextChanged('');
                    }

                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
