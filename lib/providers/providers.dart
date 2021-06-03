import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_notes/services/authentication_service.dart';
import 'package:flutter_notes/services/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final authStateChangesProvider = StreamProvider.autoDispose<User>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final authenticationServiceProvider = Provider<Authentication>((ref) {
  return AuthenticationService(auth: ref.watch(firebaseAuthProvider));
});

final firebaseFirestoreServiceProvider =
    Provider<FirestoreDatabaseService>((ref) {
  return Database(db: ref.watch(firebaseFirestoreProvider));
});
