import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: Maybe Duplicate this for the subjects
class SubjectTrackableDescriptionWidget extends StatefulWidget {
  final String trackableNameDisplay;
  final String typeDisplay;
  final double score;
  final double maxScore;
  SubjectTrackableDescriptionWidget(
  {this.typeDisplay = "",
      this.trackableNameDisplay = "",
      this.maxScore = 0, this.score});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubjectTrackableDescriptionWidgetState();
  }
}

class _SubjectTrackableDescriptionWidgetState extends State<SubjectTrackableDescriptionWidget> {
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
                      " ${widget.trackableNameDisplay}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "score:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      " ${widget.score} / ${widget.maxScore}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Row(
                  children: [
                  ],
                ),
              ],
            ),
            Flexible(fit: FlexFit.loose,
              child: Container(
                width: 200,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Texts
                    Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          flex: 1,fit: FlexFit.loose,
                          child: Container(width: 500,
                            child: Text(
                              "Type: ${widget.typeDisplay}",
                              maxLines: 4,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                              overflow: TextOverflow.ellipsis,
                            ),
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
