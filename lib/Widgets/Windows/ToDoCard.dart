import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

class ToDoCardWidget extends StatefulWidget {
  final int todoID;
  final int taskID;

  final String todoName;
  final String todoDescription;
  final int isComplete;

  ToDoCardWidget(
      [this.todoName = 'Sample To Do',
      this.isComplete = 0,
      this.taskID = 0,
      this.todoDescription = "Sample Description",
      this.todoID = 0]);

  @override
  State<StatefulWidget> createState() => TodoCardWidgetState();
}

class TodoCardWidgetState extends State<ToDoCardWidget> {
  Widget toDoCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          margin: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: SizedBox(
            height: 60,
            child: Column(
              children: [
                Padding(
                  child: ToDoCard(),
                  padding:
                      EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 5),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Material(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, left: 5),
                      child: SizedBox(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              "HELLO",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        width: 300,
        height: 300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return toDoCard(context);
  }
}

class TaskCardWidget extends StatefulWidget {
  final int taskID;

  final String taskName;
  final String taskDescription;
  final int isComplete;
  final String dateTime;
  final String deadline;

  TaskCardWidget(
      [this.taskName = 'Sample To Do',
      this.isComplete = 0,
      this.taskID = 0,
      this.taskDescription = "Sample Description",
      this.dateTime = "",
      this.deadline = ""]);

  @override
  State<StatefulWidget> createState() => TaskCardWidgetState();
}

class TaskCardWidgetState extends State<TaskCardWidget> {
  Widget toDoCard(BuildContext context) {
    return Card(child: ListTile(title: Text("${widget.taskName}"),subtitle: Text("${widget.deadline}"),));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return toDoCard(context);
  }
}
