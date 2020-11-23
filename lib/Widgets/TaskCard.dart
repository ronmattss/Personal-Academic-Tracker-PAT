//Contains To do List which is an individual Task which also contains list of sub to do on that task

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Views/SubjectPage.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  var timeDilation;
   String title = "tite";
  @override
  void initState()
  {
    super.initState();
    title = "hehe";
  }

  // Prefer This
  Widget _customTaskTileSet(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: timeDilation == true,
        onChanged: (bool value) {
          setState(() {
            timeDilation = value ? true : false;
            title = value ? "woo":"wee";
          });
        },
      ),
      title: Text("Task Title"),
      subtitle: Text(title),
      onTap: () {
        setState(() {       // Go to Subject Page
          title = "weeeeeeeeeeeeee";
          print(title);
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return _customTaskTileSet(context);
  }
}
