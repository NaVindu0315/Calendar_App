import 'package:calendar_navindu/Classes/Holiday.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Classes/event.dart';

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

  late final ValueNotifier<List<Holidays>> _holidayss;

  ///events end

  DateTime today = DateTime.now();

  ///map to store events
  Map<DateTime, List<Eventss>> events = {};
  Map<DateTime, List<Holidays>> holievents = {};

  List<Eventss> _getEventsforDay(DateTime day) {
    ///retreive all the events to display all the evennts
    return events[day] ?? [];
  }

  List<Holidays> _getholidaysforDay(DateTime day) {
    ///retreive all the events to display all the evennts
    return holievents[day] ?? [];
  }

  ///function for onday selected
  /*void _dayselected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = day;
    });
    print(day);
  }*/
  void _dayselected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvets.value = _getEventsforDay(selectedDay);
        _holidayss.value = _getholidaysforDay(selectedDay);
      });
    }
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
    _holidayss = ValueNotifier(_getholidaysforDay(_selectedDay!));
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

                      ///public and Bank
                      ElevatedButton.icon(
                        icon: Icon(Icons.circle),
                        label: Text('Public and Bank Holiday '), //
                        onPressed: () {
                          //

                          holievents.addAll({
                            _selectedDay!: [Holidays('Public and Bank Holiday')]
                          });

                          _holidayss.value = _getholidaysforDay(_selectedDay!);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // Button color
                          onPrimary: Colors.white, // Text color
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.shopping_bag_outlined), //
                        label: Text('Mercantile Holiday'), //
                        onPressed: () {
                          //

                          holievents.addAll({
                            _selectedDay!: [Holidays('Mercantile Holiday')]
                          });

                          _holidayss.value = _getholidaysforDay(_selectedDay!);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // Button color
                          onPrimary: Colors.white, // Text color
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Icon(Icons.add),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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

                Flexible(
                  fit: FlexFit.loose,
                  child: ValueListenableBuilder<List<Eventss>>(
                    valueListenable: _selectedEvets,
                    builder: (context, value, _) {
                      return Container(
                        height: 200,
                        child: ListView.builder(
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
                                title: Text('${value[index].title}'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                ///holiday
                Flexible(
                  fit: FlexFit.loose,
                  child: ValueListenableBuilder<List<Holidays>>(
                    valueListenable: _holidayss,
                    builder: (context, value, _) {
                      return Container(
                        height: 200,
                        child: ListView.builder(
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
                                title: Text('${value[index].holidayname}'),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}