

import 'package:campus_benefit_app/ui/widgets/my_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HintWidget extends StatelessWidget{
  final String title;
  final String subtitle;
  final String content;
  HintWidget({this.title,this.subtitle,this.content}):super();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: MyCard(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Theme.of(context).cardColor,
          child: ExpansionTile(
            subtitle: Text(
              "$subtitle",
              style: TextStyle(color: Colors.grey),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("$title"),
              ],
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: kIsWeb
                    ? Text(
                  "$content",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor),
                )
                    : Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "$content",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                      style: TextStyle(
                          color:
                          Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}