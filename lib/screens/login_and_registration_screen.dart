import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_notes/providers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'home_screen.dart';

class LoginScreen extends HookWidget {
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    final auth = useProvider(authenticationServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              // controller: emailController,
              onChanged: (value) {
                _email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter email', border: InputBorder.none),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              // controller: passwordController,
              onChanged: (value) {
                _password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Enter password', border: InputBorder.none),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    auth.signIn(_email.trim(), _password.trim()).then((value) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Home()));
                    });
                  },
                  child: Text('Log In')),
              ElevatedButton(
                  onPressed: () {
                    auth.signUp(_email.trim(), _password.trim()).then((value) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    });
                  },
                  child: Text('Register'))
            ],
          ),
        ],
      ),
    );
  }
}
