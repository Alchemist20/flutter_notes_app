import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NoteState {
  final database = FirebaseFirestore.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  addData(String data) {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('notes');
    collectionReference.add({'content': data});
  }
  // List<String> _notesList = ['First Note','Second note'];
  // List<String> get getNotes => _notesList;
  // void addNote(String note) {
  //   _notesList.add(note);
  //   notifyListeners();
  // }
}