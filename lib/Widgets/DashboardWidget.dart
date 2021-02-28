import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:intl/intl.dart';
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Views/Windows/LoginPage.dart';
import 'package:personalacademictracker/Views/Windows/SubjectPage.dart';
import 'package:personalacademictracker/Widgets/CustomDropdown.dart';
import 'package:personalacademictracker/Widgets/SubjectButtonBuilder.dart';
import 'package:personalacademictracker/Widgets/Windows/TitlebarButtons.dart';
import 'package:personalacademictracker/main.dart';

import 'DashboardButton.dart';

//TODO: Add Subject,Task,Todo,Trackers,statistics,Subject page,other Dashboard Stuff, Profile, Statistics
//TODO: Resizable Widgets based on Screen size
class DashboardWidget extends StatefulWidget {
  final String userName;
  final String password;

  const DashboardWidget({Key key, this.userName, this.password})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _DashboardWidget();
}

class _DashboardWidget extends State<DashboardWidget> {
  DatabaseHelper dbLoader = new DatabaseHelper();
  sql.Results resultsSubjects;
  sql.Results resultsPeriod;
  List<sql.Row> rowsSubject;
  List<sql.Row> rowsPeriod;
  List<sql.Row> rowsType;
  sql.Results resultstype;
  List<String> types = [];
  List<String> periods = [];
  List<String> subjects = [];
  final TextEditingController _taskNameController = new TextEditingController();
  final TextEditingController _taskDescriptionController =
      new TextEditingController();
  final TextEditingController _todoNameController = new TextEditingController();
  final TextEditingController _todoDescriptionController =
      new TextEditingController();
  final TextEditingController _deadLine = new TextEditingController();
  final TextEditingController _outputNameController =
      new TextEditingController();
  final TextEditingController _outputScoreController =
      new TextEditingController();
  final TextEditingController _outputMaxScoreController =
      new TextEditingController();
  final TextEditingController _newSubjectController =
      new TextEditingController();
  final TextEditingController _newPeriodController =
      new TextEditingController();
  String outputName = "";
  String score = "0";
  String maxScore = "0";
  String birthDateString = DateTime.now().toString();
  String taskName = "";
  String taskDescription = "";
  String todoName = "";
  String todoDescription = "";
  String newPeriod = "";
  String newSubject = "";
  int subjectID;
  int periodID;
  int typeID;
  Widget createSubjectDropDown = CustomDropDown();
  Widget createPeriodListDropDown = CustomDropDown();
  Widget createTypeListDropDown = CustomDropDown();

  Widget subjectButtons = SubjectListBuilder();

  sql.Results results;
  List<sql.Row> rows;
  var expanded = true;
  double leftWidth = 200;
  double leftWidthCollapsed = 50;
  double drawerWidth = 200;
  String displayUser = "Steve Jobs";
  Widget rightSideWidget;
  Widget buttons;

  DateTime birthDate = DateTime.now();
  DateFormat format =
      DateFormat(DateFormat.YEAR_MONTH_DAY); // Format upon Clicking

  void setWidth() {
    if (expanded) {
      drawerWidth = leftWidthCollapsed;
    } else {
      drawerWidth = leftWidth;
    }
    expanded = !expanded;
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: birthDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((value) {
      setState(() {
        _deadLine.text = format.format(value);
        // format = DateFormat('yyyyMMdd');
        //  birthDate = DateTime.parse(format.format(value));
      });
      return;
    });
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
      });
  }

  @override
  void initState() {
    _taskNameController.text = taskName;
    _taskDescriptionController.text = taskDescription;
    // Load database entries
    print(displayUser);
    loadSubjectLists();
    loadDatabase();
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
        print(s);
        subjects.add(s);
      });
      setState(() {
        print('Data Period Loaded');
        createSubjectDropDown = CustomDropDown(onDefault: (String value) {
          var temp = subjects.firstWhere((element) => value == element);
          subjectID = subjects.indexOf(temp) + 1;
          print(subjectID);
        },
          selections: subjects,
          onSelect: (String value) {
            setState(() {
              var temp = subjects.firstWhere((element) => value == element);
              subjectID = subjects.indexOf(temp) + 1;
              print(subjectID);
            });
          },
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
        print(s);
        periods.add(s);
      });
      setState(() {
        print('Data Loaded');
        loadTypeList();
        createPeriodListDropDown = CustomDropDown(onDefault: (String value){
          var temp = periods.firstWhere((element) => value == element);
          periodID = periods.indexOf(temp) + 1;

          print(periodID);
        },
          selections: periods,
          onSelect: (String value) {
            setState(() {
              var temp = periods.firstWhere((element) => value == element);
              periodID = periods.indexOf(temp) + 1;

              print(periodID);
            });
          },
        );
      });
    });
  }

  void loadTypeList() async {
    resultstype = await dbLoader.connectDB(Query.getTypes());
    rowsType = resultstype.toList();
    Future<List<sql.Row>>.delayed(
      Duration(milliseconds: 500),
      () {
        return rowsType.toList();
      },
    ).then((value) {
      rowsType = value;
      rowsType.forEach((element) {
        var s = element[1];
        print(s);
        types.add(s);
      });
      setState(() {
        print('Data Loaded');
        createTypeListDropDown = CustomDropDown(
          onDefault: (String value) {
            var temp = types.firstWhere((element) => value == element);
            typeID = types.indexOf(temp) + 1;
            print(typeID);
          },
          selections: types,
          onSelect: (String value) {
            setState(() {
              var temp = types.firstWhere((element) => value == element);
              typeID = types.indexOf(temp) + 1;
              print(typeID);
            });
          },
        );
      });
    });
  }

  void sendData() async {
    format = DateFormat('yyyy-MM-dd HH-mm-ss');
    String dateString = format.format(birthDate);
    print("$dateString");
    print(taskName);
    print(taskDescription);
    results = await dbLoader.connectDB(Query.insertSubjectTaskToTable(
        userID: Query.userName,
        subjectID: Query.currentSubject,
        taskNameTest: taskName,
        taskDescription: taskDescription,
        deadline: dateString,
        isFinished: false));

    setState(() {
      if (results.affectedRows > 0)
        Navigator.of(context, rootNavigator: true).pop();
    });
  }

  void addTodo() async {
    format = DateFormat('yyyy-MM-dd HH-mm-ss');
    String dateString = format.format(birthDate);
    print("$dateString");
    print(taskName);
    print(taskDescription);
    results = await dbLoader.connectDB(Query.insertTaskTodo(
        Query.currentTask, todoName, todoDescription, false));
    setState(() {
      if (results.affectedRows > 0)
        Navigator.of(context, rootNavigator: true).pop();
    });
  }

  void addOutput() async {
    format = DateFormat('yyyy-MM-dd');
    String dateString = format.format(birthDate);
    print("$dateString");
    print(taskName);
    print(taskDescription);
    results = await dbLoader.connectDB(Query.insertSubjectTrackable(
        trackableName: outputName,
        score: double.parse(score),
        maxScore: double.parse(maxScore),
        date: dateString,
        typeID: typeID,
        subjectID: Query.currentSubject,
        userID: Query.userName));
    sql.Results r =  await dbLoader.connectDB(Query.updateProjectedGrade(
        user: Query.userName, subID: Query.currentSubject, periodID: Query.currentPeriod));
    print("Update Please: ${r.affectedRows}");
    setState(() {
      if (results.affectedRows > 0)
        Navigator.of(context, rootNavigator: true).pop();
    });
  }

  void addSubject() async {
    print(Query.userName);
    print(subjectID);
    print(periodID);

    results = await dbLoader
        .connectDB(Query.insertSubject(Query.userName, subjectID, periodID));
    sql.Results r = await dbLoader.connectDB(Query.updateProjectedGrade(
        user: Query.userName, subID: subjectID, periodID: periodID));
    print(r.affectedRows);
    setState(() {
      if (results.affectedRows > 0)
        Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp(
                    widget: DashboardWidget(
                      userName: widget.userName,
                      password: widget.password,
                      key: UniqueKey(),
                    ),
                  )));
    });
  }

  void addNewSubject() async {
    results = await dbLoader.connectDB(Query.insertNewSubject(newSubject));
    setState(() {
      if (results.affectedRows > 0)
        Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp(
                    widget: DashboardWidget(
                      userName: widget.userName,
                      password: widget.password,
                      key: UniqueKey(),
                    ),
                  )));
    });
  }

  void addNewPeriod() async {
    results = await dbLoader.connectDB(Query.insertNewPeriod(newPeriod));
    setState(() {
      if (results.affectedRows > 0)
        Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp(
                    widget: DashboardWidget(
                      userName: widget.userName,
                      password: widget.password,
                      key: UniqueKey(),
                    ),
                  )));
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
    return SizedBox(
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
                                                child: IconButton(icon: Icon(Icons.person),onPressed: (){
                                                  setState(() {
                                                    Navigator.pushReplacement(
                                                        context, MaterialPageRoute(builder: (context) => MyApp(widget: LoginWidget(),)));
                                                  });
                                                },),
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
                                                  Query.currentSubject = value;
                                                  rightSideWidget =
                                                      new SubjectPage(
                                                    subjectID: value,
                                                    key: UniqueKey(),
                                                  );
                                                  print(
                                                      "will this work?: $value"); // pass Subject ID here
                                                  // pass new Widget here
                                                });
                                              },
                                              taskName: (String value) {
                                                setState(() {
                                                  Query.currentSubjectName =
                                                      value;
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
    return Scaffold(
      body: _dashboard(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: false,
            tooltip: 'Add new Period',
            child: Icon(Icons.score),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Period"),
                      content: Container(
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              child: TextField(
                                controller: _newPeriodController,
                                onChanged: (String value) => newSubject = value,
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  hintText: 'Add Period',
                                  labelText: 'Period Name',
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
                                        addNewPeriod();
                                      },
                                    )), // Add Database Entry and Pop
                                Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
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
            tooltip: 'Add new Subject',
            child: Icon(Icons.book_online_sharp),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Subject"),
                      content: Container(
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              child: TextField(
                                controller: _newSubjectController,
                                onChanged: (String value) => newSubject = value,
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  hintText: 'Add Subject',
                                  labelText: 'Subject Name',
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
                                        addNewSubject();
                                      },
                                    )), // Add Database Entry and Pop
                                Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
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
            tooltip: 'Add Output',
            child: Icon(Icons.book),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Output to ${Query.currentSubjectName}"),
                      content: Container(
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              child: TextField(
                                controller: _outputNameController,
                                onChanged: (String value) => outputName = value,
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
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]+')),
                                ],
                                controller: _outputScoreController,
                                onChanged: (String value) => score = value,
                                decoration: InputDecoration(
                                  hintText: 'Add Score',
                                  labelText: 'Score',
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
                                controller: _outputMaxScoreController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]+')),
                                ],
                                onChanged: (String value) => maxScore = value,
                                decoration: InputDecoration(
                                  hintText: 'Add Max Score',
                                  labelText: 'Max Score',
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
                                controller: _deadLine,
                                onTap: () => _selectDate(context),
                                decoration: InputDecoration(
                                  hintText: '',
                                  labelText: ' Date',
                                ),
                              ),
                            ),
                            createTypeListDropDown,
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      child: Text("Add"),
                                      onPressed: () {
                                        addOutput();
                                      },
                                    )), // Add Database Entry and Pop
                                Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
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
            tooltip:
                'Add todo in ${Query.currentSubjectName} Task: ${Query.currentTask}',
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
                                onChanged: (String value) =>
                                    todoDescription = value,
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
                                          addTodo();
                                        });
                                      },
                                    )), // Add Database Entry and Pop
                                Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        });
                                      },
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
            tooltip: 'Add Task to ${Query.currentSubjectName}',
            child: Icon(Icons.lightbulb),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Task in  ${Query.currentSubjectName}"),
                      content: Container(
                        height: 400,
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
                                controller: _taskNameController,
                                onChanged: (String value) => taskName = value,
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
                                controller: _taskDescriptionController,
                                onChanged: (String value) =>
                                    taskDescription = value,
                                decoration: InputDecoration(
                                  hintText: 'Add Task Description',
                                  labelText: ' Task Description',
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
                                controller: _deadLine,
                                onTap: () => _selectDate(context),
                                decoration: InputDecoration(
                                  hintText: '',
                                  labelText: 'Task Deadline',
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
                                          sendData();
                                        });
                                      },
                                    )), // Add Database Entry and Pop
                                Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
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
                                      onPressed: () {
                                        addSubject();
                                      },
                                    )), // Add Database Entry and Pop
                                Flexible(
                                    flex: 2,
                                    child: ElevatedButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
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
      ),
    );
  }
}
