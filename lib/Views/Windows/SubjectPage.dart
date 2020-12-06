import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';
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
                          height: 50,
                          child: FlatButton(
                            child: Text("WEEEEEE"),
                            onPressed: () {},
                          ),
                        ), // Placeholder button, gonna change it later to smaller widgets
                        Container(
                          width: 200,
                          height: 50,
                          child: FlatButton(
                            child: Text("WOOOOO"),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          child: FlatButton(
                            child: Text("WEEEEEE"),
                            onPressed: () {},
                          ),
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
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                  "Tasks",
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
                                  ),
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
                                                  "Activities",
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
                                  ),
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
                                          height: 70,
                                          child: Column(
                                            children: [
                                              Padding(
                                                child: Text(
                                                  "Assignments",
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
                                  ),

                                ],
                              ),
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
