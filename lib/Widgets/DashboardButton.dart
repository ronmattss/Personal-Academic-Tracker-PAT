import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DashboardButton extends StatefulWidget {
  final String buttonTitle;
  final int subjectId;
  final bool isActive;
  final Widget newWidget;
  final Widget activeWidget;
  final Function(int) onPressButton;

  DashboardButton(
      {this.buttonTitle = '',
        this.subjectId,
      this.isActive = false,
      this.onPressButton,
      this.newWidget,
      this.activeWidget});

  @override
  State<StatefulWidget> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  Color activeStateColor = Colors.white;
  Color currentStateColor;
  bool currentState = false;

  @override
  void initState() {
    print(this.context.widget.toStringShort());
    currentState = widget.isActive;
    currentStateColor = activeStateColor;
    super.initState();
  }

  Widget _dashboardButton(BuildContext context) {
    Color inactiveStateColor = Theme.of(context).primaryColor;
    currentStateColor = currentState ? activeStateColor : inactiveStateColor;
    return ListTile(
      hoverColor: Theme.of(context).primaryColorDark,
      selectedTileColor: Theme.of(context).accentColor,
      selected: currentState,
      leading: Container(width: 3, color: currentStateColor),
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 1),
      horizontalTitleGap: 1,
      title: Center(
        child: Text(
          widget.buttonTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      onTap: () {
        setState(() {
          currentState = !currentState;
          currentStateColor =
              currentState ? activeStateColor : inactiveStateColor;
          widget.onPressButton(widget.subjectId); // invoke callback
          print(currentState);
          //widget.onPressButton(widget.newWidget);
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
