import 'package:flutter/cupertino.dart';

class NoteState with ChangeNotifier {
  List<String> _notesList = ['First Note','Second note'];
  List<String> get getNotes => _notesList;
  void addNote(String note) {
    _notesList.add(note);
    notifyListeners();
  }
}