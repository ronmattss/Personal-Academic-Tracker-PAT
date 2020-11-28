import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Preferences/CustomTheme.dart';
import 'package:personalacademictracker/Widgets/CalendarTestWidget.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

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
  Widget _customBox(BuildContext context, double width, double height,
      [Color color]) {
    return Container(
      width: width,
      height: height,
      color: color != null ? color : Colors.transparent,
    );
  }

  void setWidth() {
    if (expanded) {
      drawerWidth = leftWidthCollapsed;
    } else {
      drawerWidth = leftWidth;
    }
    expanded = !expanded;
  }

  Widget _dashboard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(children: [
        Expanded(
            child: Container(
                color: Color(0xffDDDDDD),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.white70,
                            width: drawerWidth,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color: Theme.of(context).primaryColor,
                                    child: ListTileTheme(
                                      child: ListView(
                                        padding: EdgeInsets.all(0),
                                        children: [
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
                                                  'Steve Jobs',
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
                                          Card(
                                            margin: EdgeInsets.zero,
                                            color:
                                                Theme.of(context).primaryColor,
                                            elevation: 0,
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: [
                                                DashboardButton('Dashboard'),
                                                DashboardButton('Calendar'), //Calendar
                                                DashboardButton('Grades'), //Grades
                                                DashboardButton('Schedule'), //Schedule
                                                DashboardButton('Subjects'), //Subjects
                                                DashboardButton('Tasks'),
                                              ],
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
                          /*_customBox(
                              context,
                              250,
                              MediaQuery.of(context).size.height - 56,
                              Color(0xffDDDDDD))*/
                        ],
                      )
                    ]),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - drawerWidth,
                      child: FractionallySizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 70, top: 125),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Upcoming",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                  fit: FlexFit.tight,
                                                  child: Material(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          25),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      25)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: SizedBox(
                                                          child: CarouselSlider
                                                              .builder(
                                                            options:
                                                                CarouselOptions(
                                                              initialPage: 0,
                                                              pageSnapping:
                                                                  true,
                                                              enlargeCenterPage:
                                                                  false,
                                                              viewportFraction:
                                                                  1,
                                                              autoPlay: true,
                                                              autoPlayInterval:
                                                                  Duration(
                                                                      seconds:
                                                                          5),
                                                              autoPlayAnimationDuration:
                                                                  Duration(
                                                                      seconds:
                                                                          1),
                                                              pauseAutoPlayOnTouch:
                                                                  true,
                                                            ),
                                                            itemCount: 3,
                                                            itemBuilder: (BuildContext
                                                                        context,
                                                                    int
                                                                        itemIndex) =>
                                                                Column(
                                                                    children: [
                                                                  SizedBox(
                                                                    height: 50,
                                                                    child:
                                                                        DrawerHeader(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 10),
                                                                        child:
                                                                            Text(
                                                                          "TOMORROW",
                                                                          style:
                                                                              TextStyle(fontSize: 25),
                                                                        ),
                                                                      ),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 0),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    //width: 300,
                                                                    child: ListView(
                                                                        shrinkWrap: true,
                                                                        padding: EdgeInsets.all(0),
                                                                        children: ListTile.divideTiles(context: context, tiles: [
                                                                          ListTile(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                print("Title");
                                                                                setWidth();
                                                                              });
                                                                            },
                                                                            minVerticalPadding:
                                                                                2,
                                                                            subtitle:
                                                                                Text("Deadline: 3:00 PM"),
                                                                            title:
                                                                                Text(
                                                                              "Sprite Renders",
                                                                            ),
                                                                            trailing:
                                                                                Icon(Icons.pending_actions_outlined),
                                                                          ),
                                                                          ListTile(
                                                                            subtitle:
                                                                                Text("Deadline: 3:00 PM"),
                                                                            title:
                                                                                Text(
                                                                              "Sprite Renders",
                                                                            ),
                                                                            trailing:
                                                                                Icon(Icons.pending_actions_outlined),
                                                                          ),
                                                                          ListTile(
                                                                            subtitle:
                                                                                Text("Deadline: 3:00 PM"),
                                                                            title:
                                                                                Text(
                                                                              "Sprite Renders",
                                                                            ),
                                                                            trailing:
                                                                                Icon(Icons.pending_actions_outlined),
                                                                          ),
                                                                          ListTile(
                                                                            subtitle:
                                                                                Text("Deadline: 3:00 PM"),
                                                                            title:
                                                                                Text(
                                                                              "Sprite Renders",
                                                                            ),
                                                                            trailing:
                                                                                Icon(Icons.pending_actions_outlined),
                                                                          ),
                                                                        ]).toList()),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                      )))
                                            ],
                                          ),
                                        ),
                                      ),
                                      width: 300,
                                      height: 300,
                                    ),
                                  ), //Deadline Card
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Subjects",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: SizedBox(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Research"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("10/20"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Computer Organization"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("2/5"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Application Development"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("3/10"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Principles Of Programming Language"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("3/10"),
                                                            ),
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
                                  ), //Subjects Card
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Completed",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: SizedBox(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          TaskCard(
                                                              "Make Calculator",
                                                              "Scical goes null",
                                                              "AppDev"),
                                                          TaskCard(
                                                              "Review Regular Expressions",
                                                              "Regex goes  \d^[0-9]",
                                                              "Automata"),
                                                          TaskCard(
                                                              "Sap-1 Review",
                                                              "binary goes 01000101",
                                                              "Comp Org"),
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
                                  ), //Completed Card
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Schedule",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: SizedBox(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Research"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("10/20"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Computer Organization"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("2/5"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Application Development"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("3/10"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Principles Of Programming Language"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("3/10"),
                                                            ),
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
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Priority",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: SizedBox(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          PriorityTaskCard(
                                                              "Research Titles",
                                                              "Fundamentals of Research",
                                                              Priority.High),
                                                          PriorityTaskCard(
                                                              "C# 9 Review",
                                                              "Dot Net",
                                                              Priority.High),
                                                          PriorityTaskCard(
                                                              "Read about Augmented Reality",
                                                              "Game Development",
                                                              Priority.High),
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
                                  ), //Priority
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Pinned",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: SizedBox(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          PinnedTaskCard(
                                                              "Debug",
                                                              "Make Sure there is no bugs"),
                                                          PinnedTaskCard(
                                                              "Inspect",
                                                              "inspect UI"),
                                                          PinnedTaskCard("Push",
                                                              "Push to Github"),
                                                          PinnedTaskCard(
                                                              "Commit",
                                                              "Commit to master branch")
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
                                  ), //Pinned
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Grades",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: SizedBox(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Research"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("2.5"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Computer Organization"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("2.5"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Application Development"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("2.0"),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.book),
                                                            title: Text(
                                                                "Principles Of Programming Language"),
                                                            dense: true,
                                                            trailing: Chip(
                                                              label:
                                                                  Text("2.25"),
                                                            ),
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
                                  ), //Schedule
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        elevation: 5,
                                        margin: EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: SizedBox(
                                          height: 60,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Calendar",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 15,
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 5),
                                              ),
                                              Flexible(
                                                fit: FlexFit.tight,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  25),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  25)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: Flexible(
                                                      child: ListView(
                                                        shrinkWrap: true,
                                                        children: [
                                                          CalendarTestWidget()
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
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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
