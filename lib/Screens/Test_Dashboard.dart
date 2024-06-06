import 'package:calendar_navindu/Calendar.dart';
import 'package:calendar_navindu/Screens/Calendar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Test_Dashboard extends StatelessWidget {
  const Test_Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash_Screen(),
    );
  }
}

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isNotificationInitialized = false;
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin
        .initialize(initializationSettings)
        .then((_) {
      setState(() {
        isNotificationInitialized = true;
      });
      print('Notification Plugin initialized');
    }).catchError((error) {
      print('Error initializing Notification Plugin: $error');
    });
  }

  Future<void> _sendNotification() async {
    if (!isNotificationInitialized) {
      print('Notification Plugin is not initialized');
      return;
    }

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max, priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Spacer(),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Calendar_Widget()),
                      );
                    },
                    child: Text('Calendar App')),
                ElevatedButton(
                    onPressed: () {
                      _sendNotification();
                    },
                    child: Text('Notification Test')),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
