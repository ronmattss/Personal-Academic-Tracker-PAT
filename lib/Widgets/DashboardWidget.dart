import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  var expanded = true;
  double leftWidth = 200;
  double leftWidthCollapsed = 50;
  double drawerWidth = 200;
  String thisShouldChange = "Steve Jobs";
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
    print(thisShouldChange);
    rightSideWidget = SubjectPage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DashboardWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
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
                color: Color(0xffDDDDDD),padding: EdgeInsets.zero,margin: EdgeInsets.zero,
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
                               /* WindowTitleBarBox(*//*
                                    child: MoveWindow(
                                        child: Container(
                                  color: Theme.of(context).primaryColor,
                                )))*//*,*/
                                Expanded(
                                  child: Card(
                                    shape:
                                        Border.fromBorderSide(BorderSide.none),
                                    margin: EdgeInsets.zero,
                                    color: Theme.of(context).primaryColor,
                                    child: ListTileTheme(
                                      child: ListView(
                                        padding: EdgeInsets.all(0),
                                        children: [
                                          // profile Box XD
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
                                                  thisShouldChange,
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
                                            child:SubjectListBuilder(),
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
                           /* WindowTitleBarBox(
                                child: Row(
                              children: [
                                Expanded(
                                  child: MoveWindow(),
                                ),
                                TitlebarButtons(),
                              ],
                            )),*/
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
