import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calclass extends StatelessWidget {
  const Calclass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: cal(),
    );
  }
}

class cal extends StatefulWidget {
  const cal({Key? key}) : super(key: key);

  @override
  State<cal> createState() => _calState();
}

class _calState extends State<cal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Container(
                child: TableCalendar(
                  rowHeight: 70,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2099, 12, 31),
                  //onDaySelected: ,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
