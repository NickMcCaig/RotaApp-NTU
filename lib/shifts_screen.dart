import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sign_in_flutter/login_page.dart';
import './shared/shared.dart';
import './services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Qrcode_Screen.dart';

class ShiftsScreen extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifts'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: _db
                    .collection("Schedule/geyFZGNWNAMDP7HbkXLS/Shifts")
                    .where('StaffID', isEqualTo: user.uid)
                    .orderBy('StartDay')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.documents[index];
                          String timedatestr = getdayString(
                              documentSnapshot["StartDay"],
                              documentSnapshot["EndDay"]);
                          String times =
                              documentSnapshot['StartTime'].toString() +
                                  ' - ' +
                                  documentSnapshot['EndTime'].toString();
                          return Card(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(documentSnapshot["Role"]),
                                ),
                                Expanded(
                                  child: Text(timedatestr),
                                ),
                                Expanded(
                                  child: Text(times),
                                ),
                                Expanded(
                                  child: Text('<Date>'),
                                )
                              ],
                            ),
                          );
                        });
                  } else {
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return QRCodePage();
              },
            ),
          );
        },
        child: Icon(Icons.alarm_add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

String getdayString(int startDay, int endDay) {
  if (startDay == endDay) {
    return dayMap[startDay];
  } else {
    return dayMap[startDay] + dayMap[endDay];
  }
}

String GetTimeString(int startTime, int endTime) {
  return startTime.toString() + " - " + endTime.toString();
}
