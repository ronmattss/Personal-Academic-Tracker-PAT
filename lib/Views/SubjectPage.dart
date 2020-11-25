import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';

// Thie Page is the expanded version of the Lists
class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  var title = 'hehe';
  var timeDilation;
  Widget _todoTile(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: timeDilation == true,
        onChanged: (bool value) {
          setState(() {
            timeDilation = value ? true : false;
            title = value ? "woo" : "wee";
          });
        },
      ),
      title: Text("Task Title"),
      subtitle: Text(title),
      onTap: () {
        setState(() {
          // Go to Subject Page
          title = "weeeeeeeeeeeeee";
          print(title);
        });
      },
    );
  }

  Widget _listOfTodo(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int itemIndex) => _todoTile(context),
    );
  }

  Widget _leftSideMenu(BuildContext context) {
    return Text("title");
  }

  Widget _customBox(BuildContext context, double width, double height,
      [Color color]) {
    return Container(
      width: width,
      height: height,
      color: color != null ? color : Colors.transparent,
    );
  }
  Widget _customDashboard(BuildContext context)
  {
    return Row(children: [
      Flexible(
          child: Container(color: Colors.blueGrey,child: Row(
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
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(25)),child:Text("Some Content"),width: 200,height: 200,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: _customBox(context, 400, 200, Colors.redAccent),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 10),
                        child: _customBox(context, 200, 200, Colors.pinkAccent),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: _customBox(context, 400, 200, Colors.blueAccent),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child:
                        _customBox(context, 200, 200, Colors.greenAccent),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: _customBox(context, 200, 200, Colors.green),
                      )
                    ],
                  )
                ],
              ),
            ],
          )))
    ]);
  }

  // Crate left side Nav menu, right side le task
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text("Subject Title"),
        ),
        body:Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child: DashboardWidget()));
  }
}
