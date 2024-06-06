import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

class cal extends StatefulWidget {
  const cal({Key? key}) : super(key: key);

  @override
  State<cal> createState() => _calState();
}

class _calState extends State<cal> {
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
/*
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
      today = day;
    });
    print(day);
  }

  @override
  void initstate() {
    super.initState();
    today = DateTime.now();
    //_selectedday = _focuedday
    _selectedEvets = ValueNotifier(_getEventsforDay(today));
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
                              today!: [Eventss(_eventcontroller.text)]
                            });
                            _selectedEvets.value = _getEventsforDay(today);
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
                    focusedDay: today,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2099, 12, 31),
                    onDaySelected: _dayselected,
                    eventLoader: _getEventsforDay,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ValueListenableBuilder<List<Eventss>>(
                      valueListenable: _selectedEvets,
                      builder: (context, value, _) {
                        return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  onTap: () => print(""),
                                  title: Text('${value[index]}'),
                                ),
                              );
                            });
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 */
