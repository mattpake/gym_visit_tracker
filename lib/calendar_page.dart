import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final event = CalendarEventData(
    date: DateTime(2021, 12, 10),
    startTime: DateTime(2021, 12, 10, 14),
    // 14 is start time
    endTime: DateTime(2021, 12, 10, 17),
    // 17 is end time
    event: "Football Tournament",
    title: "Football Tournament",
    description: "Go to football tournament.",
  );

  @override
  Widget build(BuildContext context) {
    if (!CalendarControllerProvider.of(context)
        .controller
        .events
        .contains(event)) {
      CalendarControllerProvider.of(context).controller.add(event);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Page'),
      ),
      body: WeekView(),
    );
  }
}
