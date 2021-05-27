import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/db//firestore_db.dart';
import 'package:flutter_notes/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notesProvider = Provider((ref) => NoteState());

class NotesList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('notes');
    return StreamBuilder(
        stream: ref.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snapshot.data.docs[index]['content'],
                        maxLines: 5,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
          );
        });
  }
}

class Home extends HookWidget {
  final auth = FirebaseAuth.instance;
  TextEditingController content = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final noteStateProvider = useProvider(notesProvider);
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
            controller: content,
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
                  onPressed: () {
                    // context.read(notesProvider).addData(content.text);
                    noteStateProvider.addData(content.text);
                    // addData();
                  },
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
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        backgroundColor: Colors.blue),
                  )),
            ],
          ),
          Expanded(child: NotesList()),
        ],
      ),
    );
  }
}
