import 'package:flutter/widgets.dart';

class Note extends ChangeNotifier {
  List notesList = ["First Note", "Second Note"];
  void onSave(String note) {
    notesList.add(note);
    notifyListeners();
  }
}