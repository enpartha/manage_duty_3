import 'package:flutter/material.dart';

import '../models/duty.dart';

class MyDuty with ChangeNotifier {
  static List<Duty> dutyItems = [
    Duty(
      dutyName: 'Morning',
      dutyAbbreviation: 'MG',
      dutyColor: Colors.lightBlueAccent,
      dutyStartTime: TimeOfDay(hour: 6, minute: 00),
      dutyEndTime: TimeOfDay(hour: 12, minute: 00),
    ),
    Duty(
      dutyName: 'Day',
      dutyColor: Colors.yellow,
      dutyStartTime: TimeOfDay(hour: 10, minute: 00),
      dutyEndTime: TimeOfDay(hour: 16, minute: 00),
    ),
    Duty(
      dutyName: 'Afternoon',
      // dutyColor: Colors.orange,
      dutyStartTime: TimeOfDay(hour: 12, minute: 00),
      dutyEndTime: TimeOfDay(hour: 20, minute: 00),
    ),
    Duty(
      dutyName: 'Night',
      dutyColor: Colors.purple,
      dutyStartTime: TimeOfDay(hour: 20, minute: 00),
      dutyEndTime: TimeOfDay(hour: 6, minute: 00),
    ),
    Duty(
      dutyName: 'Night Off',
      dutyColor: Colors.pinkAccent,
      dutyStartTime: TimeOfDay(hour: 20, minute: 00),
      dutyEndTime: TimeOfDay(hour: 06, minute: 00),
    ),
    Duty(
      dutyName: 'Day Off',
      dutyColor: Colors.redAccent,
      dutyStartTime: TimeOfDay(hour: 6, minute: 00),
      dutyEndTime: TimeOfDay(hour: 20, minute: 00),
    ),
    Duty(
      dutyName: 'Leave',
      dutyColor: Colors.green,
    ),
  ];
  // List<Duty> get items {
  //   return [..._items];
  // }

  // void addProduct(value) {
  //   _items.add(value);
  //   notifyListeners();
  // }
}
