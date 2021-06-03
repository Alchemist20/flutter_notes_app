import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Authentication {
  Future<void> logOut();

  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);
}

class AuthenticationService implements Authentication {
  final FirebaseAuth auth;

  AuthenticationService({this.auth});

  @override
  Future<void> logOut() async {
    await auth.signOut();
  }

  @override
  Future<String> signIn(String email, String password) async {
    try {
      if (!(email.isEmpty && password.isEmpty)) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        return 'Signed In';
      } else {
        return 'please enter credentials';
      }
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  @override
  Future<String> signUp(String email, String password) async {
    try {
      if (!(email.isEmpty && password.isEmpty)) {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        return 'please enter credentials';
      }
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
