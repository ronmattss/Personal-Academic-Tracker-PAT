import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Views/Windows/SubjectPage.dart';
import 'package:personalacademictracker/Widgets/SubjectButtonBuilder.dart';
import 'package:personalacademictracker/Widgets/Windows/TitlebarButtons.dart';

import 'DashboardButton.dart';

//TODO: Add Subject,Task,Todo,Trackers,statistics,Subject page,other Dashboard Stuff, Profile, Statistics
//TODO: Resizable Widgets based on Screen size
class DashboardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardWidget();
}

class _DashboardWidget extends State<DashboardWidget> {
  DatabaseHelper dbLoader = new DatabaseHelper();
  sql.Results results;
  List<sql.Row> rows;
  var expanded = true;
  double leftWidth = 200;
  double leftWidthCollapsed = 50;
  double drawerWidth = 200;
  String displayUser = "Steve Jobs";
  Widget rightSideWidget;

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
    rightSideWidget = Container(
      color: Color(0xff439889),
    );
    super.initState();
  }

  void loadDatabase() async {
    results = await dbLoader
        .connectDB(Query.getUserPass(Query.userName, Query.password));
    rows = results.toList();
    if (rows.isNotEmpty) {
      displayUser =
          "${rows[0][2]}, ${rows[0][3]} ${rows[0][4].toString()[0]}."; // display Name
      Query.userName = rows[0][0]; // temporary
    } else {
      displayUser = "no data";
    }
    setState(() {
      print("loaded");
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
    return _dashboard(context);
  }
}
