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
  ///for events
  TextEditingController _eventcontroller = new TextEditingController();
  String Eventname = "";
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  ///to display
  late final ValueNotifier<List<Eventss>> _selectedEvets;

  ///events end

  DateTime today = DateTime.now();

  ///map to store events
  Map<DateTime, List<Eventss>> events = {};

  List<Eventss> _getEventsforDay(DateTime day) {
    ///retreive all the events to display all the evennts
    return events[day] ?? [];
  }

  ///function for onday selected
  void _dayselected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = day;
    });
    print(day);
  }

/*
  @override
  void initstate() {
    super.initState();
    // today = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvets = ValueNotifier(_getEventsforDay(_selectedDay!));
  }*/
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvets = ValueNotifier(_getEventsforDay(_selectedDay!));
    // ... rest of your initState code
  }

  @override
  void dispose() {
    super.dispose();
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
                    content: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        controller: _eventcontroller,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            ///adding event
                            events.addAll({
                              _selectedDay!: [Eventss(_eventcontroller.text)]
                            });
                            _selectedEvets.value =
                                _getEventsforDay(_selectedDay!);
                            _eventcontroller.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Add Event")),
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2099, 12, 31),
                    onDaySelected: _dayselected,
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    eventLoader: _getEventsforDay,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
