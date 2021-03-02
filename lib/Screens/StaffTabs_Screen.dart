import 'package:flutter/material.dart';
import 'package:sign_in_flutter/Screens/Current_shifts_screen.dart';
import 'package:sign_in_flutter/Screens/StaffShifts_Screen.dart';
import '../shared/shared.dart';
import '../services/globals.dart';
import 'NewShift_Screen.dart';

class StaffTabsScreen extends StatelessWidget {
  final int currentweek;
  final String staffID;
  StaffTabsScreen(this.currentweek, this.staffID);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Staff Member'),
            bottom: TabBar(
              tabs: [
                Tab(text: currentWeek().toString()),
                Tab(text: (currentWeek() + 1).toString()),
                Tab(text: (currentWeek() + 2).toString())
              ],
            ),
          ),
          body: TabBarView(
            children: [
              new StaffScreen(currentWeek(), staffID),
              new StaffScreen(currentWeek() + 1, staffID),
              new StaffScreen(currentWeek() + 2, staffID),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NewShiftPage(staffID);
                  },
                ),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
          drawer: MyDrawer(),
        ),
      ),
    );
  }
}
