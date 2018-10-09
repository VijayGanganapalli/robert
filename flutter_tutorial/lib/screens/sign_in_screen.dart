import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import './home_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email, _password;

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
              ),
              validator: (input) {
                if (input.isEmpty) {
                  return "Please enter an email";
                }
              },
              onSaved: (input) => _email = input,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
              ),
              obscureText: true,
              validator: (input) {
                if (input.length < 6) {
                  return "Your password needs to be atleast 6 characters";
                }
              },
              onSaved: (input) => _password = input,
            ),
            RaisedButton(
              child: Text("Sign In"),
              onPressed: signIn,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth
          .instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
