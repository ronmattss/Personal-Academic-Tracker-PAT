// Main Subject Card
// contains Subject title
// list of to do list

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Views/SubjectPage.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SubjectCardState();
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
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

//TODO: Dynamic sizing
class _SubjectCardState extends State<SubjectCard> {
  List<DummyValue> _data = generateItems(10); // Generate Data Will be Async
  Widget _buildTaskPanel(BuildContext context) {
    return InkResponse(onTap: (){setState(() {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>SubjectPage()));
      print("Hello");
    });},child:ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((DummyValue value) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(value.headerValue),subtitle: LinearProgressIndicator(value: 10,minHeight: 5,backgroundColor: Colors.blueGrey,),
            );
          },
          body: SizedBox(height:  300,child: _listOfTaskCard(context))/*ListTile(
            title: Text(value.expandedValue),
            subtitle: Text("To delete this panel, tap the trash can icon"),
            trailing: Icon(Icons.delete),
            onTap: () {
              setState(() {
                _data.removeWhere((currentItem) => value == currentItem);
              });
            },
          )*/,
          isExpanded: value.isExpanded,
        );
      }).toList(),
    ));
  }

  Widget _listOfTaskCard(BuildContext context) {
    return ListView.builder(
      itemCount: 10,shrinkWrap: true,
      itemBuilder: (BuildContext context, int itemIndex) => TaskCard(),
    );
  }

  Widget _customCard(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 600,
      child: Card(
          color: Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          /* child: Container(
      color: Colors.red,
      width: 300,
      height: 600,*/
          child: Column(children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('Subject Title'),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text('List of To do')),
            ),
            Flexible(
                child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15, top: 5),
                child:SingleChildScrollView(child:  _buildTaskPanel(context),),
              ),
            ))
          ])),
    ); //);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Center(child: _customCard(context));
  }
}
