import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personalacademictracker/Helpers/Query.dart';

import 'package:personalacademictracker/Preferences/CustomTheme.dart';
import 'package:personalacademictracker/Views/Windows/LoginPage.dart';
import 'package:personalacademictracker/Views/Windows/RegisterPage.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';
import 'package:personalacademictracker/Widgets/SubjectCard.dart';
import 'package:window_size/window_size.dart';
import 'Helpers/databaseHelper.dart';

void main()  {
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
      home: MyHomePage(title: 'Personal Academic Tracker',widget: widget,),
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
  double width = 0;

  void _incrementCounter() {
    setState(() {
      var x = MediaQuery.of(context).size.width;
      width = x;
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(elevation: 0,
        title: Text(widget.title),
      ),*/
      body: widget.widget == null ? LoginWidget():widget.widget,//DashboardWidget(),
      /*drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            hoverColor: Theme.of(context).accentColor,
            title: Center(
                child: Text(
              'Subjects',
              style: TextStyle(color: Colors.white),
            )),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Center(child: Text('Settings')),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      )),*/
/*      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
