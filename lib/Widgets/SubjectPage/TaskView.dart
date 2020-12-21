import 'package:flutter/material.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

//TaskView shows the list of tasks
// with to do list inside
class TaskView extends StatefulWidget {
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

// Data Generation
List<DummyValue> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    //generate n DummyValues
    return DummyValue(
      //return the Values
      headerValue: 'Task $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _TaskViewState extends State<TaskView> with AutomaticKeepAliveClientMixin<TaskView> {
  List<DummyValue> _data = generateItems(15); // Generate Data Will be Async
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
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((DummyValue value) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(value.headerValue),
              subtitle: LinearProgressIndicator(
                value: 10,
                minHeight: 5,
                backgroundColor: Colors.blueGrey,
              ),
            );
          },
          body: SizedBox(
              height: 300,
              child: _listOfTaskCard(
                  context)) /*ListTile(
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
      }).toList(),expandedHeaderPadding: EdgeInsets.zero,
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
