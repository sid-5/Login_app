import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocks/auth_block.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<FirebaseUser> homeStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context,listen: false);
    homeStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Login())
        );
      }
      print(fbUser.photoUrl);
    });
    super.initState();
  }

  @override
  void dispose() {
    homeStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    print(authBloc.currentUser);
    return Scaffold(
        body: Center(
          child: StreamBuilder<FirebaseUser>(
              stream: authBloc.currentUser,
              builder:(context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                else return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data.displayName,style:TextStyle(fontSize: 35.0)),
                    SizedBox(height: 20.0,),
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.photoUrl), // + '?width=500&height500'),
                      radius: 60.0,
                    ),
                    SizedBox(height: 100.0,),
                    OutlineButton(
                      child:Text('SIGN OUT',
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),),
                        onPressed: () => {
                        authBloc.logout(),
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Signed off"),))},
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                    )
                  ],);
              }
          ),
        )
    );
  }
}