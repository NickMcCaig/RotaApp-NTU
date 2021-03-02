import 'dart:ffi';

import 'package:flutter/material.dart';
import '../services/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class NewShiftPage extends StatelessWidget {
  final String staffID;
  NewShiftPage(this.staffID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new shift'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[MyCustomForm(staffID)],
          ),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final String staffID;
  MyCustomForm(this.staffID);
  @override
  ClockFormState createState() {
    return ClockFormState(staffID);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ClockFormState extends State<MyCustomForm> {
  final String staffID;
  ClockFormState(this.staffID);
  //Staff ID needs passing throuh from StaffManager form
  String roleValue = 'Bar';
  String weekValue = '40';
  String startDay = 'Monday';
  String startTime = '1200';
  String endDay = 'Monday';
  String endTime = '1500';

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text('You are Createing a new shift for' + staffID)
            ], //TODO add user name insted of uid
          ),
          Row(
            children: [
              Text('Week:'),
              DropdownButton<String>(
                  value: weekValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items:
                      <String>['39', '40', '41', '42'] //TODO Implement numbers
                          .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      weekValue = newValue;
                    });
                  }),
            ],
          ),
          Row(
            children: [
              Text('Role :'),
              DropdownButton<String>(
                  value: roleValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: <String>[
                    'Kitchen',
                    'Bar',
                    'Management',
                    'Cleaning'
                  ] //Role values need selecting from Store/$id/Roles/
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      roleValue = newValue;
                    });
                  }),
            ],
          ),
          Row(
            children: [
              Text('Start:'),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text('Day: '),
              DropdownButton<String>(
                  value: startDay,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      startDay = newValue;
                    });
                  }),
              Text('Time: '),
              Flexible(
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'EndTime',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('End:'),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text('Day: '),
              DropdownButton<String>(
                  value: endDay,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      endDay = newValue;
                    });
                  }),
              Text('Time: '),
              Flexible(
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'EndTime',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await newShiftFunc(
                            staffID,
                            weekValue,
                            currentStoreID,
                            roleValue,
                            startDay,
                            startTime,
                            endDay,
                            endTime,
                            context);
                      }
                    },
                    child: Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}

Future<Void> newShiftFunc(
    String uid,
    String weekNumber,
    String storeId,
    String roleValue,
    String startDay,
    String startTime,
    String endDay,
    String endTime,
    BuildContext context) async {
  String weekdoc = await getWeekDoc(int.parse(weekNumber));
  CollectionReference shifts = db.collection('Schedule/$weekdoc/Shifts');
  var _daymap = {
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
    'Sunday': 7
  };
  //TODO add exeception if error
  shifts.add({
    'EndClock': false,
    'EndDay': _daymap[endDay],
    'EndTime': int.parse(endTime),
    'Late': false,
    'Role': roleValue,
    'StaffID': uid,
    'StartClock': false,
    'StartDay': _daymap[startDay],
    'StartTime': int.parse(startTime)
  });
  Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('You have added the shift to the schedule!')));
  return null;
}

bool timevalidator(String time) {
  //To be implimented
  return true;
}
