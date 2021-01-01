import 'package:flutter/material.dart';
import '../services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Qrcode_Screen.dart';
import '../shared/drawer.dart';

class CurrentShiftsScreen extends StatelessWidget {
  final int currentweek;
  CurrentShiftsScreen(this.currentweek);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
                future: weekdocs(currentweek),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('loading');

                    case ConnectionState.waiting:
                      return Text('Awaiting result...');
                      break;
                    case ConnectionState.active:
                      break;
                    case ConnectionState.done:
                      if (!snapshot.hasError) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data.docs[index];
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
                        return Text('Error: ${snapshot.error}');
                      }
                      break;
                  }
                  return null;
                })
          ],
        ),
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

String getTimeString(int startTime, int endTime) {
  return startTime.toString() + " - " + endTime.toString();
}

Future<QuerySnapshot> weekdocs(int currentweek) async {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String docid = await getWeekDoc(currentweek);
  QuerySnapshot snapshot = await _db
      .collection("Schedule/$docid/Shifts")
      .where('StaffID', isEqualTo: user.uid)
      .orderBy('StartDay')
      .get();
  return snapshot;
}
