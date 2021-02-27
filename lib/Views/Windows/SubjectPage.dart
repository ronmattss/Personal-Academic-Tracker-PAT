import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Views/Windows/SubjectDescriptionWidget.dart';
import 'package:personalacademictracker/Views/Windows/SubjectTrackableDescriptionWidget.dart';
import 'package:personalacademictracker/Widgets/ScoreCard.dart';
import 'package:personalacademictracker/Widgets/SubjectCard.dart';
import 'package:personalacademictracker/Widgets/SubjectPage/TaskView.dart';
import 'package:personalacademictracker/Widgets/SubjectPage/TrackableView.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

class Todo {
  int todoID;
  int taskID;
  String todoName;
  String todoDescription;
  int isComplete;
  Todo(
      {this.todoID,
      this.taskID,
      this.todoName,
      this.todoDescription,
      this.isComplete});
}

// Thie Page is the expanded version of the Lists
// Pass parameters and load database
class SubjectPage extends StatefulWidget {
  final int subjectID;

  SubjectPage({Key key, this.subjectID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubjectPageState();
}

// What this page do
// show Tasks and To Do
// Track deliverables
class _SubjectPageState extends State<SubjectPage> {
  bool dataLoadedFlag = false;
  DatabaseHelper dbHelper = new DatabaseHelper();
  Widget listOfTodos = new ToDoCard();
  Widget view = new TaskView();
  Widget taskDescription = SubjectDescriptionWidget();
  sql.Results result;
  List<sql.Row> rows;
  List<sql.Row> rowsTodo;
  List<sql.Row> grade;
  int lengthOfTodo = 0;
  List<Todo> todo = [];

  String projectedGrade;

  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    print(Query.userName);
    result = await dbHelper.connectDB(
        Query.getSpecificSubjectOfUser(Query.userName, widget.subjectID));
    rows = result.toList();
    result = await dbHelper.connectDB(Query.getUserProjectedGrade(Query.userName,widget.subjectID));
    grade = result.toList();
    dataLoadedFlag = true;
    setState(() {
      projectedGrade = grade[0][0].toString();
      view = TaskView(
        subjectID: widget.subjectID,
        key: UniqueKey(),
        onPressTask: (int value, TaskValue taskValue) {
          loadTodo(value);
          setState(() {
            taskDescription = new SubjectDescriptionWidget(
              taskNameDisplay: taskValue.taskName,
              isComplete: taskValue.taskIsdone,
              taskDescriptionDisplay: taskValue.taskDescription,
              todoLength: todo.length,
            );
          });
        },
      );
    });
  }

  void loadTodo(int taskID) async {
    result = await dbHelper.connectDB(
        Query.getUserTodos(Query.userName, widget.subjectID, taskID));
    Future<List<sql.Row>>.delayed(
      Duration(milliseconds: 500),
      () {
        return result.toList();
      },
    ).then((value) {
      dataLoadedFlag = true;
      rowsTodo = value;
      todo = new List<Todo>.generate(
          rowsTodo.length,
          (index) => Todo(
              todoID: rowsTodo[index][0],
              taskID: rowsTodo[index][1],
              todoName: rowsTodo[index][2],
              todoDescription: rowsTodo[index][3],
              isComplete: rowsTodo[index][4])).toList();
      setState(() {
        lengthOfTodo = todo.length;

      });
    });
  }

  // Crate left side Nav menu, right side le task
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return !dataLoadedFlag
        ? Container(color: Color(0xff439889))
        : FractionallySizedBox(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColorLight,
                    margin: EdgeInsets.zero,
                    width: 200,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Subject Here
                        Container(
                          width: 300,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            // Tasks list Go here
                            children: [
                              Container(
                                  width: 300,
                                  margin: EdgeInsets.zero,
                                  height: 150,
                                  child: Card(
                                    semanticContainer: true,
                                    borderOnForeground: true,
                                    margin: EdgeInsets.only(bottom: .25),
                                    elevation: 5,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Handles Button bar for Tasks and Trackables
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                              ),
                                              height: 55,
                                              width: 300,
                                              child: Text(
                                                "Subject: ${dataLoadedFlag ? rows[0][0] : ""}",
                                                style: TextStyle(fontSize: 20),
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              height: 45,
                                              child: Text(
                                                "Projected Grade: ${grade[0][0] == null ? "not available" : grade[0][0]}  ",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        flex: 3,
                                                        fit: FlexFit.tight,
                                                        child: TextButton(
                                                          child: Text(
                                                            'Tasks',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              view = TaskView(
                                                                subjectID: widget
                                                                    .subjectID,
                                                                key:
                                                                    UniqueKey(),
                                                                onPressTask: (int
                                                                        value,
                                                                    TaskValue
                                                                        taskValue) {
                                                                  loadTodo(
                                                                      value);
                                                                  setState(() {
                                                                    taskDescription =
                                                                        new SubjectDescriptionWidget(
                                                                      taskNameDisplay:
                                                                          taskValue
                                                                              .taskName,
                                                                      isComplete:
                                                                          taskValue
                                                                              .taskIsdone,
                                                                      taskDescriptionDisplay:
                                                                          taskValue
                                                                              .taskDescription,
                                                                      todoLength:
                                                                      lengthOfTodo,
                                                                    );
                                                                  });
                                                                },
                                                              );
                                                            });
                                                            // Change list to Task List
                                                          },
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        fit: FlexFit.tight,
                                                        child: TextButton(
                                                          child: new Text(
                                                              'Outputs',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      20)),
                                                          onPressed: () {
                                                            setState(() {
                                                              view =
                                                                  TrackableView(
                                                                subjectID: widget
                                                                    .subjectID,
                                                                key:
                                                                    UniqueKey(),
                                                                onPressTrackable:
                                                                    (TrackableValue
                                                                        value) {
                                                                 setState(() {
                                                                   taskDescription =
                                                                       SubjectTrackableDescriptionWidget(
                                                                         trackableNameDisplay:
                                                                         value
                                                                             .trackableName,
                                                                         typeDisplay:
                                                                         value
                                                                             .typeName,
                                                                         score: value
                                                                             .score,
                                                                         maxScore: value
                                                                             .maxScore,
                                                                       );
                                                                 });
                                                                },
                                                              );
                                                            });
                                                            // Change List to Trackable List
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                // Handles Lists of Tasks or Trackables
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 1),
                                  child:
                                      view, // on Pressed Change this to Trackables
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          // Right Side of Task list
                          children: [
                            // Subject Information
                            Expanded(
                              // Content Here
                              child: Container(
                                  margin: EdgeInsets.only(left: 1),
                                  width: MediaQuery.of(context).size.width -
                                      500 -
                                      2 -
                                      1,
                                  height: 200,
                                  color: Theme.of(context).primaryColorLight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      taskDescription, // edit this
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                150,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 370,
                                                    childAspectRatio: 1 / 1,
                                                    crossAxisSpacing: 20,
                                                    mainAxisSpacing: 20),
                                            itemCount: todo.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)),
                                                  child: Card(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    elevation: 5,
                                                    margin: EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                    child: SizedBox(
                                                      height: 60,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            child: ToDoCard(
                                                              toDoTitle:
                                                                  todo[index]
                                                                      .todoName,
                                                            ), // this where you put values
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15,
                                                                    left: 8,
                                                                    right: 8,
                                                                    bottom: 5),
                                                          ),
                                                          Flexible(
                                                            fit: FlexFit.tight,
                                                            child: Material(
                                                              borderRadius: BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          25),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          25)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5,
                                                                        left:
                                                                            5),
                                                                child: SizedBox(
                                                                  child:
                                                                      ListView(
                                                                    shrinkWrap:
                                                                        true,
                                                                    children: [
                                                                      Text(
                                                                        "${todo[index].todoDescription}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.black),
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
                                            },
                                          ),
                                        ),
                                      )

                                      // To do / Trackable Container
                                    ],
                                  )),
                            ),
                            // CONTENT HERE
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
