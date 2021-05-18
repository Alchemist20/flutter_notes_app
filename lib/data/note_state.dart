import 'package:flutter/widgets.dart';

class NoteState extends ChangeNotifier {
  List<String> notesList = ["First Note", "Second Note"];

  List<String> get getNotes => notesList;

  void onSave(String note) {
    notesList.add(note);
    notifyListeners();
  }
}