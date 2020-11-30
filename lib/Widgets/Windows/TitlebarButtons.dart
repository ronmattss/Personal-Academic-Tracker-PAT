import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class TitlebarButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(children: [
      Container(
          width: 50,
          child: FlatButton(
            padding: EdgeInsets.only(right: 5, bottom: 20),
            onPressed: () => appWindow.minimize(),
            child: Center(
                child: Icon(
              Icons.minimize,
              size: 15,
            )),
          )),
      Container(
          width: 50,
          child: FlatButton(
            padding: EdgeInsets.only(right: 5),
            onPressed: () => appWindow.maximizeOrRestore(),
            child: Icon(
              Icons.check_box_outline_blank,
              size: 15,
            ),
          )),
      Container(
          width: 50,
          child: FlatButton(
            padding: EdgeInsets.only(right: 5),
            hoverColor: Colors.red,
            onPressed: () => appWindow.close(),
            child: Icon(
              Icons.close,
              size: 15,
            ),
          ))
    ]);
  }
}
