import 'package:flutter/material.dart';
import 'package:sign_in_flutter/Screens/Qrcode_Screen.dart';

class FabQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
}
