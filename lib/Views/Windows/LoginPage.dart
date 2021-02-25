import 'package:flutter/material.dart';
import 'package:personalacademictracker/Views/Windows/RegisterPage.dart';
import 'package:personalacademictracker/main.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';
import 'package:personalacademictracker/main.dart';
import 'package:window_size/window_size.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Query q = new Query();
  DatabaseHelper connector = new DatabaseHelper();
  sql.Results results;
  List<sql.Row> rows;

  final TextEditingController _userNameController = new TextEditingController();
  String userName = "";
  final TextEditingController _passwordController = new TextEditingController();
  String password = "";

  void initState() {
    _userNameController.text = userName;
    _passwordController.text = password;
    super.initState();
  }

  void loadData(BuildContext context) async {
    final snackBar = SnackBar(content: Text('Error'));
    results = await connector.connectDB(Query.getUserPass(userName, password));
    Future<List<sql.Row>>.delayed(Duration(milliseconds: 500), () {
      return results.toList();
    }).then((value) {
      rows = value.toList();
      setState(() {
        Query.userName = userName;
        Query.password = password;
        print("From Static Query: ${Query.userName}");
        if(value.isNotEmpty) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyApp(
                        widget: DashboardWidget(
                          userName: userName,
                          password: password,
                        ),
                      )));
        }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 700,
        child: Column(
          mainAxisAlignment: MediaQuery.of(context).size.width > 700
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
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
                'Log in',
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
                  hintText: 'User ID',
                  labelText: 'User Account',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: TextField(
                obscureText: true,
                cursorColor: Theme.of(context).primaryColor,
                controller: _passwordController,
                onChanged: (String value) => password = value,
                decoration: InputDecoration(
                  hintText: 'Please enter your account password',
                  labelText: 'password',
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
                  'log in',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    loadData(context);
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 30,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Text('forget password')),
                  Expanded(flex: 0, child: TextButton(child: Text('Register Account'), onPressed: () {setState(() {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => MyApp(widget: SignUpPage(),)));
                  });},)),
                ],
              ),
            ),
/*            Expanded(flex: 1, child: Container()),
              Container(
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Text('Quick Login'),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
          ],
        ),
      ),
    );
  }
}
