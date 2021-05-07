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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sign_in_flutter/services/globals.dart';
import 'package:sign_in_flutter/shared/fabqr.dart';
import '../shared/shared.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String code = "B";
  @override
  Widget build(BuildContext context) {
    CollectionReference userref =
        FirebaseFirestore.instance.collection('Store/$currentStoreID/Staff');
    return FutureBuilder<DocumentSnapshot>(
        future: userref.doc('eGVyHck8SxQSm33BUFtxWLWw1rh2').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Hello " + data['Name']),
                                  
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("You currently earn: " + data['pay/h'].toString() + ' per hour')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Phone Number: " + data['PhoneNumber'].toString())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "Manager Status: " + data['Manager'].toString())
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              "Admin Status: " + data['Admin'].toString())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: FabQR(),
              drawer: MyDrawer(),
            );
          }
          return Text("loading");
        });
  }
}
