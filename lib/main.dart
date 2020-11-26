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
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Academic Tracker',
      home: MyHomePage(title: 'Personal Academic Tracker'),
      theme: CustomThemeData.customTheme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double width = 0;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
     /* appBar: AppBar(elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      body:
          DashboardWidget() /*Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Container(child: _customCardList(context),height: 600,)
            */ /*Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('$width'), */ /*
          ],
        ),
      )*/
      ,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(hoverColor: Theme.of(context).accentColor,
            title: Center(child: Text('Subjects',style: TextStyle(color: Colors.white),)),
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
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
