import 'package:calendar_navindu/Calendar.dart';
import 'package:calendar_navindu/Screens/Calendar2.dart';
import 'package:calendar_navindu/Screens/Splash_Screen.dart';
import 'package:calendar_navindu/Screens/Test_Dashboard.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

/*void main() {
  runApp(SplashScreen());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SplashScreen());
}
