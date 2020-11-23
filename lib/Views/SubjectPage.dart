import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Thie Page is the expanded version of the Lists
class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  var title = 'hehe';
  var timeDilation;
 Widget _todoTile(BuildContext context)
 {
     return ListTile(
       leading: Checkbox(
         value: timeDilation == true,
         onChanged: (bool value) {
           setState(() {
             timeDilation = value ? true : false;
             title = value ? "woo":"wee";
           });
         },
       ),
       title: Text("Task Title"),
       subtitle: Text(title),
       onTap: () {
         setState(() {       // Go to Subject Page
           title = "weeeeeeeeeeeeee";
           print(title);
         });
       },
     );
 }
 Widget _listOfTodo(BuildContext context)
 {
   return ListView.builder(itemCount: 10,itemBuilder: (BuildContext context, int itemIndex)=>_todoTile(context),);
 }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Subject Title"),
      ),
      body: Center(
        child: _listOfTodo(context),
      ),
    );
  }
}
