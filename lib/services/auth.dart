import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

//  Future currentUser() async {
//    final FirebaseUser user = await _auth.currentUser();
//    final uid = user.uid;
//    return uid;
//    // here you write the codes to input the data into firestore
//  }

  // sign in anonymously
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try{
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signUp(String username, String email, String password) async{
    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      // create new document for this new user
      await DatabaseService(uid: user.uid).updateUserData(username);
//      await DatabaseService(uid: user.uid).updateDeck("your first deck", 0, 0, 0.0, null, false);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
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

  // Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}