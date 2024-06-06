import 'package:calendar_navindu/Calendar.dart';
import 'package:calendar_navindu/Screens/Calendar2.dart';
import 'package:flutter/material.dart';

class Spl_Screen extends StatelessWidget {
  const Spl_Screen({Key? key}) : super(key: key);

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
