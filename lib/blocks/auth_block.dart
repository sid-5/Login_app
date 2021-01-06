import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Stream<FirebaseUser> get currentUser => authService.currentUser;

  loginFacebook() async {
    print('Starting Facebook Login');
    final res = await fb.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email
        ]
    );

    switch(res.status){
      case FacebookLoginStatus.Success:
        print('It worked');

        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert to Auth Credential
        final AuthCredential credential
        = FacebookAuthProvider.getCredential(accessToken: fbToken.token);

        //User Credential to Sign in with Firebase
        final result = await authService.signInWithCredential(credential);

        print('${result.user.displayName} is now logged in');

        break;
      case FacebookLoginStatus.Cancel:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.Error:
        print('There was an error');
        break;
    }
  }

  loginGoogle() async {

    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
      );

      //Firebase Sign in
      final result = await authService.signInWithCredential(credential);

      print('${result.user.displayName}');

    } catch(error){
      print(error);
    }

  }

  logout(){
    authService.logout();
  }
}