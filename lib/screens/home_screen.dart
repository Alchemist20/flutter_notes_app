import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_notes/data/note_state.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notesProvider = ChangeNotifierProvider((ref) => NoteState());

class NotesList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final NoteState notesList = useProvider(notesProvider);
    return ListView.builder(
      itemBuilder: (context, int index) {
        print(notesList.getNotes[index]);
        return Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(notesList.getNotes[index],
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
      itemCount: notesList.getNotes.length,
    );
  }
}

class Home extends HookWidget {
  final auth = FirebaseAuth.instance;
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
                  color: Colors.grey),
            ),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            ElevatedButton(
                onPressed: () => context.read(notesProvider).onSave(notes.text),
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      backgroundColor: Colors.blue),
                )),
            ElevatedButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Log out',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      backgroundColor: Colors.blue),
                )),
          ],),

          Expanded(child: NotesList()),
        ],
      ),
    );
  }
}
