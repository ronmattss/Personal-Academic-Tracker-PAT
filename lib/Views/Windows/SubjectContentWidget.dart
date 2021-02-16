import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Widgets/TaskCard.dart';
class SubjectContent extends StatefulWidget {
  List<sql.Row> results;

  SubjectContent({this.results});
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState

    return _SubjectContentState();
  }
}

class _SubjectContentState extends State<SubjectContent>
{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 370,
          childAspectRatio: 1/1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: widget.results.length,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(25)),
            child: Card(
              color: Theme.of(context)
                  .primaryColor,
              elevation: 5,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                      25)),
              child: SizedBox(
                height: 60,
                child: Column(
                  children: [
                    Padding(
                      child: ToDoCard(),
                      padding: EdgeInsets.only(
                          top: 15,
                          left: 8,
                          right: 8,
                          bottom: 5),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Material(
                        borderRadius:
                        BorderRadius.only(
                            bottomRight:
                            Radius
                                .circular(
                                25),
                            bottomLeft: Radius
                                .circular(
                                25)),
                        child: Padding(
                          padding:
                          const EdgeInsets
                              .only(
                              top: 5,
                              left: 5),
                          child: SizedBox(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Text(
                                  "${widget.results[index]}",
                                  style: TextStyle(
                                      fontSize:
                                      20,
                                      color: Colors
                                          .black),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            width: 300,
            height: 300,
          ),
        );
      },
    );
  }

}
