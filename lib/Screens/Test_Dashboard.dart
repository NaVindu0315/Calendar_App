import 'package:calendar_navindu/Calendar.dart';
import 'package:calendar_navindu/Screens/Calendar2.dart';
import 'package:calendar_navindu/Services/notifi_service.dart';
import 'package:flutter/material.dart';

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
                      NotificationService()
                          .showNotification(title: "sample", body: "pakpo");
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
