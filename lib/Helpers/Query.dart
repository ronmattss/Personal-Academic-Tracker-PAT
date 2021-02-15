import 'package:mysql1/mysql1.dart';

import 'databaseHelper.dart';

class Query
{
static String getSubjectsOfUser = "SELECT subjectName as \"Subjects of user\", periodName as \"Period\" FROM subject_table as st INNER JOIN grading_period_table as gp INNER JOIN period_table as pt WHERE gp.periodID = pt.periodID AND st.subjectID = gp.subjectID AND gp.studentID=\"2018-01405-MN-0\";";
}