import 'package:flutter/material.dart';

class Duty with ChangeNotifier {
  final String dutyName;
  String dutyAbbreviation;
  Color dutyColor;
  TimeOfDay dutyStartTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay dutyEndTime = TimeOfDay(hour: 23, minute: 59);
  bool onDuty;
  bool isLeave;
  String? id;

  Duty({
    required this.dutyName,
    this.dutyColor = Colors.grey,
    String dutyAbbreviation = '',
    this.onDuty = true,
    this.isLeave = false,
    TimeOfDay? dutyStartTime,
    TimeOfDay? dutyEndTime,
    this.id,
  })  : dutyAbbreviation = dutyAbbreviation.isEmpty
            ? '${dutyName.toUpperCase()[0]}' + '${dutyName.toUpperCase()[1]}'
            : dutyAbbreviation,
        dutyStartTime = isLeave
            ? TimeOfDay(hour: 00, minute: 00)
            : TimeOfDay(hour: 12, minute: 0),
        dutyEndTime = isLeave
            ? TimeOfDay(hour: 24, minute: 00)
            : TimeOfDay(hour: 18, minute: 0);
}
