import 'package:flutter/material.dart';
import 'package:sign_in_flutter/Screens/Management/NewStaffMember_Screen.dart';

class FabNewMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewStaffMemberScreen();
            },
          ),
        );
      },
      child: Icon(Icons.emoji_people),
      backgroundColor: Colors.green,
    );
  }
}
