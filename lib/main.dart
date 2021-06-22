import 'package:flutter/material.dart';
import 'package:manage_duty_3/providers/my_duty.dart';
import 'package:manage_duty_3/screens/view_duties.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: MyDuty(),
      ),
    ], child: ViewDutiesPage());
  }
}
