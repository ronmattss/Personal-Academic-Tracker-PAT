import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';
import 'package:personalacademictracker/Widgets/Windows/ToDoCard.dart';
import 'package:intl/intl.dart';
import 'package:personalacademictracker/main.dart';

//TaskView shows the list of tasks
// with to do list inside
class TaskView extends StatefulWidget {
  final int subjectID;
  final Function(int,TaskValue) onPressTask;


  const TaskView({Key key, this.subjectID, this.onPressTask}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TaskViewState();
}

class DummyValue {
  DummyValue({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class TaskValue {
  TaskValue({
     this.taskID,
     this.taskName,
     this.taskDescription,
     this.datetime,
     this.deadline,
     this.taskIsdone,
    this.isExpanded = false,
  });
  int taskID;
  String taskName;
  String taskDescription;
  String datetime;
  String deadline;
  int taskIsdone;

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
List<DummyValue> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    //generate n DummyValues
    return DummyValue(
      //return the Values
      headerValue: 'No Data $index',
      expandedValue: 'No Data $index',
    );
  });
}

class _TaskViewState extends State<TaskView>
    with AutomaticKeepAliveClientMixin<TaskView> {
  DatabaseHelper dbLoader = new DatabaseHelper();
  sql.Results results;
  List<sql.Row> rows;
  List<DummyValue> _data = generateItems(1); // Generate Data Will be Async
  List<TaskValue> _taskData =[];
  bool showList = false;


  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    results = await dbLoader
        .connectDB(Query.getUserTasks(Query.userName, widget.subjectID));
    rows = results.toList();
   // print("What this: "+rows[0][0].runtimeType.toString());
    if (rows.isNotEmpty) {
      setState(()  {
        showList = true;
        for (int i = 0; i < rows.length; i++) {
          print("DateTime: ${rows[i][3].runtimeType}");
          TaskValue t = new TaskValue(
              taskID: rows[i][0],
              taskName: rows[i][1],
              taskDescription: rows[i][2],
              datetime: rows[i][3].toString(),
              deadline: rows[i][4].toString(),
              taskIsdone: rows[i][5]);
          _taskData.add(t);
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
    DateTime birthDate = DateTime.now();
    DateFormat format =
    DateFormat(DateFormat.YEAR_MONTH_DAY);
    final TextEditingController _deadLine = new TextEditingController();
    final TextEditingController _taskNameController = new TextEditingController();
    final TextEditingController _taskDescriptionController =
    new TextEditingController();
    String taskName = _taskNameController.text;
    String taskDescription = _taskDescriptionController.text;


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
    void updateData() async {
      format = DateFormat('yyyy-MM-dd HH-mm-ss');
      String dateString = format.format(birthDate);
      print("$dateString");
      print(taskName);
      print(taskDescription);
      results = await dbLoader.connectDB(Query.updateTask(taskName: taskName,taskDescription: taskDescription,deadLine: dateString,taskID: Query.currentTask,));

      setState(() {
        if (results.affectedRows > 0)
          Navigator.of(context, rootNavigator: true).pop();
      });
    }
    void deleteTask() async {
      format = DateFormat('yyyy-MM-dd HH-mm-ss');
      results = await dbLoader.connectDB(Query.deleteTask(Query.currentTask));
      setState(() {
        if (results.affectedRows > 0)
          Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyApp(
                  widget: DashboardWidget(
                    userName: Query.userName,
                    password: Query.password,
                    key: UniqueKey(),
                  ),
                )));
      });
    }

    return !showList ? Container(key: UniqueKey(),height: 100,child: Text("No task"),):ExpansionPanelList(key: UniqueKey(),
      elevation: 3,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _taskData[index].isExpanded = !isExpanded;
        });
      },
      children: _taskData.map<ExpansionPanel>((TaskValue value) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(value.taskName),
              subtitle: LinearProgressIndicator(
                value: 10,
                minHeight: 5,
                backgroundColor: Colors.blueGrey,
              ),onLongPress: ()
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                    _taskNameController.text = value.taskName;
                    _taskDescriptionController.text = value.taskDescription;
                    _deadLine.text = value.deadline;
                      Query.currentTask = value.taskID;
                      return AlertDialog(
                        title: Text("Update Task: ${Query.currentTask}"),
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
                                  cursorColor: Theme.of(context).primaryColor,
                                  controller: _taskNameController,
                                  onChanged: (String _value) =>  taskName = _value,
                                  decoration: InputDecoration(
                                    hintText: 'Add Task',
                                    labelText: 'Task Name',
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 30,
                                ),
                                child: TextField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  controller: _taskDescriptionController,
                                  onChanged: (String _value) =>
                                  taskDescription = _value,
                                  decoration: InputDecoration(
                                    hintText: 'Add Task Description',
                                    labelText: ' Task Description',
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 30,
                                ),
                                child: TextField(
                                  cursorColor: Theme.of(context).primaryColor,
                                  controller: _deadLine,
                                  onTap: () => _selectDate(context),
                                  decoration: InputDecoration(
                                    hintText: '',
                                    labelText: 'Task Deadline',
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: ElevatedButton(
                                        child: Text("Add"),
                                        onPressed: () {
                                          setState(() {

                                            updateData();
                                          });
                                        },
                                      )), // Add Database Entry and Pop
                                  Flexible(
                                      flex: 2,
                                      child: ElevatedButton(
                                        child: Text("Cancel"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: ElevatedButton(
                                        child: Text("Delete"),
                                        onPressed: () {
                                        deleteTask();
                                        },
                                      )),// pop cancel
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });


              },
              onTap: () {
                setState(() {
                  widget.onPressTask(value.taskID,value);
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
                        "${value.taskDescription} ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                ),
              )) /*ListTile(
            title: Text(value.expandedValue),
            subtitle: Text("To delete this panel, tap the trash can icon"),
            trailing: Icon(Icons.delete),
            onTap: () {
              setState(() {
                _data.removeWhere((currentItem) => value == currentItem);
              });
            },
          )*/
          ,
          isExpanded: value.isExpanded,
        );
      }).toList(),
      expandedHeaderPadding: EdgeInsets.zero,
    );
  }

  Widget _listOfTaskCard(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int itemIndex) => TaskCard(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
