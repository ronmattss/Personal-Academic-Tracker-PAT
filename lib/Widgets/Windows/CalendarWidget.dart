import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CalendarWidget();
}

class _CalendarWidget extends State<CalendarWidget> {
  var _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TableCalendar(
      calendarController: _calendarController,
      calendarStyle: CalendarStyle(
          outsideDaysVisible: true,
          contentDecoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              border: Border.all(color: Color(0xff000000)),
              shape: BoxShape.rectangle)),
      rowHeight: 125,
      headerVisible: true,
    );
  }
}
