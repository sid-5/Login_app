import 'package:flutter/material.dart';
import 'package:flutter_app/blocks/auth_block.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: "LOGIN",
        home: Login(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}




