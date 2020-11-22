//Contains To do List which is an individual Task which also contains list of sub to do on that task

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget
{
  const TaskCard({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState()=> _TaskCardState();}


class _TaskCardState extends State<TaskCard>
{
  var timeDilation;
  Widget _customTaskTile(BuildContext context)
  {
    return CheckboxListTile(
      title: const Text('Some Task'),controlAffinity: ListTileControlAffinity.leading, checkColor: Colors.black,tileColor: Colors.white,activeColor: Colors.deepOrange,
      subtitle: const Text('Some Task Description'),
      value: timeDilation == true,
      onChanged: (bool value) {
        setState(() {
          timeDilation = value ? true: false;
        });
      },
      secondary: const Icon(Icons.book),
    );
  }
  Widget _customTaskCard(BuildContext context)
  {
    return SizedBox(height: 75,child: Card(child:_customTaskTile(context)));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

   return _customTaskCard(context);
  }

}