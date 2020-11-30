import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class LeftSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                WindowTitleBarBox(child: MoveWindow()),
                Expanded(child: Container())
              ],
            )));
  }
}

var backgroundStartColor = Color(0xFFFFD500);
var backgroundEndColor = Color(0xFFF6A00C);

class RightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [backgroundStartColor, backgroundEndColor],
                  stops: [0.0, 1.0]),
            ),
            child: Column(children: [
              WindowTitleBarBox(
                  child: Row(children: [
                Expanded(child: MoveWindow()),
                WindowButtons()
              ])),
            ])));
  }
}

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buttonColors = WindowButtonColors(
        iconNormal: Colors.black,
        mouseOver: Theme.of(context).primaryColorLight,
        mouseDown: Theme.of(context).primaryColor,
        iconMouseOver: Color(0xFF805306),
        iconMouseDown: Color(0xFFFFD500));

    var closeButtonColors = WindowButtonColors(
        mouseOver: Colors.red[700],
        mouseDown: Colors.red[900],
        iconMouseOver: Colors.white);
    return Row(
      children: [
        MinimizeWindowButton(
          colors: buttonColors,
        ),
        MaximizeWindowButton(
          colors: buttonColors,
        ),
        CloseWindowButton(
          colors: closeButtonColors,
        ),
      ],
    );
  }
}
