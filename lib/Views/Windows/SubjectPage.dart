import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Views/Windows/SubjectDescriptionWidget.dart';
import 'package:personalacademictracker/Widgets/ScoreCard.dart';
import 'package:personalacademictracker/Widgets/SubjectCard.dart';
import 'package:personalacademictracker/Widgets/SubjectPage/TaskView.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

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
  bool dataLoadedFlag= false;
  DatabaseHelper dbHelper = new DatabaseHelper();
  List<sql.Row> rows;
  sql.Results result;
  final List<Map> myProducts =
      List.generate(5, (index) => {"id": index, "Testing some cool Flutter UI widgets IDK WHAT AM I DOING LMAOOOOOOOOOOOOOOO": "Product $index"})
          .toList();

  void initState()
  {
    loadData();
    super.initState();
  }

  void loadData() async
  {
    result = await dbHelper.connectDB(Query.getSpecificSubjectOfUser(Query.userName,widget.subjectID));
    rows = result.toList();
    dataLoadedFlag = true;
    setState(() {

    });

  }
  // Crate left side Nav menu, right side le task
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return !dataLoadedFlag ?  Container(color: Color(0xff439889)):FractionallySizedBox(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Handles Button bar for Tasks and Trackables
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        height: 55,
                                        width: 300,
                                        child: Text(
                                          "Subject: ${dataLoadedFlag ? rows[0][0]:"" }",
                                          style: TextStyle(fontSize: 20),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        height: 45,
                                        child: Text(
                                          "Projected Grade: ${rows[0][2] == null ? "not available":rows[0][2]}  ",
                                          style: TextStyle(fontSize: 20),
                                        ),
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: TaskView(subjectID: widget.subjectID,key: UniqueKey(),),
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
                            width:
                                MediaQuery.of(context).size.width - 500 - 2 - 1,
                            height: 200,
                            color: Theme.of(context).primaryColorLight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SubjectDescriptionWidget(),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height - 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(padding: EdgeInsets.all(8.0),
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 370,
                                              childAspectRatio: 1/1,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                      itemCount: myProducts.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Card(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              elevation: 5,
                                              margin: EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: SizedBox(
                                                height: 60,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      child: ToDoCard(),
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
                                                                      .only(
                                                                  top: 5,
                                                                  left: 5),
                                                          child: SizedBox(
                                                            child: ListView(
                                                              shrinkWrap: true,
                                                              children: [
                                                                Text(
                                                                  "${myProducts[index]}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .black),
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
