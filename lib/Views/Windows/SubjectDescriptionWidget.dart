import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubjectDescriptionWidget extends StatefulWidget {
  final String taskNameDisplay;
  final String taskDescriptionDisplay;
  final int isComplete;
  SubjectDescriptionWidget(
      [this.taskDescriptionDisplay = "",
      this.taskNameDisplay = "",
      this.isComplete = 0]);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubjectDescriptionWidgetState();
  }
}

class _SubjectDescriptionWidgetState extends State<SubjectDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Theme.of(context).primaryColor,
        height: 150,
        padding: EdgeInsets.only(left: 20, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Texts For Descriptions
                Row(
                  children: [
                    Text(
                      "Task:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${widget.taskNameDisplay}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Todos:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      " 10/50",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status: ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${checkIfComplete(widget.isComplete)}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
            Container(
              width: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Texts
                    Row(
                      children: [
                        Container(
                          width: 500,
                          child: Text(
                            "Task Description: ${widget.taskDescriptionDisplay}",
                            maxLines: 4,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
  String checkIfComplete(int tinyInt) => tinyInt == 0 ? "Ongoing":"Complete";
}
