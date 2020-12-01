import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personalacademictracker/Preferences/CustomTheme.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';
import 'package:personalacademictracker/Widgets/SubjectCard.dart';
import 'package:personalacademictracker/Helpers/databaseHelper.dart';
import 'package:carousel_slider/carousel_slider.dart';

Future<void> main() async {
  // var connection = new DatabaseHelper();
//   print(await connection.connectDB());
  runApp(MyApp());
  doWhenWindowReady(() {
    var win = appWindow;
    var initialSize = Size(1680, 900);
    win.minSize = initialSize;
    win.size = win.sizeOnScreen;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Academic Tracker',
      home: MyHomePage(title: 'Personal Academic Tracker'),
      theme: CustomThemeData.customTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

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

  Widget _customCarousel(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(height: 600),
        itemCount: 15,
        itemBuilder: (BuildContext context, int itemIndex) => Container(
              child: SubjectCard(),
            ));
  }

  Widget _customCardList(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 9,
      itemBuilder: (BuildContext context, int itemIndex) => Container(
        child: SubjectCard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(elevation: 0,
        title: Text(widget.title),
      ),*/
      body: WindowBorder(
          color: Theme.of(context).primaryColor,
          width: 1,
          child: DashboardWidget()),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
