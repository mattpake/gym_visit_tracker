import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(
    CalendarControllerProvider(
      controller: EventController(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
