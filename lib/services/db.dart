import 'dart:async';
import './globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class Document<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  DocumentReference ref;
  Document({this.path}) {
    ref = _db.doc(path);
  }
  Future<T> getData() {
    return ref.get().then((v) => Global.models[T](v.data) as T);
  }

  Stream<T> streamData() {
    return ref.snapshots().map((v) => Global.models[T](v.data) as T);
  }

  Future<void> upsert(Map data) {
    return ref.set(Map<String, dynamic>.from(data));
  }
}

class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.get();
    return snapshots.docs
        .map((doc) => Global.models[T](doc.data) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => Global.models[T](doc.data) as T));
  }
}

class UserData<T> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({this.collection});

  Stream<T> get documentStream {
    return _auth.authStateChanges().switchMap((user) {
      if (user != null) {
        Document<T> doc = Document<T>(
            path:
                'Schedule/geyFZGNWNAMDP7HbkXLS/$collection/6nqQ9gF4P8Kr2RToKwYS');
        return doc.streamData();
      } else {
        return Stream<T>.value(null);
      }
    });
  }

  Future<T> getDocument() async {
    User user = _auth.currentUser;

    if (user != null) {
      Document doc = Document<T>(
          path:
              'Schedule/geyFZGNWNAMDP7HbkXLS/$collection/6nqQ9gF4P8Kr2RToKwYS');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    User user = _auth.currentUser;
    Document<T> ref = Document(path: '$collection/${user.uid}');
    return ref.upsert(data);
  }
}
