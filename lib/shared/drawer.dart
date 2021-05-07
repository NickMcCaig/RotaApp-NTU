import 'package:flutter/material.dart';
import 'package:sign_in_flutter/Screens/Management/NewShift_Screen.dart';
import 'package:sign_in_flutter/Screens/Management/NewStaffMember_Screen.dart';
import 'package:sign_in_flutter/Screens/ThreeWeek_shifts_screen.dart';
import '../Screens/Management/StaffManager_Page.dart';
import '../Screens/Development/GlobalStatus.dart';
import '../services/globals.dart';
import '../Screens/Profile_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Hi ' + user.displayName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
            leading: Icon(Icons.message),
            title: Text('Shifts'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ThreeWeeksShiftsScreen();
                  },
                ),
              );
            }),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
                      onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                ),
              );
                      }
        ),
        ListTile(
            leading: Icon(Icons.people),
            title: Text('Staff'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return StaffManagerScreen(currentStoreID);
                  },
                ),
              );
            }),
        ListTile(
            leading: Icon(Icons.emoji_people),
            title: Text('Add new staff member'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NewStaffMemberScreen();
                  },
                ),
              );
            }),
        
        ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return GlobalStatsScreen();
                  },
                ),
              );
            }),
      ],
    ));
  }
}
