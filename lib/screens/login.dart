import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocks/auth_block.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  StreamSubscription<FirebaseUser> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context,listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home())
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Container(
        color: Colors.blue[32],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 30),
              SignInButton(
                Buttons.Facebook,
                onPressed: () => authBloc.loginFacebook(),
              ),
              SignInButton(
                Buttons.Google,
                elevation: 0.0,
                onPressed: () => authBloc.loginGoogle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
