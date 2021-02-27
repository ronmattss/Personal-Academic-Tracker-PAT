import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Views/Windows/SubjectPage.dart';
import 'package:personalacademictracker/Widgets/CustomDropdown.dart';
import 'package:personalacademictracker/Widgets/SubjectButtonBuilder.dart';
import 'package:personalacademictracker/Widgets/Windows/TitlebarButtons.dart';

import 'DashboardButton.dart';

//TODO: Add Subject,Task,Todo,Trackers,statistics,Subject page,other Dashboard Stuff, Profile, Statistics
//TODO: Resizable Widgets based on Screen size
class DashboardWidget extends StatefulWidget {
  final String userName;
  final String password;

  const DashboardWidget({Key key, this.userName, this.password}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _DashboardWidget();
}

class _DashboardWidget extends State<DashboardWidget> {
  DatabaseHelper dbLoader = new DatabaseHelper();
  sql.Results resultsSubjects;
  sql.Results resultsPeriod;
  List<sql.Row> rowsSubject;
  List<sql.Row> rowsPeriod;
  List<String> periods = [];
  List<String> subjects = [];
  Widget createSubjectDropDown = CustomDropDown();
  Widget createPeriodListDropDown = CustomDropDown();
  sql.Results results;
  List<sql.Row> rows;
  var expanded = true;
  double leftWidth = 200;
  double leftWidthCollapsed = 50;
  double drawerWidth = 200;
  String displayUser = "Steve Jobs";
  Widget rightSideWidget;
  Widget buttons;

  void setWidth() {
    if (expanded) {
      drawerWidth = leftWidthCollapsed;
    } else {
      drawerWidth = leftWidth;
    }
    expanded = !expanded;
  }

  @override
  void initState() {
    // Load database entries
    print(displayUser);
    loadDatabase();
    loadSubjectLists();
    loadPeriodList();
    rightSideWidget = Container(
      color: Color(0xff439889),
    );
    super.initState();
  }


  void loadSubjectLists() async {
    results = await dbLoader.connectDB(Query.getSubjects());
    rows = results.toList();

    Future<List<sql.Row>>.delayed(
      Duration(milliseconds: 500),
          () {
        return results.toList();
      },
    ).then((value) {
      rows = value;
      rows.forEach((element) {
        var s = element[1];
        subjects.add(s);
      });
      setState(() {
        print('Data Period Loaded');
        createSubjectDropDown = CustomDropDown(
          selections: subjects,
        );
      });
    });
  }

  void loadPeriodList() async {
    resultsPeriod = await dbLoader.connectDB(Query.getPeriod());
    rowsPeriod = resultsPeriod.toList();

    Future<List<sql.Row>>.delayed(
      Duration(milliseconds: 500),
          () {
        return resultsPeriod.toList();
      },
    ).then((value) {
      rowsPeriod = value;
      rowsPeriod.forEach((element) {
        var s = element[1];
        periods.add(s);
      });
      setState(() {
        print('Data Loaded');
        createPeriodListDropDown = CustomDropDown(
          selections: periods,
        );
      });
    });
  }
  void loadDatabase() async {
    resultsSubjects = await dbLoader
        .connectDB(Query.getUserPass(widget.userName, widget.password));

    Future<List<sql.Row>>.delayed(Duration(seconds: 1), () {
      return resultsSubjects.toList();
    }).then((value) {
      rowsSubject = value.toList();
      print(rowsSubject[0][0]);
      setState(() {
        if (rowsSubject.isNotEmpty) {
          displayUser =
          "${rowsSubject[0][2]}, ${rowsSubject[0][3]} ${rowsSubject[0][4].toString()[0]}."; // display Name
          Query.userName = rowsSubject[0][0]; // temporary
        } else {
          displayUser = "no data";
        }
        setState(() {
          print("loaded");
        });
      });
    });


    //displayUser = rows[0][0];
  }

  @override
  void didUpdateWidget(covariant DashboardWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("updated");
  }

  void changeRightSideWidget(Widget newWidget) {
    setState(() {
      rightSideWidget = newWidget;
    });
  }

  Widget _dashboard(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(children: [
        Expanded(
            child: Container(
                color: Color(0xffDDDDDD),
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.white,
                            width: drawerWidth,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                /* WindowTitleBarBox(*/ /*
                                    child: MoveWindow(
                                        child: Container(
                                  color: Theme.of(context).primaryColor,
                                )))*/ /*,*/
                                Expanded(
                                  child: Card(
                                    shape:
                                        Border.fromBorderSide(BorderSide.none),
                                    margin: EdgeInsets.zero,
                                    color: Theme.of(context).primaryColorLight,
                                    child: ListTileTheme(
                                      child: ListView(
                                        padding: EdgeInsets.all(0),
                                        children: [
                                          // profile Box
                                          DrawerHeader(
                                            child: Column(children: [
                                              CircleAvatar(
                                                radius: 40,
                                                child: Icon(Icons.person),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  displayUser,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ]),
                                            margin: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          // Here goes Subject Buttons
                                          Card(
                                            margin: EdgeInsets.zero,
                                            color:
                                                Theme.of(context).primaryColor,
                                            elevation: 0,
                                            child: SubjectListBuilder(
                                              taskID: (int value) {

                                                setState(() {
                                                  rightSideWidget = new SubjectPage(
                                                    subjectID: value,key: UniqueKey(),
                                                  );
                                                  print(
                                                      "will this work?: $value"); // pass Subject ID here
                                                  // pass new Widget here
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ]),
                    Column(children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width:
                            MediaQuery.of(context).size.width - drawerWidth - 2,
                        child: Column(
                          children: [
                            Expanded(
                              child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: rightSideWidget),
                            ), //,
                          ],
                        ),
                      ),
                    ]),
                  ],
                )))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: _dashboard(context), floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          mini: false,
          tooltip: 'Add Output',
          child: Icon(Icons.book),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Add Output"),
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
                              decoration: InputDecoration(
                                hintText: 'Add Output',
                                labelText: 'Output Name',
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
                              decoration: InputDecoration(
                                hintText: 'Add Output Description',
                                labelText: ' Output Description',
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
                                    onPressed: () {},
                                  )), // Add Database Entry and Pop
                              Flexible(
                                  flex: 2,
                                  child: ElevatedButton(
                                    child: Text("Cancel"),
                                    onPressed: () {},
                                  )) // pop cancel
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        Container(
          height: 3,
        ),
        FloatingActionButton(
          mini: false,
          tooltip: 'Add todo',
          child: Icon(Icons.check),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Add Todo"),
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
                                    onPressed: () {},
                                  )), // Add Database Entry and Pop
                              Flexible(
                                  flex: 2,
                                  child: ElevatedButton(
                                    child: Text("Cancel"),
                                    onPressed: () {},
                                  )) // pop cancel
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        Container(
          height: 3,
        ),
        FloatingActionButton(
          mini: false,
          tooltip: 'Add Task',
          child: Icon(Icons.lightbulb),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Add Task"),
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
                              decoration: InputDecoration(
                                hintText: 'Add Task',
                                labelText: 'Task Name',
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
                              decoration: InputDecoration(
                                hintText: 'Add Task Description',
                                labelText: ' Task Description',
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
                                    onPressed: () {},
                                  )), // Add Database Entry and Pop
                              Flexible(
                                  flex: 2,
                                  child: ElevatedButton(
                                    child: Text("Cancel"),
                                    onPressed: () {},
                                  )) // pop cancel
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        Container(
          height: 3,
        ),
        FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Add Subject"),
                    content: Container(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          createSubjectDropDown,
                          createPeriodListDropDown,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: ElevatedButton(
                                    child: Text("Add"),
                                    onPressed: () {},
                                  )), // Add Database Entry and Pop
                              Flexible(
                                  flex: 2,
                                  child: ElevatedButton(
                                    child: Text("Cancel"),
                                    onPressed: () {},
                                  )) // pop cancel
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          tooltip: 'Add Subject',
          child: Icon(Icons.subject),
        ),
      ],
    ),);
  }
}
