import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/edit_duty_page.dart';

import '../providers/my_duty.dart';
import '../models/duty.dart';

class ViewDutiesPage extends StatelessWidget {
  static const routeName = '/view_duties';

  static String? dutyId;
  const ViewDutiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Duty> myDuties = MyDuty().items;
    MultiProvider(providers: [ChangeNotifierProvider.value(value: MyDuty())]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Duties"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditDutyPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: myDuties.isEmpty
          ? Center(
              child: Text('No Duties'),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: myDuties.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 5,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: <ListTile>[
                        ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: myDuties[index].dutyColor,
                            ),

                            // height: 30,
                            width: 60,
                            child: Center(
                              child: Text(
                                myDuties[index].dutyAbbreviation,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          title: Text(myDuties[index].dutyName),
                          subtitle: Text(DateFormat('hh:mm aa').format(
                                  DateFormat.jm().parse(myDuties[index]
                                      .dutyStartTime
                                      .format(context)
                                      .toString())) +
                              ' to ' +
                              DateFormat('hh:mm aa').format(DateFormat.jm()
                                  .parse(myDuties[index]
                                      .dutyEndTime
                                      .format(context)
                                      .toString()))),
                          trailing: PopupMenuButton(
                            offset: Offset(0, -40),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'Edit',
                                child: Text(
                                  'Edit',
                                ),
                              ),
                              PopupMenuItem(
                                value: 'Delete',
                                child: Text(
                                  'Delete',
                                ),
                              ),
                            ],
                            onSelected: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
