import 'package:flutter/material.dart';

import '../models/duty.dart';

class MyDuty with ChangeNotifier {
  static List<Duty> _dutyItems = [
    Duty(
      id: '1',
      dutyName: 'Morning',
      dutyAbbreviation: 'MG',
      dutyColor: Colors.lightBlueAccent,
      dutyStartTime: TimeOfDay(hour: 6, minute: 00),
      dutyEndTime: TimeOfDay(hour: 12, minute: 00),
    ),
    Duty(
      id: '2',
      dutyName: 'Day',
      dutyColor: Colors.yellow,
      dutyStartTime: TimeOfDay(hour: 10, minute: 00),
      dutyEndTime: TimeOfDay(hour: 16, minute: 00),
    ),
    Duty(
      id: '3',
      dutyName: 'Afternoon',
      // dutyColor: Colors.orange,
      dutyStartTime: TimeOfDay(hour: 12, minute: 00),
      dutyEndTime: TimeOfDay(hour: 20, minute: 00),
    ),
    Duty(
      id: '4',
      dutyName: 'Night',
      dutyColor: Colors.purple,
      dutyStartTime: TimeOfDay(hour: 20, minute: 00),
      dutyEndTime: TimeOfDay(hour: 6, minute: 00),
    ),
    Duty(
      id: '5',
      dutyName: 'Night Off',
      dutyColor: Colors.pinkAccent,
      dutyStartTime: TimeOfDay(hour: 20, minute: 00),
      dutyEndTime: TimeOfDay(hour: 06, minute: 00),
    ),
    Duty(
      id: '6',
      dutyName: 'Day Off',
      dutyColor: Colors.redAccent,
      dutyStartTime: TimeOfDay(hour: 6, minute: 00),
      dutyEndTime: TimeOfDay(hour: 20, minute: 00),
    ),
    Duty(
      id: '7',
      dutyName: 'Leave',
      dutyColor: Colors.green,
    ),
  ];
  List<Duty> get items {
    return [..._dutyItems];
  }

  Duty findById(String id) {
    return _dutyItems.firstWhere((duty) => duty.id == id);
  }

  void addDuty(duty) {
    final newDuty = Duty(
      dutyName: duty.dutyName,
      dutyAbbreviation: duty.dutyAbbreviation,
      dutyColor: duty.dutyColor,
      dutyStartTime: duty.dutyStartTime,
      dutyEndTime: duty.dutyEndTime,
      id: DateTime.now().toString(),
    );

    _dutyItems.add(newDuty);
    notifyListeners();
  }

  void updateDuty(id, Duty duty) {
    final dutyIndex = _dutyItems.indexWhere((element) => element.id == id);
    if (dutyIndex >= 0) {
      _dutyItems[dutyIndex] = duty;

      notifyListeners();
    }
  }

  void deleteDuty(id) {
    _dutyItems.removeWhere((element) => element.id == id);
    print('deleted');
    notifyListeners();
  }
}
