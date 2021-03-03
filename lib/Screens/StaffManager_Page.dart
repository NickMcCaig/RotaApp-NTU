import 'package:flutter/material.dart';
import 'package:sign_in_flutter/Screens/StaffShifts_Screen.dart';
import 'package:sign_in_flutter/Screens/StaffTabs_Screen.dart';
import 'package:sign_in_flutter/shared/manager/addmember.dart';
import '../services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Qrcode_Screen.dart';
import '../shared/drawer.dart';

class StaffManagerScreen extends StatelessWidget {
  final String storeID;
  StaffManagerScreen(this.storeID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FutureBuilder<QuerySnapshot>(
                future: staffdocs(storeID),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('loading');

                    case ConnectionState.waiting:
                      return LinearProgressIndicator();
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
                              return Center(
                                child: Card(
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return StaffTabsScreen(
                                                currentWeek(),
                                                documentSnapshot['ID']);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.person),
                                              Text(documentSnapshot["Name"]),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
      floatingActionButton: FabNewMember(),
      drawer: MyDrawer(),
    );
  }
}

Future<QuerySnapshot> staffdocs(String storeID) async {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  QuerySnapshot snapshot = await _db.collection("Store/$storeID/Staff").get();
  return snapshot;
}
