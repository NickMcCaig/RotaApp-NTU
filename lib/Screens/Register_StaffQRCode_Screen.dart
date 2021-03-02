// Copyright (c) 2019 Souvik Biswas

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../shared/shared.dart';
import '../services/globals.dart';

class RegisterQrCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register QR code'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Welcome " + user.displayName + "!",
                style: TextStyle(fontSize: 40),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.photoURL,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              Divider(),
              QrImage(
                data: user.uid,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Text("Show this QR code", style: TextStyle(fontSize: 40)),
              Text(
                  "You need to show this QR code to your supervisor to finish registration."),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () async {
                  //stub
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Check',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                elevation: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
