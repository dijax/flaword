import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult authResult = await _auth.signInWithEmailAndPassword(
        email: null, password: password);
    FirebaseUser user = authResult.user;
    return user.uid;
  }

  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signUp(String username, String email, String password) async{
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = authResult.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
   FirebaseUser user = await _auth.currentUser();
   return user;
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }
}