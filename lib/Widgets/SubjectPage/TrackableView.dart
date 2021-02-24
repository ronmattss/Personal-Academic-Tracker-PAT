import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
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

  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    results = await dbLoader.connectDB(Query.getUserTrackables(Query.userName, widget.subjectID));
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
    return !showList
        ? Container(
            key: UniqueKey(),
            height: 100,
            child: Text("No trackables"),
          ) : Card(margin: EdgeInsets.zero,
            child: ListView.separated(shrinkWrap: true,itemCount: _trackableData.length,separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black,thickness: .5,),itemBuilder: (context, i){
      return ListTile(minVerticalPadding: 0,
        title: Text(_trackableData[i].trackableName),
        subtitle: Text(_trackableData[i].typeName),trailing: Text("${_trackableData[i].score.toString()}/${_trackableData[i].maxScore.toString()}"),
        onTap: () {
            setState(() {
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
