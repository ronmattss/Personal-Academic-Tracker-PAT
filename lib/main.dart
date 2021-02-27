import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:mysql1/mysql1.dart' as sql;
import 'package:personalacademictracker/Preferences/CustomTheme.dart';
import 'package:personalacademictracker/Views/Windows/LoginPage.dart';
import 'package:personalacademictracker/Views/Windows/RegisterPage.dart';
import 'package:personalacademictracker/Widgets/CustomDropdown.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';
import 'package:personalacademictracker/Widgets/SubjectCard.dart';
import 'package:window_size/window_size.dart';
import 'Helpers/databaseHelper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Personal Academic tracker');

    setWindowMinSize(const Size(400, 500));
    setWindowMaxSize(Size.infinite);
  }
  runApp(MyApp());
/*  doWhenWindowReady(() {
    var win = appWindow;
    var initialSize = Size(1680, 900);
    win.minSize = initialSize;
    win.size = win.sizeOnScreen;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });*/
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({Key key, this.widget}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Academic Tracker',
      home: MyHomePage(
        title: 'Personal Academic Tracker',
        widget: widget,
      ),
      theme: CustomThemeData.customTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.widget}) : super(key: key);
  final String title;
  final Widget widget;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String subject = "Select";
  double width = 0;
  sql.Results results;
  sql.Results resultsPeriod;
  List<sql.Row> rows;
  List<sql.Row> rowsPeriod;
  List<String> periods = [];
  List<String> subjects = [];
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.widget == null ? LoginWidget() : widget.widget,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
