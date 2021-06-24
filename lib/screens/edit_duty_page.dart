import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manage_duty_3/models/duty.dart';
import 'package:manage_duty_3/providers/my_duty.dart';
import 'package:manage_duty_3/screens/view_duties.dart';
import 'package:provider/provider.dart';

class EditDutyPage extends StatefulWidget {
  static const routeName = '/edit_duty';

  final String? dutyId = ViewDutiesPage.dutyId;

  EditDutyPage({
    Key? key,
    //this.dutyId
  }) : super(key: key);

  @override
  _EditDutyPageState createState() => _EditDutyPageState();
}

class _EditDutyPageState extends State<EditDutyPage> {
  TextEditingController _dutyname = TextEditingController();
  TextEditingController _abb = TextEditingController();
  TextEditingController _timeinput = TextEditingController();
  TextEditingController _timeinput2 = TextEditingController();
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
  final _formKey = GlobalKey<FormState>();
  var _editedDuty = Duty(
    id: EditDutyPage().dutyId,
    dutyName: '',
    dutyAbbreviation: '',
    dutyColor: Colors.lightBlue,
    dutyStartTime: TimeOfDay(hour: 8, minute: 00),
    dutyEndTime: TimeOfDay(hour: 2, minute: 00),
  );
  var _initValues = {
    'name': '',
    'abbreviation': '',
    'color': Colors.lightBlue,
    'startTime': TimeOfDay(hour: 8, minute: 00),
    'endTime': TimeOfDay(hour: 2, minute: 00),
  };

  var _isInit = true;

  @override
  void initState() {
    _timeinput.text = "";
    _timeinput2.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _abb.dispose();
    _dutyname.dispose();
    _timeinput.dispose();
    _timeinput2.dispose();
    super.dispose();
  }

  @override
  // ignore: override_on_non_overriding_member
  void didChangeDependecies() {
    print(EditDutyPage().dutyId);
    if (_isInit) {
      final id = ModalRoute.of(context)?.settings.arguments as String?;
      if (id != null) {
        _editedDuty = Provider.of<MyDuty>(context, listen: false).findById(id);
        print(_editedDuty.id);
        _initValues = {
          'name': _editedDuty.dutyName.toString(),
          'abbreviation': _editedDuty.dutyAbbreviation.toString(),
          'color': Colors.lightBlue,
          'startTime': _editedDuty.dutyStartTime,
          'endTime': _editedDuty.dutyEndTime,
        };
        _dutyname.text = _initValues['name'].toString();
        _abb.text = _initValues['abbreviation'].toString();

        _isInit = false;
      }

      super.didChangeDependencies();
    }
  }

  void _saveForm() {
    final id = EditDutyPage().dutyId;
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    if (id != null) {
      Provider.of<MyDuty>(context, listen: false).updateDuty(id, _editedDuty);
    } else {
      Provider.of<MyDuty>(context, listen: false).addDuty(_editedDuty);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Edit Duty"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Container(
                    height: double.infinity,
                    child: Icon(Icons.edit),
                  ),
                  title: TextFormField(
                    controller: _dutyname,
                    decoration: InputDecoration(
                        labelText: "Duty Name", border: InputBorder.none),
                    onSaved: (value) {
                      _editedDuty = Duty(
                        dutyName: value.toString(),
                        dutyAbbreviation: value.toString(),
                        dutyColor: Colors.blue,
                        dutyStartTime: TimeOfDay(hour: 8, minute: 00),
                        dutyEndTime: TimeOfDay(hour: 2, minute: 00),
                      );
                    },
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
                        _abb.text.isEmpty ? 'DUTY' : _abb.text.toString(),
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
                    controller: _abb,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        labelText: "ABBREVIATION", border: InputBorder.none),
                    onSaved: (value) {
                      _editedDuty = Duty(
                        dutyName: value.toString(),
                        dutyAbbreviation: value.toString(),
                        dutyColor: Colors.blue,
                        dutyStartTime: TimeOfDay(hour: 8, minute: 00),
                        dutyEndTime: TimeOfDay(hour: 2, minute: 00),
                      );
                    },
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
                            controller: _timeinput,
                            // initialValue:  ,

                            decoration: InputDecoration(
                                labelText: "START TIME",
                                border: InputBorder.none),
                            onSaved: (value) {
                              _editedDuty = Duty(
                                dutyName: value.toString(),
                                dutyAbbreviation: value.toString(),
                                dutyColor: Colors.blue,
                                dutyStartTime: TimeOfDay(hour: 8, minute: 00),
                                dutyEndTime: TimeOfDay(hour: 2, minute: 00),
                              );
                            },
                            readOnly: true,
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                print(pickedTime.format(context));
                                DateTime parsedTime = DateFormat.jm().parse(
                                    pickedTime.format(context).toString());
                                print(parsedTime);
                                String formattedTime =
                                    DateFormat('hh:mm aa').format(parsedTime);
                                print(formattedTime);
                                setState(() {
                                  _timeinput.text = formattedTime;
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
                            controller: _timeinput2,
                            decoration: InputDecoration(
                                labelText: "END TIME",
                                // hintText: "Time",
                                border: InputBorder.none),
                            onSaved: (value) {
                              _editedDuty = Duty(
                                dutyName: value.toString(),
                                dutyAbbreviation: value.toString(),
                                dutyColor: Colors.blue,
                                dutyStartTime: TimeOfDay(hour: 8, minute: 00),
                                dutyEndTime: TimeOfDay(hour: 2, minute: 00),
                              );
                            },
                            readOnly: true,
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                print(pickedTime.format(context));
                                DateTime parsedTime = DateFormat.jm().parse(
                                    pickedTime.format(context).toString());
                                print(parsedTime);
                                String formattedTime =
                                    DateFormat('hh:mm aa').format(parsedTime);
                                print(formattedTime);
                                setState(() {
                                  _timeinput2.text = formattedTime;
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
      ),
    );
  }
}
