import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../screens/edit_duty_page.dart';
import '../providers/my_duty.dart';

class ViewDutiesPage extends StatefulWidget {
  static String? dutyId;
  static const routeName = '/view_duties';

  // static String? dutyId;
  const ViewDutiesPage({Key? key}) : super(key: key);

  @override
  _ViewDutiesPageState createState() => _ViewDutiesPageState();
}

class _ViewDutiesPageState extends State<ViewDutiesPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MyDuty>(context).fetchDuties().then((_) {
        print(MyDuty().items);
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshDuties(BuildContext context) async {
    await Provider.of<MyDuty>(context, listen: false).fetchDuties();
  }

  @override
  Widget build(BuildContext context) {
    final myDuties = Provider.of<MyDuty>(context).items;
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Duties"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => EditDutyPage()),
          // );
          ViewDutiesPage.dutyId = null;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditDutyPage()));
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshDuties(context),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : myDuties.isEmpty
                ? Center(
                    child: Text("No Duties"),
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
                          onTap: () {
                            Navigator.of(context).pushNamed('/view_duties',
                                arguments: myDuties[index].id);
                          },
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
                                    DateFormat('hh:mm aa').format(
                                        DateFormat.jm().parse(myDuties[index]
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
                                  onSelected: (value) async {
                                    ViewDutiesPage.dutyId = myDuties[index].id;
                                    if (value == 'Edit') {
                                      Navigator.of(context).pushNamed(
                                          EditDutyPage.routeName,
                                          arguments: myDuties[index].id);
                                    } else if (value == 'Delete') {
                                      try {
                                        await Provider.of<MyDuty>(context,
                                                listen: false)
                                            .deleteDuty(ViewDutiesPage.dutyId);
                                      } catch (error) {
                                        scaffold.showSnackBar(SnackBar(
                                            content: Text("Deleting Falied!")));
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
