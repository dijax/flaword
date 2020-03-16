import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/answer.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/question.dart';
import 'package:flashcards/models/test.dart';
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
  final String tstId;
  final String quId;
  DatabaseService({this.uid, this.deck_Id, this.tstId, this.quId});

  // add Data to Firestore
  Future addCard(/*String cardId, */String deckId, String title, String front, String back, bool isHidden, String cardUnderstanding) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("cards");
    /*if(*//*cardId != null*//*)*/ addCardToFireStore(/*cardId, */deckId, title, front, back, isHidden, cardUnderstanding);
//    else{
//      if(colRef.getDocuments() != null) {
//        colRef.getDocuments().then((doc){
//          cardId = "card${doc.documents.length + 1}";
//          addCardToFireStore(cardId, deckId, title, front, back, isHidden, cardUnderstanding);
//          print("cardId: "+ cardId);
//        });
//      } else{
//        print("Card not added ");
//      }
//    }
  }

//  Future addCardToFireStore(String cardId, String deckId, String title, String front, String back, bool isHidden, String cardUnderstanding) async{
//    DocumentReference docRef = deckCollection.document(uid).collection("decks").document(deckId).collection("cards").document(cardId);
//      await docRef.setData({
//        'title' : title,
//        'front' : front,
//        'back' : back,
//        'isHidden' : isHidden,
//        'cardUnderstanding' : cardUnderstanding,
//      });
//      updateCardsCount(deckId, true);
//  }

  Future addCardToFireStore(/*String cardId, */String deckId, String title, String front, String back, bool isHidden, String cardUnderstanding) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("cards");
      await colRef.add({
        'title' : title,
        'front' : front,
        'back' : back,
        'isHidden' : isHidden,
        'cardUnderstanding' : cardUnderstanding,
      });
      updateCardsCount(deckId, true);
  }

  Future addDeck(String title, int cardsCount, int testsCount, double completion, DateTime visited, bool isHidden) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks");
//    String deckId = "";
//    if(colRef.getDocuments() != null) {
//      colRef.getDocuments().then((doc){
//        deckId = "deck${doc.documents.length + 1}";
        addDeckToFireStore(/*deckId, */title, cardsCount, testsCount, completion, visited, isHidden);
//        print("deckId: "+ deckId);
//      });
//    } else{
//      print("Deck not added ");
//    }
  }

  Future addDeckToFireStore(/*String deckId, */String title, int cardsCount, int testsCount, double completion, DateTime visited, bool isHidden) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks")/*.document(deckId)*/;
    String id;
    return await colRef.add({
      'title': title,
      'cardsCount': cardsCount,
      'testsCount': testsCount,
      'completion': completion,
      'visited': DateTime.now(),
      'isHidden': isHidden,
      'description' : "",
    });
  }

  Future addTest(/*String testId, */String deckId, String title, double completion, bool isHidden, double rating) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests");
    /*if(testId != null) */addTestToFireStore(/*testId,*/ deckId, title, completion, isHidden, rating);
    /*else {
      if(colRef.getDocuments() != null) {
        colRef.getDocuments().then((doc){
          testId = "test${doc.documents.length + 1}";
          addTestToFireStore(testId, deckId, title, completion, isHidden, rating);
          print("testId: "+ testId);
        });
      } else{
        print("Test not added ");
      }
    }*/
  }

  Future addTestToFireStore(/*String testId, */String deckId, String title, double completion, bool isHidden, double rating) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests")/*.document(testId)*/;
    updateTestsCount(deckId, true);
    return await colRef.add({
      'title' : title,
      'completion' : completion,
      'isHidden' : isHidden,
      'rating' : rating,
    });
  }

  Future addQuestion(/*String questionId, */String testId, String deckId, String question, String answer, bool isHidden, double rating) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions");
    /*if(questionId.isNotEmpty)*/ addQuestionToFireStore(/*questionId, */testId, deckId, question, answer, isHidden, rating);
//    else{
//      if(colRef.getDocuments() != null) {
//        colRef.getDocuments().then((doc){
//          questionId= "question${doc.documents.length + 1}";
//          addQuestionToFireStore(questionId, testId, deckId, question, answer, isHidden, rating);
//          print("questionId: "+ questionId);
//        });
//      } else{
//        print("question not added ");
//      }
//    }
  }

  Future addQuestionToFireStore(/*String questionId, */String testId, String deckId, String question, String answer, bool isHidden, double rating) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions");
    return await colRef.add({
      'question' : question,
      'answer' : answer,
      'rating' : rating,
      'isHidden' : isHidden,
    });
  }

  Future addAnswer(String answerId, String questionId, String testId, String deckId, String answer, bool checked, bool correct) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions").document(questionId).collection("answers");
    if(answerId.isNotEmpty) addAnswerToFireStore(/*answerId, */questionId, testId, deckId, answer, checked, correct);
    else{
      if(colRef.getDocuments() != null) {
        colRef.getDocuments().then((doc){
          answerId = "answer${doc.documents.length + 1}";
          addAnswerToFireStore(/*answerId, */questionId, testId, deckId, answer, checked, correct);
          print("answerId: "+ answerId);
        });
      } else{
        print("answer not added ");
      }
    }
  }

  Future addAnswerToFireStore(String questionId, String testId, String deckId, String answer, bool checked, bool correct) async{
    CollectionReference colRef = deckCollection.document(uid).collection("decks")
        .document(deckId).collection("tests").document(testId).collection("questions")
        .document(questionId).collection("answers");
    await colRef.add({
      'answer' : answer,
      'correct' : correct,
      'checked' : checked,
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

  Future updateVisitDate(DateTime date) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deck_Id).updateData({
      'visited' : date,
    });
  }

  Future updateDeckVisibilty (bool isHidden, String deckId) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).updateData({
      'isHidden' : isHidden,
    });
  }

  Future updateCardVisibilty (bool isHidden, String deckId, String cardId) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("cards").document(cardId).updateData({
      'isHidden' : isHidden,
    });
  }

  Future updateTestVisibilty (bool isHidden, String deckId, String testId) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("tests").document(testId).updateData({
      'isHidden' : isHidden,
    });
  }

  Future removeDeck (String deckId) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).delete();
  }

  Future removeCard(String deckId, String cardId) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("cards").document(cardId).delete();
  }

  Future removeTest (String deckId, String testId) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("tests").document(testId).delete();
  }

  Future updateCardsCount(String deckId, bool increment) async{
    if(increment){
      return await deckCollection.document(uid).collection('decks').document(deckId).updateData({
        'cardsCount' : FieldValue.increment(1),
      });
    } else{
      return await deckCollection.document(uid).collection('decks').document(deckId).updateData({
        'cardsCount' : FieldValue.increment(-1),
      });
    }
  }


  Future updateTestsCount(String deckId, bool increment) async{
    if(increment){
      return await deckCollection.document(uid).collection('decks').document(deckId).updateData({
        'testsCount' : FieldValue.increment(1),
      });
    } else{
      return await deckCollection.document(uid).collection('decks').document(deck_Id).updateData({
        'testsCount' : FieldValue.increment(-1),
      });
    }
  }

  Future updateCard(String cardId, String deckId, String title, String description, String front, String back) async{
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("cards").document(cardId).updateData({
      'title' : title,
      'description': description,
      'front' : front,
      'back'  : back,
    });
  }

  Future updateCardUnderstanding(String cardId, CardUnderstanding cardUnderstanding) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deck_Id).collection("cards").document(cardId).updateData({
      'cardUnderstanding' : cardUnderstanding.toString(),
    });
  }

//  Future updateCard (String cardId, CardUnderstanding cardUnderstanding) async {
//    // Firestore reference to the document with uid if not found Firestore create it
//    return await deckCollection.document(uid).collection('decks').document(deck_Id).collection("cards").document(cardId).updateData({
//      'cardUnderstanding' : cardUnderstanding.toString(),
//    });
//  }

  Future updateDeck(String deckId, String deckTitle, String deckDescription) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).updateData({
      'title' : deckTitle,
      'description' : deckDescription,
    });
  }

  Stream<List<CardModel>> get cards {
    return deckCollection.document(uid).collection("decks").document(deck_Id).collection("cards").snapshots()
        .map(_cardsListFromSnapshot);
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

  Stream<List<Test>> get tests {
    return deckCollection.document(uid).collection("decks").document(deck_Id)
        .collection("tests").snapshots()
        .map(_testsListFromSnapshot);
  }

  List<Test> _testsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Test(
          testId: doc.documentID ?? '',
          deckId: deck_Id,
          title: doc.data['title'] ?? '',
          completion: doc.data['completion']?? '',
          rating: doc.data['rating']??'',
          isHidden: doc.data['isHidden']??false,);
    }).toList();
  }

  Stream<List<Question>> get questions {
    return deckCollection.document(uid).collection("decks").document(deck_Id)
        .collection("tests").document(tstId).collection("questions").snapshots()
        .map(_questionsListFromSnapshot);
  }

  List<Question> _questionsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Question(
        testId: tstId ?? '',
        deckId: deck_Id ?? '',
        questionId: doc.documentID ?? '',
        question: doc.data['question'] ?? '',
        answer: doc.data['answer']?? '',
        rating: doc.data['rating'].toDouble()?? 0.0,
        isHidden: doc.data['isHidden']??false,);
    }).toList();
  }

  Stream<List<Answer>> get answers {
    return deckCollection.document(uid).collection("decks").document(deck_Id)
        .collection("tests").document(tstId).collection("questions").document(quId).collection("answers").snapshots()
        .map(_answersListFromSnapshot);
  }

  List<Answer> _answersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Answer(
        testId: doc.documentID ?? '',
        deckId: deck_Id ?? '',
        questionId: quId ?? '',
        answerId: doc.documentID,
        answer: doc.data['answer']??'',
        checked: doc.data['checked']??false,
        correct: doc.data['correct']??false);
    }).toList();
  }

  // deck list from Snapshot
  List<Deck> _decksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Deck(deckId: doc.documentID, title: doc.data['title']??'', cardsCount: doc.data['cardsCount']??0, testsCount: doc.data['testsCount']?? 0,
        completion: doc.data['completion']?? 0.0, visited: doc.data['visited'].toDate()?? null, isHidden: doc.data['isHidden']??false,);
    }).toList();
  }

  Stream<List<Deck>> get decks {
    return deckCollection.document(uid).collection("decks").snapshots()
        .map(_decksListFromSnapshot);
  }

  Stream<List<Deck>> get decksSorted {
    return deckCollection.document(uid).collection("decks").orderBy("visited", descending: true).snapshots()
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