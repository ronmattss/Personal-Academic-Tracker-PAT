//Contains To do List which is an individual Task which also contains list of sub to do on that task

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Views/SubjectPage.dart';

class TaskCard extends StatefulWidget {
 final String taskTitle;
 final String taskSubtitle;
 final String taskSubject;
   TaskCard([this.taskTitle='taskTitle',this.taskSubtitle='taskSubtitle',this.taskSubject='subject']);
  @override
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  var timeDilation;
   String title = "tite";
   Text textIfNotChecked;
  Text textIfChecked;
  Text currentText;
  @override
  void initState()
  {
    textIfNotChecked= new Text(widget.taskTitle,style:TextStyle(color: Colors.black));
    textIfChecked = new Text(widget.taskTitle,style: TextStyle(decoration: TextDecoration.lineThrough),);
    currentText = textIfNotChecked;
    title = "hehe";
    super.initState();
  }

  // Prefer This
  Widget _customTaskTileSet(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: timeDilation == true,
        onChanged: (bool value) {
          setState(() {
            timeDilation = value ? true : false;
            currentText = timeDilation ? textIfChecked:textIfNotChecked;
            title = value ? "woo":"wee";
          });
        },
      ),
      title: currentText,
      subtitle: Text(widget.taskSubtitle),trailing: Text(widget.taskSubject),
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
