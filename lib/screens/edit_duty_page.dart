import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDutyPage extends StatefulWidget {
  static const routeName = '/edit_duty';
  const EditDutyPage({Key? key}) : super(key: key);

  @override
  _EditDutyPageState createState() => _EditDutyPageState();
}

class _EditDutyPageState extends State<EditDutyPage> {
  TextEditingController abb = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController timeinput2 = TextEditingController();
  int _selectedColor = 0;
  int _selectedButton = 0;

  final List colors = [
    Color(0xFFEF9A9A),
    Colors.blue,
    Colors.green,
    Colors.yellow[600],
    Colors.orange,
    Colors.pink,
    Colors.red,
    Colors.brown,
    Colors.purple,
    Colors.black
  ];

  List<String> workType = ["work", "off", "vac", "half"];

  @override
  void initState() {
    timeinput.text = "";
    timeinput2.text = "";
    super.initState();
  }

  @override
  void dispose() {
    abb.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Duty"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Container(
                  height: double.infinity,
                  child: Icon(Icons.edit),
                ),
                title: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Duty Name", border: InputBorder.none),
                ),
                trailing: Container(
                  height: 40.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: colors[_selectedColor],
                  ),
                  child: Center(
                    child: Text(
                      abb.text.isEmpty ? 'DUTY' : abb.text.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = index;
                        });
                      },
                      child: Container(
                        margin: _selectedColor == index
                            ? EdgeInsets.fromLTRB(3, 0, 3, 0)
                            : EdgeInsets.fromLTRB(6, 5, 6, 5),
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: _selectedColor == index
                                  ? colors[index]
                                  : Colors.transparent,
                              width: 4),
                          color: colors[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                height: 30,
                indent: 10,
                thickness: 1,
              ),
              ListTile(
                leading: Container(
                  height: double.infinity,
                  child: Icon(Icons.edit),
                ),
                title: TextFormField(
                  controller: abb,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      labelText: "ABBREVIATION", border: InputBorder.none),
                ),
              ),
              Divider(
                height: 30,
                indent: 10,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.merge_type_outlined),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Type",
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: workType.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _selectedButton = index;
                            });
                          },
                          child: Text(workType[index]),
                          color: _selectedButton == index
                              ? Colors.blue
                              : Colors.white,
                          textColor: _selectedButton == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      );
                    }),
              ),
              Divider(
                height: 30,
                indent: 10,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.timer),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Schedule",
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    child: GestureDetector(
                      child: Builder(builder: (context) {
                        return TextFormField(
                          controller: timeinput,
                          // initialValue:  ,

                          decoration: InputDecoration(
                              labelText: "START TIME",
                              border: InputBorder.none),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              print(pickedTime.format(context));
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              print(parsedTime);
                              String formattedTime =
                                  DateFormat('hh:mm aa').format(parsedTime);
                              print(formattedTime);
                              setState(() {
                                timeinput.text = formattedTime;
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        );
                      }),
                    ),
                  ),
                  Text(
                    ">",
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    width: 80,
                    child: GestureDetector(
                      child: Builder(builder: (context) {
                        return TextFormField(
                          // initialValue: ,
                          controller: timeinput2,
                          decoration: InputDecoration(
                              labelText: "END TIME",
                              // hintText: "Time",
                              border: InputBorder.none),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              print(pickedTime.format(context));
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              print(parsedTime);
                              String formattedTime =
                                  DateFormat('hh:mm aa').format(parsedTime);
                              print(formattedTime);
                              setState(() {
                                timeinput2.text = formattedTime;
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
