import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Views/Windows/LoginPage.dart';
import 'package:personalacademictracker/main.dart';
import 'package:window_size/window_size.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  DatabaseHelper connector = new DatabaseHelper();
  sql.Results results;
  List<sql.Row> rows;
  DateTime birthDate = DateTime.now();
  DateFormat format =
      DateFormat(DateFormat.YEAR_MONTH_DAY); // Format upon Clicking
  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: birthDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _birthDate.text = format.format(value);
        format = DateFormat('yyyyMMdd');
        birthDate = DateTime.parse(format.format(value));
      });
      return;
    });
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
      });
  }

  // controllers for form text controllers
  final TextEditingController _userNameController = new TextEditingController();
  String userName = "" /*"Kerbal-20-10-KSP"*/;
  final TextEditingController _passwordController = new TextEditingController();
  String password = "";
  final TextEditingController _firstNameController =
      new TextEditingController();
  String firstName = "" /*"Jeb"*/;
  final TextEditingController _lastNameController = new TextEditingController();
  String lastName = "" /*"Jeffrey"*/;
  final TextEditingController _middleNameController =
      new TextEditingController();
  String middleName = "" /*"Jeremiah"*/;
  final TextEditingController _birthDate = new TextEditingController();
  String birthDateString = DateTime.now().toString();

  void initState() {

    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _userNameController.text = userName;
    _middleNameController.text = middleName;
    _birthDate.text = format.format(DateTime.now());
    super.initState();
  }

  void sendData() async {
    format = DateFormat('yyyy-MM-dd');
    String dateString = format.format(birthDate);
    print("$dateString");
    results = await connector.connectDB(Query.insertProfileToTable(
        userName,
        password,
        lastName,
        firstName,
        middleName,
        dateString));

    setState(() {
      if (results.affectedRows > 0)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyApp(widget: LoginWidget(),)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'PAT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                controller: _userNameController,
                onChanged: (String value) => userName = value,
                decoration: InputDecoration(
                  hintText: 'Create your own username',
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                controller: _passwordController,
                onChanged: (String value) => password = value,
                decoration: InputDecoration(
                  hintText: 'Create Password',
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                controller: _lastNameController,
                onChanged: (String value) => lastName = value,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  labelText: 'Last Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                controller: _firstNameController,
                onChanged: (String value) => firstName = value,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  labelText: 'First Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                controller: _middleNameController,
                onChanged: (String value) => middleName = value,
                decoration: InputDecoration(
                  hintText: 'Middle Name',
                  labelText: 'Middle Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: TextField(
                cursorColor: Theme.of(context).primaryColor,
                controller: _birthDate,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  hintText: '',
                  labelText: 'BirthDate',
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {setState(() {
                  sendData();
                });},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Already have an account?'),
                  TextButton(child:Text(' Click Here'),onPressed: (){
                    setState(() {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => MyApp(widget: LoginWidget(),)));
                    });
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
