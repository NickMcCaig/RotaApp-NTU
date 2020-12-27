import 'package:flutter/material.dart';
import 'shared/shared.dart';
import 'services/globals.dart';

class QRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code scanner'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
