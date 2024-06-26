import 'package:calendar_navindu/Classes/Holiday.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Classes/event.dart';
import '../Services/local_notifications.dart';

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
  TextEditingController _notecontroller = new TextEditingController();
  String Eventname = "";
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  ///to display
  late final ValueNotifier<List<Eventss>> _selectedEvets;

  late final ValueNotifier<List<Holidays>> _holidayss;

  ///events end

  DateTime today = DateTime.now();
  TimeOfDay starttime = TimeOfDay.now();
  TimeOfDay endtime = TimeOfDay.now();

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
    print(selectedDay);
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
    // selectedvalue = "15 minutes";
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _selectedValue = 'option1';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          leading: null,
          actions: <Widget>[],
          title: Text(
            '                 Calendar',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          backgroundColor: Color(0xff237ACC),
        ),

        ///floating action button to add events
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff237ACC),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Add new Event"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _eventcontroller,
                          decoration: InputDecoration(
                            labelText: 'Event Name',
                            // Add hint here
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.lock_clock),
                          onPressed: () async {
                            final TimeOfDay? timofday = await showTimePicker(
                              context: context,
                              initialTime: starttime,
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                            if (timofday != null) {
                              setState(() {
                                starttime = timofday;
                              });
                            }
                            print(starttime);
                          },
                          label: Text('Select Start Time'),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff237ACC), // Button color
                            onPrimary: Colors.white, // Text color
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.lock_clock),
                          onPressed: () async {
                            final TimeOfDay? timofday = await showTimePicker(
                              context: context,
                              initialTime: endtime,
                              initialEntryMode: TimePickerEntryMode.dial,
                            );
                            if (timofday != null) {
                              setState(() {
                                endtime = timofday;
                              });
                            }
                            print(endtime);
                          },
                          label: Text('Select End Time'),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff237ACC), // Button color
                            onPrimary: Colors.white, // Text color
                          ),
                        ),
                        TextField(
                          controller: _notecontroller,
                          decoration: InputDecoration(
                            labelText: 'Note',
                            // Add hint here
                          ),
                        ),
                        Text(
                          'Notify Me Before ',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        RadioListTile(
                          title: Text('15 Minutes'),
                          value: 'option1',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value as String;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('1 Hr'),
                          value: 'option2',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value as String;
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text('1 Day'),
                          value: 'option3',
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value as String;
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.event),
                        label: Text('Add Event'), //
                        onPressed: () {
                          events.addAll({
                            _selectedDay!: [
                              Eventss(
                                  _eventcontroller.text,
                                  _notecontroller.text,
                                  _selectedDay!,
                                  starttime,
                                  endtime)
                            ]
                          });
                          _selectedEvets.value =
                              _getEventsforDay(_selectedDay!);
                          LocalNotifications.showSimpleNotification(
                              title: _eventcontroller.text,
                              body: "Event Added to Calendar",
                              payload: _notecontroller.text);
                          _eventcontroller.clear();
                          _notecontroller.clear();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff237ACC), // Button color
                          onPrimary: Colors.white, // Text color
                        ),
                      ),

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
                /*  SizedBox(
                  height: 40.0,
                ),
                Text('Selected : ' + today.toString()),*/

                SizedBox(
                  height: 10.0,
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

                ///holdiday
                Flexible(
                  fit: FlexFit.loose,
                  child: ValueListenableBuilder<List<Holidays>>(
                    valueListenable: _holidayss,
                    builder: (context, value, _) {
                      return Container(
                        height: 80,
                        child: ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                onTap: () => print(""),
                                title: Text(
                                  '${value[index].holidayname}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
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
                                color: Color(0xff237ACC),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                onTap: () => print(""),
                                title: Text(
                                  '${value[index].title}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${value[index].note}\nDate: ${value[index].strtdate}\n'
                                  'Start : ${value[index].strtime.hour}:${value[index].strtime.minute} \nEnd : ${value[index].entime.hour}:${value[index].strtime.minute}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  maxLines:
                                      4, // Limit subtitle lines to avoid overflow
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                ///holiday
              ],
            ),
          ),
        ),
      ),
    );
  }
}
