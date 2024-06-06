/*class Eventss {
  final String title;
  Eventss(this.title);
}*/

import 'package:flutter/material.dart';

class Eventss {
  final String title;
  final String note;
  final DateTime strtdate;
  final TimeOfDay strtime;
  final TimeOfDay entime;
  Eventss(this.title, this.note, this.strtdate, this.strtime, this.entime);
}
