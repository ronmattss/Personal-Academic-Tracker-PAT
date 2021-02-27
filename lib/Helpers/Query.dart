import 'package:mysql1/mysql1.dart';
import 'package:intl/intl.dart';
import 'databaseHelper.dart';

/*
* how will this work
* login page will check if a username and password is available in the Database
* the username will be stored in a variable that will be accessed through out the app
* Loading the main Dashboard: this will also load the Subject List
* Subject List Contains Subject IDs which if clicked, will show the Subject info, grade, Tasks,\Todo,\Trackables
* Which only needs the username and Subject ID for that
* */
class Query {

  static final Query _singleton = Query._internal();

  factory Query() {
    return _singleton;
  }

  Query._internal();
  // Profile Part
  static String userName = "2018-01405-MN-0";
  static String password = "password";
  static int currentTask;
  static int currentTodo;
  static int currentSubject;
 // static String getProfile = "";
 // static String getUserPassTest =
 //     "Select * From profile_table Where studentID =\"2018-01405-MN-0\" AND password = \"password\";";

  // Subject Info and grade
  //static String getUserProjectedGradePerSubject = "";
  static String getSubjectList = ""; // View of Subjects

  // Insert
  //static String insertProfile = "INSERT INTO `patdb`.`profile_table`(`studentID`,`password`,`lastName`,`firstName`,`middleName`,`birthDate`)VALUES(<{studentID: }>,<{password: }>,<{lastName: }>,<{firstName: }>,<{middleName: }>,<{birthDate: }>);";       // Insert Profile // call this in a function
  static String insertGradingPeriod =""; // contains Subject, Grading Period, and null Grade // call this in a function
  //static String insertSubjectTask = "CALL `patdb`.`insert_Subject_Task`('2018-01405-MN-0', 1,'taskNameTest', 'task description', 20200130193000, '20200228193000', 0);"; // call this in a function
  //static String insertSubjectTrackable = "CALL `patdb`.`insert_Subject_Trackable`('SeatWork 5', 5, 5, 20210131, 2, '2018-01405-MN-0',1);"; // call this in a function
  //static String insertTaskTodo = "INSERT INTO `patdb`.`todo_table`(`todoID`,`taskID`,`todoName`,`todoDescription`,`todoComplete`)VALUES(<{todoID: }>,<{taskID: }>,<{todoName: }>,<{todoDescription: }>,<{todoComplete: }>);";

  //static String getUserTask = "Select todoName,todoDescription,todoComplete From todo_table Where taskID in(Select taskID From subjecttasks_table Where studentID ="2018-01405-MN-0" AND subjectID = 1);";
  static String getUserTodo = "";
  static String updateProjectedGrade = "";

 // static String getSubjectsOfUser =
 //     "SELECT subjectName as \"Subjects of user\", periodName as \"Period\" FROM subject_table as st INNER JOIN grading_period_table as gp INNER JOIN period_table as pt WHERE gp.periodID = pt.periodID AND st.subjectID = gp.subjectID AND gp.studentID=\"2018-01405-MN-0\";";


// Views for list of
  /*
  * subjects
  * periods
  * type
  * */


  static String setUserProfile(String id, String pass,String ln,String fn, String mn, DateTime birthDate)
  {
    DateFormat format = DateFormat('yyyyMMdd');
    String insertProfile = "INSERT INTO `patdb`.`profile_table`(`studentID`,`password`,`lastName`,`firstName`,`middleName`,`birthDate`)VALUES('$id','$password','$ln','$fn','$mn',${format.format(birthDate)});";
    return insertProfile;
  }

  // for login and profile
  static String getUserPass(String userID,String password)
  {
     String getUserPass =
        "Select * From profile_table Where studentID ='$userID' AND password = '$password';";
     return getUserPass; // if ok then store ID
  }


  static String getUserProjectedGrade(String userID,int subjectID)
  {
    String projectedGrade = "SELECT Round((Sum(score)/Sum(maxscore)) * 100) as 'projected_grade'From trackablegrade_table as tr inner join type_table as t on tr.typeID = t.typeID Where trackableID IN(Select trackableID from subjecttrackablegrade_table Where subjectID=$subjectID AND studentID ='$userName');";
      return projectedGrade;
  }

  static String getUserTrackables(String userID,int subjectID)
  {
   String getTrackables = "SELECT trackableID,trackableName,typeName,score,maxscore as 'max Score' From trackablegrade_table as tr inner join type_table as t on tr.typeID = t.typeID Where trackableID IN(Select trackableID from subjecttrackablegrade_table Where subjectID=$subjectID AND studentID ='$userID');";
   return getTrackables;
  }

  static String getSubjectsOfUser(String userID)
  {
    String getSubjectsOfUser = "SELECT st.subjectId,subjectName as \"Subjects of user\", periodName as \"Period\" FROM subject_table as st INNER JOIN grading_period_table as gp INNER JOIN period_table as pt WHERE gp.periodID = pt.periodID AND st.subjectID = gp.subjectID AND gp.studentID='$userID';";
  return getSubjectsOfUser;
  }

  static String getSpecificSubjectOfUser(String userID,int subjectID)
  {
    String getSubjectOfUser = "SELECT subjectName as \"Subjects of user\", periodName as \"Period\",grade FROM subject_table as st INNER JOIN grading_period_table as gp INNER JOIN period_table as pt WHERE gp.periodID = pt.periodID AND st.subjectID = gp.subjectID AND gp.studentID='$userID' AND gp.subjectID = $subjectID;";
    return getSubjectOfUser;
  }

  static String getUserTasks(String userId,int subjectID)
  {
    String getUserTask = "Select * From task_table Where taskID in(Select taskID From subjecttasks_table Where studentID ='$userId' AND subjectID = $subjectID);";
     //String getUserTodos = "Select * From todo_table Where taskID in(Select taskID From subjecttasks_table Where studentID ='$userId' AND subjectID = $subjectID);";
     return getUserTask;

  }
  static String getUserTodos(String userId,int subjectID,int taskID)
  {
    String getUserTodos = "Select * From todo_table Where taskID in(Select taskID From subjecttasks_table Where studentID ='$userId' AND subjectID = $subjectID AND taskID = $taskID);";
    return getUserTodos;

  }




  // note that the index of the values are 0 if put on a list
  static String getSubjects () => 'SELECT * FROM patdb.subjectlist;';
  static String getPeriod () => 'SELECT * FROM patdb.periodlist;';


  // Insert Statements
  static String insertTaskTodo(
      int taskID, String todoName, String todoDesc, bool isComplete) {
    String insertTaskTodo =
        "INSERT INTO `patdb`.`todo_table`(`taskID`,`todoName`,`todoDescription`,`todoComplete`)VALUES($taskID,$todoName,$todoDesc,$isComplete);";
    return insertTaskTodo;
  }

  static String insertProfileToTable(String studentID, String password,
      String lastName, String firstName, String middleName, String birthDate) {
    String insertProfile =
        "INSERT INTO `patdb`.`profile_table`(`studentID`,`password`,`lastName`,`firstName`,`middleName`,`birthDate`)VALUES('$studentID','$password','$lastName','$firstName','$middleName','$birthDate');"; // Insert Profile // call this in a function
    return insertProfile;
  }


  // Insert Subject Grading
  static String insertSubjectTaskToTable(
      String userID,
      int subjectID,
      String taskNameTest,
      String taskDescription,
      String datetimeCreated,
      String deadline,
      bool isFinished) {
    int flag = isFinished ? 1 : 0;
    String insertSubjectTask =
        "CALL `patdb`.`insert_Subject_Task`('$userID',$subjectID,$taskNameTest, $taskDescription, $datetimeCreated, $deadline, $flag);"; // call this in a function
    return insertSubjectTask;
  }

  static String insertSubjectTrackable(
      String trackableName,
      double score,
      double maxScore,
      String date,
      int trackableID,
      String userID,
      int subjectID) {
    String insertSubjectTrackable =
        "CALL `patdb`.`insert_Subject_Trackable`($trackableName, $score, $maxScore, $date, $trackableID, $userID,$subjectID);";
    return insertSubjectTrackable;
  }
}
