import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class QRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock tool'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[MyCustomForm()],
          ),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  ClockFormState createState() {
    return ClockFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ClockFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final checkCodeControler = TextEditingController();
  Future<void> scanQRCode() async {
    String qrCodescn = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    setState(() {
      checkCodeControler.text = qrCodescn;
    });
  }

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
              IconButton(
                icon: Icon(Icons.qr_code),
                color: Colors.blueGrey,
                onPressed: () => scanQRCode(),
              ),
              Flexible(
                child: TextFormField(
                  controller: checkCodeControler,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your code';
                    } else if (value.length != 5) {
                      return 'Please enter the correct length code';
                    }
                    return null;
                  },
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
                        await clockFunc(true, checkCodeControler.text, context);
                      }
                    },
                    child: Text('IN'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await clockFunc(
                            false, checkCodeControler.text, context);
                      }
                    },
                    child: Text('OUT'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<Void> clockFunc(
    bool clkin, String checkCode, BuildContext context) async {
  String currentweekdoc = await getWeekDoc(currentWeek());
  String stOrEndDay;
  String stOrEndTime;
  String stOrEndClk;
  if (clkin == true) {
    stOrEndClk = 'StartClock';
    stOrEndDay = 'StartDay';
    stOrEndTime = 'StartTime';
  } else {
    stOrEndClk = 'EndClock';
    stOrEndDay = 'EndDay';
    stOrEndTime = 'EndTime';
  }
  DocumentSnapshot codesc = await db.doc('CheckCodes/$currentStoreID').get();
  String servCode = codesc['CheckCode'].toString();
  if (servCode == checkCode) {
    QuerySnapshot querySnapshot = await db
        .collection('Schedule/$currentweekdoc/Shifts')
        .where('StaffID', isEqualTo: user.uid)
        .where(stOrEndDay, isEqualTo: currentDay())
        .where(stOrEndTime, isGreaterThanOrEqualTo: currentTime() - 5)
        .where(stOrEndTime, isLessThanOrEqualTo: currentTime() + 5)
        .get();
    querySnapshot.docs.forEach((doc) async {
      doc.reference.update(<String, dynamic>{stOrEndClk: true});
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('You have clocked for your shift')));
    });
  } else {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('The CheckCode is incorrect.')));
  }
  return null;
}
