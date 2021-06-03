import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class FirestoreDatabaseService {
  String retrieveNotes(int index, AsyncSnapshot<QuerySnapshot> snapshot);

  void createNote(String noteContentText);
}

class Database extends FirestoreDatabaseService {
  FirebaseFirestore db;

  Database({this.db});

  String userUid;

  @override
  void createNote(String data) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('notes');
      await collectionReference.add({'content': data});
    } catch (e) {
      print(e);
    }
  }

  @override
  String retrieveNotes(int index, AsyncSnapshot<QuerySnapshot> snapshot) {
    String data = snapshot.data.docs[index]['content'];
    if (data != null) {
      return data;
    } else {
      return '';
    }
  }
}
