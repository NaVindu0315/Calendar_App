import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

class Calendar_Widget extends StatelessWidget {
  const Calendar_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calendar2(),
    );
  }
}

class Calendar2 extends StatefulWidget {
  const Calendar2({Key? key}) : super(key: key);

  @override
  State<Calendar2> createState() => _Calendar2State();
}

class _Calendar2State extends State<Calendar2> {
  DateTime today = DateTime.now();

  ///map to store events
  Map<DateTime, List<Eventss>> events = {};

  ///function for onday selected
  void _dayselected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    print(day);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        ///floating action button to add events
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Add new Event"),
                    content: Text("pako"),
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Text('Selected : ' + today.toString()),
              SizedBox(
                height: 40.0,
              ),
              Container(
                child: TableCalendar(
                  rowHeight: 70,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  focusedDay: today,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2099, 12, 31),
                  onDaySelected: _dayselected,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
