import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import './providers/my_duty.dart';
import './screens/view_duties.dart';
import './screens/edit_duty_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MyDuty(),
        ),
      ],
      child: MaterialApp(
        home: ViewDutiesPage(),
        routes: {
          EditDutyPage.routeName: (ctx) => EditDutyPage(),
        },
      ),
    );
  }
}
