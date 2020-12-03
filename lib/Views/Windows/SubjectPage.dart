import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';

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
              height: MediaQuery.of(context).size.height - 25,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Subject Here
                  Container(
                    width: 200,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                            width: 200,
                            margin: EdgeInsets.zero,
                            height: 150,
                            child: Card(
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              color: Color(0xffDDDDDD),
                              child: Center(
                                  child: Text("Grading Period Goes Here")),
                            )),
                        Container(
                          width: 200,
                          child: FlatButton(child: Text("WEEEEEE"),onPressed: (){},),

                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width - 400 - 2,
                        height: 150,
                        color: Colors.green,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 20,
                                  ),
                                  child: Text(
                                    "Subject Name:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                  ),
                                  child: Text(
                                    "Schedule:",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                  ),
                                  child: Text(
                                    "Total Task/s:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 25,
                                  ),
                                  child: Text(
                                    "Some Random Subject name and code who knows",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 15,
                                  ),
                                  child: Text(
                                    "12:00 PM - 03:00 PM",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 15,
                                  ),
                                  child: Text(
                                    "0/20",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ), // Values of texts
                          ],
                        ),
                      ),
                      Expanded(
                        // Content Here
                        child: Container(
                          margin: EdgeInsets.zero,
                          width: MediaQuery.of(context).size.width - 400 - 2,
                          height: 200,
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Card(
                                    margin: EdgeInsets.zero,
                                    child: AppBar(),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ) // CONTENT HERE
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
