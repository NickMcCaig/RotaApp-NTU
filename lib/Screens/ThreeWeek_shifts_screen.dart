import 'package:flutter/material.dart';
import 'package:sign_in_flutter/Screens/Current_shifts_screen.dart';
import 'package:sign_in_flutter/shared/fabqr.dart';
import '../shared/shared.dart';
import '../services/globals.dart';

class ThreeWeeksShiftsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Shifts'),
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
              new CurrentShiftsScreen(currentWeek()),
              new CurrentShiftsScreen(currentWeek() + 1),
              new CurrentShiftsScreen(currentWeek() + 2),
            ],
          ),
          floatingActionButton: FabQR(),
          drawer: MyDrawer(),
        ),
      ),
    );
  }
}
