import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;

  // ignore: deprecated_member_use
  Stream<FirebaseUser> get currentUser => _auth.onAuthStateChanged;

  Future<AuthResult> signInWithCredential(AuthCredential credential) => _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();

}