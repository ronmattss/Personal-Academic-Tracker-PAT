import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Widgets/ScoreCard.dart';
import 'package:personalacademictracker/Widgets/SubjectCard.dart';
import 'package:personalacademictracker/Widgets/SubjectPage/TaskView.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

// Thie Page is the expanded version of the Lists
class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubjectPageState();
}

// What this page do
// show Tasks and To Do
// Track deliverables
class _SubjectPageState extends State<SubjectPage> {
  // Crate left side Nav menu, right side le task
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return FractionallySizedBox(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Handles Button bar for Tasks and Trackables
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(padding: EdgeInsets.only(left:  10,),
                                        height:55,
                                        width: 300,
                                        child: Text("Subject: Programming 1",style: TextStyle(fontSize: 20),maxLines: 2,),
                                      ),Container(padding: EdgeInsets.only(left:  10),
                                        height:45,
                                        child: Text("Projected Grade: 1.75 ",style: TextStyle(fontSize: 20),),
                                      ),

                                      SizedBox(
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  flex: 3,
                                                  fit: FlexFit.tight,
                                                  child: TextButton(
                                                    child: Text(
                                                      'Tasks',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () => {},
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 3,
                                                  fit: FlexFit.tight,
                                                  child: TextButton(
                                                    child: new Text(
                                                        'Trackables',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20)),
                                                    onPressed: () => {},
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
                          child: TaskView(),
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
                            width:
                                MediaQuery.of(context).size.width - 500 - 2 - 1,
                            height: 200,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    color: Theme.of(context).primaryColor,
                                    height: 150,
                                    padding: EdgeInsets.only(left: 20, top: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Texts For Descriptions
                                            Row(
                                              children: [
                                                Text(
                                                  "Task:",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  " Clean  Database",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Todos:",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  " 10/50",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Status: ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  "Complete",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 200,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                // Texts
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 500,
                                                      child: Text(
                                                        "Task Description: Some Description Here",
                                                        maxLines: 4,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    )),
                                // To do / Trackable Container
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
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(25),
                                                    bottomLeft:
                                                        Radius.circular(25)),
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
                                ),
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
