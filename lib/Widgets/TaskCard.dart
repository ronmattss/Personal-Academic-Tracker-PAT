//Contains To do List which is an individual Task which also contains list of sub to do on that task
import 'package:mysql1/mysql1.dart' as sql;
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:intl/intl.dart';

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

class ToDoCard extends StatefulWidget {
  final String toDoTitle;
  final String toDoDescription;
  final int todoID;
  final int isComplete;

  ToDoCard(
      {this.toDoDescription,
      this.toDoTitle = 'Write Chapter 2',
      this.isComplete,
      this.todoID});

  @override
  State<StatefulWidget> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  var timeDilation;
  String title = "title";
  Text textIfNotChecked;
  Text textIfChecked;
  Text currentText;
  bool flagComplete;

  @override
  void initState() {
    flagComplete = widget.isComplete == 1 ? true : false;
    textIfNotChecked = new Text(widget.toDoTitle,
        style: TextStyle(color: Colors.white, fontSize: 25));
    textIfChecked = new Text(
      widget.toDoTitle,
      style: TextStyle(
          decoration: TextDecoration.lineThrough,
          fontSize: 25,
          color: Colors.white),
    );
    currentText = textIfNotChecked;
    title = "hehe";
    super.initState();
  }

  // Prefer This
  Widget _customTaskTileSet(BuildContext context) {
    Query.currentTodo = widget.todoID;
    print("Current Todo ID = ${Query.currentTodo}");
    DatabaseHelper dbLoader = new DatabaseHelper();
    sql.Results results;
    final TextEditingController _todoNameController =
        new TextEditingController();
    final TextEditingController _todoDescriptionController =
        new TextEditingController();
    _todoNameController.text = widget.toDoTitle;
    _todoDescriptionController.text = widget.toDoDescription;
    String todoName = _todoNameController.text;
    String todoDescription = _todoDescriptionController.text;

    void updateTodo() async {
      print(todoName);
      print(todoDescription);
      results = await dbLoader.connectDB(Query.updateTaskTodo(
          todoName: todoName,
          todoDesc: todoDescription,
          isComplete: flagComplete,
          todoID: Query.currentTodo));
      setState(() {
        if (results.affectedRows > 0)
          Navigator.of(context, rootNavigator: true).pop();
      });
    }

    void updateCompleteFlag(bool flag) async {
      print("Flagged: $flag ${Query.currentTodo}");
      print(todoName);
      print(todoDescription);
      results = await dbLoader.connectDB(Query.updateTodoComplete(
          isComplete: flag, todoID: Query.currentTodo));
      setState(() {});
    }

    void deleteTodo() async {
      results = await dbLoader
          .connectDB(Query.deleteTaskTodo(todoID: widget.todoID));
    }

    return ListTile(
      onLongPress: () {
        Query.currentTodo = widget.todoID;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Update Todo ${Query.currentTodo}"),
                content: Container(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 30,
                        ),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: _todoNameController,
                          onChanged: (String value) => todoName = value,
                          decoration: InputDecoration(
                            hintText: 'Add Todo',
                            labelText: 'Todo Name',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 30,
                        ),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: _todoDescriptionController,
                          onChanged: (String value) => todoDescription = value,
                          decoration: InputDecoration(
                            hintText: 'Add Todo Description',
                            labelText: ' Todo Description',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 2,
                              child: ElevatedButton(
                                child: Text("Add"),
                                onPressed: () {
                                  setState(() {
                                    updateTodo();
                                  });
                                },
                              )), // Add Database Entry and Pop
                          Flexible(
                              flex: 2,
                              child: ElevatedButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                },
                              )),
                          Flexible(
                              flex: 2,
                              child: ElevatedButton(
                                child: Text("Delete"),
                                onPressed: () {
                                  setState(() {
                                    deleteTodo();
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                },
                              )), // pop cancel
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
      leading: Checkbox(
        value: flagComplete == true,
        onChanged: (bool value) {
          setState(() {
            flagComplete = value ? true : false;
            currentText = flagComplete ? textIfChecked : textIfNotChecked;
            title = value ? "woo" : "wee";
            updateCompleteFlag(flagComplete);
            // TODO: Update to do
          });
        },
      ),
      title: currentText,
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
