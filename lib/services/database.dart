import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  
  final CollectionReference deckCollection = Firestore.instance.collection("decksCollection");
  final CollectionReference users = Firestore.instance.collection("users");

  final String uid;
  DatabaseService({this.uid});

  // add Data to Firestore
  Future addCard(String deckId, String title, String front, String back, bool hidden, String cardUnderstanding) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("cards");
    String cardId = "";
    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc){
        cardId = "card${doc.documents.length + 1}";
        addCardToFireStore(cardId, deckId, title, front, back, hidden, cardUnderstanding);
        print("cardId: "+ cardId);
      });
    } else{
      print("Card not added ");
    }
  }

  Future addCardToFireStore(String cardId, String deckId, String title, String front, String back, bool hidden, String cardUnderstanding) async{
    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId).collection("cards").document(cardId);
      await docRef.setData({
        'title' : title,
        'front' : front,
        'back' : back,
        'hidden' : hidden,
        'cardUnderstanding' : cardUnderstanding,
      });
  }

  Future addDeck(String title, int cardsCount, int testsCount, double completion, DateTime visited, bool isHidden) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks");
    String deckId = "";
    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc){
        addDeckToFireStore(deckId, title, cardsCount, testsCount, completion, visited, isHidden);
        deckId = "deck${doc.documents.length + 1}";
        print("deckId: "+ deckId);
      });
    } else{
      print("Deck not added ");
    }
  }

  Future addDeckToFireStore(String deckId, String title, int cardsCount, int testsCount, double completion, DateTime visited, bool isHidden) async{
    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId);
    await docRef.setData({
      'title': title,
      'cardsCount': cardsCount,
      'testsCount': testsCount,
      'completion': completion,
      'visited': visited,
      'isHidden': isHidden,
    });
  }

  Future addTestToFireStore(String testId, String deckId, String title, double completion, bool isHidden) async{
    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId);
    await docRef.setData({
      'title' : title,
      'completion' : completion,
      'isHidden' : isHidden,
    });
  }

  Future addTest(String deckId, String title, double completion, bool isHidden) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests");
    String testId = "";
    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc){
        testId = "test${doc.documents.length + 1}";
        addTestToFireStore(testId, deckId, title, completion, isHidden);
        print("testId: "+ testId);
      });
    } else{
      print("Test not added ");
    }
  }

  Future updateUserData(String username) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await users.document(uid).setData({
    'username' : username,
    });
  }

//  Future updateDecks(String title, int cardsCount, int testsCount, double completion, DateTime visited, bool hidden) async {
//    return await users.document(uid).collection('decks').document(uid).setData({
//      'title':title,
//      'cardsCount':cardsCount,
//      'testsCount':testsCount,
//      'completion':completion,
//      'visited':visited,
//      'hidden':hidden,
//    });
//  }

//  Future updateDeck(String title, int cardsCount, int testsCount, double completion, DateTime visited, bool hidden) async {
//    // Firestore reference to the document with uid if not found Firestore create it
//    return await deckCollection.document(uid).collection('decks').document(uid).setData({
//    'title':title,
//    'cardsCount':cardsCount,
//    'testsCount':testsCount,
//    'completion':completion,
//    'visited':visited,
//    'hidden':hidden,
//    });
//  }


  // deck list from Snapshot
  List<Deck> _decksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Deck(doc.data['title']??'', doc.data['cardsCount']??0, doc.data['testsCount']?? 0,
        doc.data['completion']?? 0.0, doc.data['visited']?? null, doc.data['hidden']??false,);
    }).toList();
  }

  Stream<List<Deck>> get decks {
    return deckCollection.document(uid).collection("decks").snapshots()
        .map(_decksListFromSnapshot);
  }

  User _userFromSnapshot(DocumentSnapshot snapshot) {
    // TODO test for anonym
    return User(uid:uid??"", username:snapshot.data['username']??"");
  }

//  List<User>_usersFromSnapshot(QuerySnapshot snapshot) {
//    return snapshot.documents.map((doc) {
//      return User(uid:uid??"", username:doc.data['username']??"");
//    });
//  }

//   Stream<List<User>> get usernames{
//     var snapshots = users.snapshots().map(_usersFromSnapshot);
//     return snapshots;
//  }

  Stream<User> get username {
    return users.document(uid).snapshots().map(_userFromSnapshot);
  }

}