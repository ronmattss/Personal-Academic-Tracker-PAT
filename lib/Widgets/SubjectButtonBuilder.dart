import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Widgets/DashboardButton.dart';

class SubjectListBuilder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SubjectListBuilderState();
}

// This will be a future builder for Subjects
class SubjectListBuilderState extends State<SubjectListBuilder> {
  DatabaseHelper dbHelper = new DatabaseHelper();
  sql.Results result;
  Widget initial = Text("No data");
  List<sql.Row> rows;
  @override
  void initState() {
    loadAsync();
    super.initState();
  }

  void loadAsync() async {
    result = await dbHelper.connectDB(Query.getSubjectsOfUser);
    rows = result.toList();

    initial = listOfSubjectsButton();
  }

  Widget listOfSubjectsButton() {
    return ListView.builder(shrinkWrap: true,
        itemCount: rows.length,
        itemBuilder: (BuildContext context, int index) {
          return DashboardButton(
            buttonTitle: rows[index][0],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
return initial;
  }
}
