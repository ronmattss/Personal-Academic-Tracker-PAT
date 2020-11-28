import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTestWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() =>_CalendarTestWidget();

}

class _CalendarTestWidget extends State<CalendarTestWidget> {
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
    return TableCalendar(calendarController: _calendarController,calendarStyle: CalendarStyle(outsideDaysVisible: false) ,headerVisible: false,);
  }
}
