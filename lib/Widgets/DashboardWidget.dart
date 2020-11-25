import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardWidget();
}

class _DashboardWidget extends State<DashboardWidget> {
  Widget _customBox(BuildContext context, double width, double height,
      [Color color]) {
    return Container(
      width: width,
      height: height,
      color: color != null ? color : Colors.transparent,
    );
  }

  Widget _dashboard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(children: [
        Expanded(
            child: Container(
                color: Colors.blueGrey,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(children: [
                      Row(
                        children: [
                          _customBox(
                              context,
                              250,
                              MediaQuery.of(context).size.height - 56,
                              Colors.redAccent)
                        ],
                      )
                    ]),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 250,
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
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              child: DrawerHeader(
                                                child: Text(
                                                  "TOMORROW",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                                padding: EdgeInsets.all(0),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      "Assignment 2 in Automata",
                                                    ),
                                                    trailing: Icon(Icons
                                                        .pending_actions_outlined),
                                                    subtitle:
                                                        Text("Deadline: 12:00 PM"),
                                                  ),
                                                  ListTile(
                                                    subtitle: Text("Deadline: 3:00 PM"),
                                                    title: Text(
                                                      "Sprite Renders",
                                                    ),
                                                    trailing: Icon(Icons
                                                        .pending_actions_outlined),
                                                  ),
                                                  ListTile(
                                                    subtitle: Text("Deadline: 1:00 PM"),
                                                    title: Text(
                                                      "APOD UPDATE",
                                                    ),
                                                    trailing: Icon(Icons
                                                        .pending_actions_outlined),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
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
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Text("Some Content"),
                                      width: 600,
                                      height: 300,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10, left: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.pinkAccent,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Text("Some Content"),
                                        width: 300,
                                        height: 300,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Text("Some Content"),
                                        width: 600,
                                        height: 300,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Text("Some Content"),
                                        width: 300,
                                        height: 300,
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Text("Some Content"),
                                        width: 300,
                                        height: 300,
                                      ))
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
