import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manage_duty_3/models/http_exception.dart';

import '../models/duty.dart';
import 'package:http/http.dart' as http;

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

  final url =
      Uri.https('manage-duty-default-rtdb.firebaseio.com', '/duties.json');
  List<Duty> get items {
    return [..._dutyItems];
  }

  Duty findById(String id) {
    return _dutyItems.firstWhere((duty) => duty.id == id);
  }

  Future<void> fetchDuties() async {
    try {
      final response = await http.get(url);
      final decodedJSON = jsonDecode(response.body);

      final extractedData =
          decodedJSON != null ? decodedJSON as Map<String, dynamic> : {};
      final List<Duty> loadedDuty = [];
      extractedData.forEach((dutyId, dutyData) {
        loadedDuty.add(
          Duty(
              id: dutyId,
              dutyName: dutyData['name'],
              dutyAbbreviation: dutyData['abbreviation'],
              dutyColor: dutyData['color'],
              dutyStartTime: dutyData['startTime'],
              dutyEndTime: dutyData['endTime']),
        );
      });

      _dutyItems = loadedDuty;
    } catch (error) {
      print(error);
    }
  }

  Future<void> addDuty(duty) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': duty.dutyName,
          'abbreviation': duty.dutyAbbreviation,
          'color': duty.dutyColor,
          'startTime': duty.dutyStartTime,
          'endTime': duty.dutyEndTime
        }),
      );
      final newDuty = Duty(
        dutyName: duty.dutyName,
        dutyAbbreviation: duty.dutyAbbreviation,
        dutyColor: duty.dutyColor,
        dutyStartTime: duty.dutyStartTime,
        dutyEndTime: duty.dutyEndTime,
        id: json.decode(response.body)['name'],
      );

      _dutyItems.add(newDuty);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateDuty(id, Duty duty) async {
    final dutyIndex = _dutyItems.indexWhere((element) => element.id == id);
    if (dutyIndex >= 0) {
      final _url = Uri.https(
          'manage-duty-default-rtdb.firebaseio.com', '/duties/$id.json');
      http.patch(_url,
          body: json.encode({
            'name': duty.dutyName,
            'abbreviation': duty.dutyAbbreviation,
            'color': duty.dutyColor,
            'startTime': duty.dutyStartTime,
            'endTime': duty.dutyEndTime
          }));
      _dutyItems[dutyIndex] = duty;
      _dutyItems[dutyIndex].id = id;

      notifyListeners();
    }
  }

  Future<void> deleteDuty(id) async {
    final _url = Uri.https(
        'manage-duty-default-rtdb.firebaseio.com', '/duties/$id.json');
    final existingGroupIndex =
        _dutyItems.indexWhere((element) => element.id == id);
    var existingGroup = _dutyItems[existingGroupIndex];
    notifyListeners();
    final respose = await http.delete(_url);
    if (respose.statusCode >= 400) {
      _dutyItems.insert(existingGroupIndex, existingGroup);
      notifyListeners();
      throw HttpException("Could not delete");
    }

    existingGroup = Duty(dutyName: '', id: '');
    // _dutyItems.removeWhere((element) => element.id == id);
    print('deleted');
    notifyListeners();
  }
}
