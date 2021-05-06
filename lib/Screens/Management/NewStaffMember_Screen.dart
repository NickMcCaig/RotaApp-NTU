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
import '../../shared/shared.dart';
import '../../services/globals.dart';
import '../Qrcode_Screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class NewStaffMemberScreen extends StatefulWidget {
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<NewStaffMemberScreen> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  bool isManager = false;
  bool isAdmin = false;
  String newid = '';
  String nickName = '';
  String phoneNumber = '';
  double payperhr = 0.0;
  final uidControler = TextEditingController();
  final nicknameController = TextEditingController();
  Future<void> scanQRCode() async {
    String qrCodescn = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    setState(() {
      uidControler.text = qrCodescn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Staff Member'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: new Text('Enter Staff Details'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Nickname'),
                            controller: nicknameController,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Contract Hours'),
                          ),
                          Row(
                            children: <Widget>[
                              Text('Manager'),
                              Switch(
                                  value: isManager,
                                  onChanged: (value) {
                                    setState(() {
                                      isManager = value;
                                    });
                                  })
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('Admin'),
                              Switch(
                                  value: isAdmin,
                                  onChanged: (value) {
                                    setState(() {
                                      isAdmin = value;
                                    });
                                  })
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.phone),
                              Flexible(
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Phone'),
                                ),
                              )
                            ],
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Pay'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('UID'),
                      content: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.qr_code),
                                color: Colors.blueGrey,
                                onPressed: () {
                                  scanQRCode();
                                },
                              ),
                              Flexible(
                                child: TextFormField(
                                  controller: uidControler,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('Confirm'),
                      content: Column(
                        children: <Widget>[
                          Text('You are about to add the following person'),
                          Row(
                            children: [
                              Text('Name: ' + nicknameController.text),
                            ],
                          )
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
