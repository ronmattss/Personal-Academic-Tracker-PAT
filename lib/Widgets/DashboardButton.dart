import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// State Management will determine what Page the user clicked
// which means this needs to be a seperate widget
// active Board is determined via the color in the side
// darken selected board color
class DashboardButton extends StatefulWidget {
  final String buttonTitle;
  final bool isActive;
  DashboardButton([this.buttonTitle = '', this.isActive = false]);
  @override
  State<StatefulWidget> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  Color activeStateColor = Colors.white;
  Color currentStateColor;
  bool currentState = false;
  @override
  void initState() {
    currentState = widget.isActive;
    currentStateColor = activeStateColor;
    super.initState();
  }

  Widget _dashboardButton(BuildContext context) {
    Color inactiveStateColor = Theme.of(context).primaryColor;
    currentStateColor = currentState ? activeStateColor : inactiveStateColor;
    return ListTile(
      leading: Container(width: 3, color: currentStateColor),
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 1),
      horizontalTitleGap: 1,
      title: Center(
          child: Text(
        widget.buttonTitle,
        style: TextStyle(color: Colors.white),
      )),
      onTap: () {
        setState(() {
          currentState = !currentState;
          currentStateColor =
              currentState ? activeStateColor : inactiveStateColor;
          print(currentState);
        });
        // Update the state of the app.
        // ...
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _dashboardButton(context);
  }
}
