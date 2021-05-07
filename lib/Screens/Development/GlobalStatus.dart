import 'package:flutter/material.dart';
import '../../shared/shared.dart';
import '../../services/globals.dart';
import '../Qrcode_Screen.dart';

class GlobalStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Globals Stats <Dev>'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('currentWeek'),
                    ),
                    Expanded(
                      child: Text(currentWeek().toString()),
                    )
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Current Store ID'),
                    ),
                    Expanded(
                      child: Text(currentStoreID.toString()),
                    )
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('currentTime'),
                    ),
                    Expanded(
                      child: Text(currentTime().toString()),
                    )
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('currentDay'),
                    ),
                    Expanded(
                      child: Text(currentDay().toString()),
                    )
                  ],
                ),
              )
            ],
          ),
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
      drawer: MyDrawer(),
    );
  }
}
