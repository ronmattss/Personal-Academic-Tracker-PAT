//Contains To do List which is an individual Task which also contains list of sub to do on that task

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreCard extends StatefulWidget {
  final String activityTitle;
  final String activityDescription;
  final String activityScore;

  ScoreCard(
      {this.activityTitle = 'taskTitle',
      this.activityDescription = 'taskSubtitle',
      this.activityScore = 'subject'});

  @override
  State<StatefulWidget> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  String title = "title";
  Text currentText;

  @override
  void initState() {
    currentText =
        new Text(widget.activityTitle, style: TextStyle(color: Colors.black));
    title = "hello";
    super.initState();
  }

  // Prefer This
  Widget _customCardTileSet(BuildContext context) {
    return ListTile(
      leading: Text("1"),
      title: currentText,
      subtitle: Text(widget.activityDescription),
      trailing: Text(widget.activityScore),
      onTap: () {
        setState(() {
          // Go to Subject Page
          title = "test";
          print(title);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return _customCardTileSet(context);
  }
}
