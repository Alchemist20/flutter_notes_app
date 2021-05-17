import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_notes/models/note.dart';

final notesProvider = ChangeNotifierProvider<Note>((ref) {
  return Note();
});

class NotesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notesWatcher = watch(notesProvider);
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, int index) {
          print(notesWatcher.notesList[index]);
          return Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(notesWatcher.notesList[index],
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
        itemCount: notesWatcher.notesList.length,
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: notes,
            decoration: InputDecoration(
              // border: InputBorder.none,
                hintText: 'Enter note',
                hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          ElevatedButton(
              onPressed: () => context.read(notesProvider).onSave(notes.text),
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    backgroundColor: Colors.blue),
              )),
          NotesList(),
        ],
      ),
    );
  }
}
