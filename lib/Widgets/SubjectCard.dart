// Main Subject Card
// contains Subject title
// list of to do list

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Widgets/TaskCard.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SubjectCardState();
}

//TODO: Dynamic sizing
class _SubjectCardState extends State<SubjectCard> {
  Widget _listOfTaskCard(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (BuildContext context, int itemIndex) => TaskCard(),
    );
  }

  Widget _customCard(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 600,
      child: Card(
          color: Colors.deepOrangeAccent,
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
              color: Colors.amberAccent,
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text('List of To do')),
            ),
            Flexible(
                child: Container( decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
              width: MediaQuery.of(context).size.width,
              child: Padding(padding: EdgeInsets.only(bottom: 15,top: 5),child: _listOfTaskCard(context),),
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
