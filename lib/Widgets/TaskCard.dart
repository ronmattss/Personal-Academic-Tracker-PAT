//Contains To do List which is an individual Task which also contains list of sub to do on that task

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String taskTitle;
  final String taskSubtitle;
  final String taskSubject;

  TaskCard(
      [this.taskTitle = 'taskTitle',
      this.taskSubtitle = 'taskSubtitle',
      this.taskSubject = 'subject']);

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
  void initState() {
    textIfNotChecked =
        new Text(widget.taskTitle, style: TextStyle(color: Colors.black));
    textIfChecked = new Text(
      widget.taskTitle,
      style: TextStyle(decoration: TextDecoration.lineThrough),
    );
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
            currentText = timeDilation ? textIfChecked : textIfNotChecked;
            title = value ? "woo" : "wee";
          });
        },
      ),
      title: currentText,
      subtitle: Text(widget.taskSubtitle),
      trailing: Text(widget.taskSubject),
      onTap: () {
        setState(() {
          // Go to Subject Page
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

enum Priority { High, Low }

class PriorityTaskCard extends StatefulWidget {
  final String taskTitle;
  final String taskSubject;
  final Priority taskPriority;
  final bool isTaskFinished;

  PriorityTaskCard(
      [this.taskTitle = 'taskTitle',
      this.taskSubject = 'taskSubject',
      this.taskPriority = Priority.High,
      this.isTaskFinished = false]);

  @override
  State<StatefulWidget> createState() => _PriorityTaskCard();
}

class _PriorityTaskCard extends State<PriorityTaskCard> {
  var isFinished;
  String title = "tite";
  Text textIfNotChecked;
  Text textIfChecked;
  Text currentText;

  @override
  void initState() {
    textIfNotChecked =
        new Text(widget.taskTitle, style: TextStyle(color: Colors.black));
    textIfChecked = new Text(
      widget.taskTitle,
      style: TextStyle(decoration: TextDecoration.lineThrough),
    );
    currentText = textIfNotChecked;
    title = "hehe";
    super.initState();
  }

  // Prefer This
  Widget _priorityTaskCard(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isFinished == true,
        onChanged: (bool value) {
          setState(() {
            isFinished = value ? true : false;
            currentText = isFinished ? textIfChecked : textIfNotChecked;
            title = value ? "woo" : "wee";
          });
        },
      ),
      title: currentText,
      subtitle: Text(widget.taskSubject),
      trailing: Text(widget.taskPriority.toString().split('.').last),
      onTap: () {
        setState(() {
          // Go to Subject Page
          title = "weeeeeeeeeeeeee";
          print(title);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _priorityTaskCard(context);
  }
}

class PinnedTaskCard extends StatefulWidget {
  final String taskTitle;
  final String taskSubject;
  final bool isTaskFinished;

  PinnedTaskCard(
      [this.taskTitle = 'taskTitle',
      this.taskSubject = 'taskSubject',
      this.isTaskFinished = false]);

  @override
  State<StatefulWidget> createState() => _PinnedTaskCardState();
}

class _PinnedTaskCardState extends State<PinnedTaskCard> {
  bool isFinished;
  String title = "tite";
  Text textIfNotChecked;
  Text textIfChecked;
  Text currentText;
  Icon icon = new Icon(Icons.pin_drop);

  @override
  void initState() {
    isFinished = widget.isTaskFinished;
    textIfNotChecked =
        new Text(widget.taskTitle, style: TextStyle(color: Colors.black));
    textIfChecked = new Text(
      widget.taskTitle,
      style: TextStyle(decoration: TextDecoration.lineThrough),
    );
    currentText = textIfNotChecked;
    title = "hehe";
    super.initState();
  }

  Widget x(BuildContext) {
    return Icon(FluentSystemIcons.ic_fluent_share_close_tray_filled);
  }

  // Prefer This
  Widget _pinnedTaskCard(BuildContext context) {
    return ListTile(
      dense: true,
      leading: icon,
      title: currentText,
      subtitle: Text(widget.taskSubject),
      onTap: () {
        setState(() {
          // Go to Subject Page
          isFinished = !isFinished;
          icon =
              isFinished ? Icon(Icons.pin_drop_outlined) : Icon(Icons.pin_drop);
          title = "weeeeeeeeeeeeee";
          print(title);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _pinnedTaskCard(context);
  }
}
