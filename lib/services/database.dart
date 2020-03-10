import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/models/card.dart';
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
  final String deck_Id;
  DatabaseService({this.uid, this.deck_Id});

  // add Data to Firestore
  Future addCard(String cardId, String deckId, String title, String front, String back, bool isHidden, String cardUnderstanding) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("cards");
    if(cardId != null) addCardToFireStore(cardId, deckId, title, front, back, isHidden, cardUnderstanding);
    else{
      if(colRef.getDocuments() != null) {
        colRef.getDocuments().then((doc){
          cardId = "card${doc.documents.length + 1}";
          addCardToFireStore(cardId, deckId, title, front, back, isHidden, cardUnderstanding);
          print("cardId: "+ cardId);
        });
      } else{
        print("Card not added ");
      }
    }
  }

  Future addCardToFireStore(String cardId, String deckId, String title, String front, String back, bool isHidden, String cardUnderstanding) async{
    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId).collection("cards").document(cardId);
      await docRef.setData({
        'title' : title,
        'front' : front,
        'back' : back,
        'isHidden' : isHidden,
        'cardUnderstanding' : cardUnderstanding,
      });
  }

  Future addDeck(String title, int cardsCount, int testsCount, double completion, DateTime visited, bool isHidden) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks");
    String deckId = "";
    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc){
        deckId = "deck${doc.documents.length + 1}";
        addDeckToFireStore(deckId, title, cardsCount, testsCount, completion, visited, isHidden);
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

  Future addTest(String deckId, String title, double completion, bool isHidden, double rating) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests");
    String testId = "";
    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc){
        testId = "test${doc.documents.length + 1}";
        addTestToFireStore(testId, deckId, title, completion, isHidden, rating);
        print("testId: "+ testId);
      });
    } else{
      print("Test not added ");
    }
  }

  Future addTestToFireStore(String testId, String deckId, String title, double completion, bool isHidden, double rating) async{
    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId);
    await docRef.setData({
      'title' : title,
      'completion' : completion,
      'isHidden' : isHidden,
      'rating' : rating,
    });
  }

  Future addQuestion(String testId, String deckId, String question, String answer, bool isHidden, double rating) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions");
    String questionId = "";
    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc){
        questionId= "question${doc.documents.length + 1}";
        addQuestionToFireStore(questionId, testId, deckId, question, answer, isHidden, rating);
        print("questionId: "+ questionId);
      });
    } else{
      print("question not added ");
    }
  }

  Future addQuestionToFireStore(String questionId, String testId, String deckId, String question, String answer, bool isHidden, double rating) async{
    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions").document(questionId);
    await docRef.setData({
      'question' : question,
      'answer' : answer,
      'rating' : rating,
      'isHidden' : isHidden,
    });
  }

  Future addAnswer(String questionId, String testId, String deckId, String question, String answer, bool isHidden, double rating) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions").document(questionId).collection("answers");
    String answerId = "";
    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc){
        answerId = "answer${doc.documents.length + 1}";
        addAnswerToFireStore(answerId, questionId, testId, deckId, question, answer, isHidden, rating);
        print("answerId: "+ answerId);
      });
    } else{
      print("answer not added ");
    }
  }

  Future addAnswerToFireStore(String answerId, String questionId, String testId, String deckId, String question, String answer, bool isHidden, double rating) async{
    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions").document(questionId).collection("answers").document(answerId);
    await docRef.setData({
      'question' : question,
      'answer' : answer,
      'rating' : rating,
      'isHidden' : isHidden,
    });
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


  Future updateCardsCount(bool increment) async{
    if(increment){
      return await deckCollection.document(uid).collection('decks').document(deck_Id).setData({
        'cardsCount' : FieldValue.increment(1),
      });
    } else{
      return await deckCollection.document(uid).collection('decks').document(deck_Id).setData({
        'cardsCount' : FieldValue.increment(-1),
      });
    }
  }


  Future updateCard(String cardId, String deckId, String title, String front, String back, bool isHidden, String cardUnderstanding) async{
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("cards").document(cardId).setData({
      'title' : title,
      'front' : front,
      'back'  : back,
      'isHidden': isHidden,
      'cardUnderstanding': cardUnderstanding,
    });
  }

  List<CardModel> _cardsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return CardModel(
        cardId: doc.documentID ?? '',
        deckId: deck_Id,
        title: doc.data['title'] ?? '',
        front: doc.data['front']?? '',
        back: doc.data['back']??'',
        isHidden: doc.data['isHidden']??false,
        cardUnderstanding: doc.data['cardUnderstanding']??'');
    }).toList();
  }

  Stream<List<CardModel>> get cards {
    return deckCollection.document(uid).collection("decks").document(deck_Id).collection("cards").snapshots()
        .map(_cardsListFromSnapshot);
  }

  // deck list from Snapshot
  List<Deck> _decksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Deck(deckId: doc.documentID, title: doc.data['title']??'', cardsCount: doc.data['cardsCount']??0, testsCount: doc.data['testsCount']?? 0,
        completion: doc.data['completion']?? 0.0, visited: doc.data['visited']?? null, isHidden: doc.data['isHidden']??false,);
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