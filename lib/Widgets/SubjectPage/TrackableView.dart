import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:intl/intl.dart';
import 'package:personalacademictracker/Widgets/CustomDropdown.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';
import 'package:personalacademictracker/Widgets/Windows/ToDoCard.dart';

//TaskView shows the list of tasks
// with to do list inside
class TrackableView extends StatefulWidget {
  final int subjectID;
  final Function(TrackableValue) onPressTrackable;

  const TrackableView({Key key, this.subjectID, this.onPressTrackable})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _TrackableViewState();
}

class TrackableValue {
  TrackableValue({
    this.trackableID,
    this.trackableName,
    this.typeName,
    this.score,
    this.maxScore,
    this.isExpanded = false,
  });
  int trackableID;
  String trackableName;
  String typeName;
  double score;
  double maxScore;

  bool isExpanded;
}

/*
* taskID int AI PK
taskName varchar(45)
taskDescription varchar(128)
dateCreated datetime
deadline datetime
taskIsDone tinyint
*
* */
// Data Generation

class _TrackableViewState extends State<TrackableView>
    with AutomaticKeepAliveClientMixin<TrackableView> {
  DatabaseHelper dbLoader = new DatabaseHelper();
  sql.Results results;
  List<sql.Row> rows;
  List<TrackableValue> _trackableData = [];
  bool showList = false;

  List<sql.Row> rowsType;
  sql.Results resultstype;
  List<String> types = [];
  int typeID;
  Widget createTypeListDropDown = CustomDropDown();

  void initState() {
    loadData();
    loadTypeList();
    super.initState();
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
        createTypeListDropDown = CustomDropDown(onDefault: (String value)
          {
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

  void loadData() async {
    results = await dbLoader
        .connectDB(Query.getUserTrackables(Query.userName, widget.subjectID));
    rows = results.toList();
    // print("What this: "+rows[0][0].runtimeType.toString());
    if (rows.isNotEmpty) {
      setState(() {
        showList = true;
        for (int i = 0; i < rows.length; i++) {
          TrackableValue t = new TrackableValue(
              trackableID: rows[i][0],
              trackableName: rows[i][1],
              typeName: rows[i][2],
              score: rows[i][3],
              maxScore: rows[i][4]);
          _trackableData.add(t);
        }
      });
    }
    setState(() {
      print("hello");
      print(showList);
    });
  }

  Widget _listContainer(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: _buildTaskPanel(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _listContainer(context);
  }

  Widget _buildTaskPanel(BuildContext context) {
    final TextEditingController _outputNameController =
        new TextEditingController();
    final TextEditingController _outputScoreController =
        new TextEditingController();
    final TextEditingController _outputMaxScoreController =
        new TextEditingController();
    final TextEditingController _deadLine = new TextEditingController();



    String outputName = "";
    String score = "0";
    String maxScore = "0";
    DateTime birthDate = DateTime.now();
    DateFormat format = DateFormat(DateFormat.YEAR_MONTH_DAY);


    void updateOutput() async {
      format = DateFormat('yyyy-MM-dd');
      String dateString = format.format(birthDate);
      print("$dateString");

      results = await dbLoader.connectDB(Query.updateSubjectTrackable(
          typeID: typeID,
          maxScore: double.parse(maxScore),
          score: double.parse(score),
          date: dateString,
          name: outputName,
          trackableID: Query.currentOutput));
      sql.Results r =  await dbLoader.connectDB(Query.updateProjectedGrade(
          user: Query.userName, subID: Query.currentSubject, periodID: Query.currentPeriod));
      print("Update Please: ${r.affectedRows}");
      setState(() {
        if (results.affectedRows > 0)
          Navigator.of(context, rootNavigator: true).pop();
      });
    }

    void deleteOutput() async {
      results =
          await dbLoader.connectDB(Query.deleteTrackable(Query.currentOutput));
     sql.Results r = await dbLoader.connectDB(Query.updateProjectedGrade(
          user: Query.userName, subID: Query.currentSubject, periodID: Query.currentPeriod));
     print("Update Please: ${r.affectedRows}");
      setState(() {
        if (results.affectedRows > 0)
          Navigator.of(context, rootNavigator: true).pop();
      });
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


    return !showList
        ? Container(
            key: UniqueKey(),
            height: 100,
            child: Text("No trackables"),
          )
        : Card(
            margin: EdgeInsets.zero,
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: _trackableData.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Colors.black,
                      thickness: .5,
                    ),
                itemBuilder: (context, i) {

                  return ListTile(
                    onLongPress: () {
                      Query.currentOutput = _trackableData[i].trackableID;
                      _outputNameController.text = _trackableData[i].trackableName;
                      _outputScoreController.text =
                          _trackableData[i].score.toString();
                      _outputMaxScoreController.text =
                          _trackableData[i].maxScore.toString();
                      _deadLine.text = format.format(birthDate);
                      outputName = _outputNameController.text;
                      score = _outputScoreController.text;
                      maxScore = _outputMaxScoreController.text;
                      print("CurrentOutput: ${Query.currentOutput}");
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  "Add Output to ${Query.currentSubjectName}"),
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
                                        onChanged: (String value) =>
                                            outputName = value,
                                        cursorColor:
                                            Theme.of(context).primaryColor,
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
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9.,]+')),
                                        ],
                                        controller: _outputScoreController,
                                        onChanged: (String value) =>
                                            score = value,
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
                                        cursorColor:
                                            Theme.of(context).primaryColor,
                                        controller: _outputMaxScoreController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9.,]+')),
                                        ],
                                        onChanged: (String value) =>
                                            maxScore = value,
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
                                        cursorColor:
                                            Theme.of(context).primaryColor,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            flex: 2,
                                            child: ElevatedButton(
                                              child: Text("Update"),
                                              onPressed: () {
                                                updateOutput();
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
                                            )),
                                        Flexible(
                                            flex: 2,
                                            child: ElevatedButton(
                                              child: Text("Delete"),
                                              onPressed: () {
                                                deleteOutput();
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
                    minVerticalPadding: 0,
                    title: Text(_trackableData[i].trackableName),
                    subtitle: Text(_trackableData[i].typeName),
                    trailing: Text(
                        "${_trackableData[i].score.toString()}/${_trackableData[i].maxScore.toString()}"),
                    onTap: () {
                      setState(() {
                        Query.currentOutput = _trackableData[i].trackableID;
                        widget.onPressTrackable(_trackableData[i]);
                        print("title");
                      });
                    },
                  );
                }),
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/* :ExpansionPanelList(
            key: UniqueKey(),
            elevation: 3,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _trackableData[index].isExpanded = !isExpanded;
              });
            },
            children: _trackableData.map<ExpansionPanel>((TrackableValue value) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(value.trackableName),
                    subtitle: Text(value.typeName),trailing: Text("${value.score.toString()}/${value.maxScore.toString()}"),
                    onTap: () {
                      setState(() {
                        widget.onPressTask(value.trackableID, value);
                        print("title");
                      });
                    },
                  );
                },
                body: Card(
                    margin: EdgeInsets.all(0),
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                            padding: EdgeInsets.all(5),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "${value.typeName} ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                    )),
                isExpanded: value.isExpanded,
              );
            }).toList(),
            expandedHeaderPadding: EdgeInsets.zero,
          );*/
