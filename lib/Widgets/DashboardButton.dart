import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personalacademictracker/Helpers/Query.dart';
import 'package:personalacademictracker/Widgets/DashboardWidget.dart';
import 'package:personalacademictracker/main.dart';


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
      selected: currentState,
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 1),
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          widget.buttonTitle,
          style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,
        ),
      ),onLongPress: (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyApp(
                    widget: DashboardWidget(
                      userName: Query.userName,
                      password: Query.password,key: UniqueKey(),
                    ),
                  )));
    },
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
