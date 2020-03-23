import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/answerModel.dart';
import 'package:flashcards/models/cardModel.dart';
import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/questionModel.dart';
import 'package:flashcards/models/testModel.dart';
import 'package:flashcards/models/userModel.dart';

class DatabaseService {
  
  final CollectionReference deckCollection = Firestore.instance.collection("decksCollection");
  final CollectionReference users = Firestore.instance.collection("users");

  final String uid;
  final String deck_Id;
  final String tstId;
  final String quId;
  DatabaseService({this.uid, this.deck_Id, this.tstId, this.quId});

  // add Data to Firestore
  Future addCard(String deckId, String title, String front, String back, bool isHidden, String cardUnderstanding) async{
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

  Future addTest(String deckId, String title, double completion, bool isHidden, double rating) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests");
    updateTestsCount(deckId, true);
    return await colRef.add({
      'title' : title,
      'completion' : completion,
      'isHidden' : isHidden,
      'rating' : rating,
    });
  }

  Future addQuestion(String testId, String deckId, String question, String answer, bool isHidden, double rating) async {
    CollectionReference colRef = deckCollection.document(uid).collection("decks").document(deckId).collection("tests").document(testId).collection("questions");
    return await colRef.add({
      'question' : question,
      'answer' : answer,
      'rating' : rating,
      'isHidden' : isHidden,
    });
  }

  Future addAnswer(String questionId, String testId, String deckId, String answer, bool checked, bool correct) async{
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

  Future updateTest(String testId, String deckId, String title, /*String description, */double completion, double rating, bool isHidden) async{
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("tests").document(testId).updateData({
      'title' : title,
      'isHidden' : isHidden,
      'completion'  : completion,
      'rating' : rating,
    });
  }

  Future updateTestTitle(String testId, String deckId, String title) async{
    return await deckCollection.document(uid).collection('decks').document(deckId).collection("tests").document(testId).updateData({
      'title' : title,
    });
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

  Future updateDeck(String deckId, String deckTitle, String deckDescription) async {
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).updateData({
      'title' : deckTitle,
      'description' : deckDescription,
    });
  }

  Future updateDeckCompletion(String deckId, int cardsCount, int testCount, double oldCompletion) async {
    double completion = calculateCompletion(cardsCount, testCount, oldCompletion);
    // Firestore reference to the document with uid if not found Firestore create it
    return await deckCollection.document(uid).collection('decks').document(deckId).updateData({
      'completion': completion,
    });
  }

  double calculateCompletion(int cardsCount, int testCount, oldCompletion) {
    return oldCompletion + (1/(cardsCount + testCount));
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

  Stream<List<TestModel>> get tests {
    return deckCollection.document(uid).collection("decks").document(deck_Id)
        .collection("tests").snapshots()
        .map(_testsListFromSnapshot);
  }

  List<TestModel> _testsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return TestModel(
          testId: doc.documentID ?? '',
          deckId: deck_Id,
          title: doc.data['title'] ?? '',
          completion: doc.data['completion']?? '',
          rating: doc.data['rating']??'',
          isHidden: doc.data['isHidden']??false,);
    }).toList();
  }

  Stream<List<QuestionModel>> get questions {
    return deckCollection.document(uid).collection("decks").document(deck_Id)
        .collection("tests").document(tstId).collection("questions").snapshots()
        .map(_questionsListFromSnapshot);
  }

  List<QuestionModel> _questionsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return QuestionModel(
        testId: tstId ?? '',
        deckId: deck_Id ?? '',
        questionId: doc.documentID ?? '',
        question: doc.data['question'] ?? '',
        answer: doc.data['answer']?? '',
        rating: doc.data['rating'].toDouble()?? 0.0,
        isHidden: doc.data['isHidden']??false,);
    }).toList();
  }

  Stream<List<AnswerModel>> get answers {
    return deckCollection.document(uid).collection("decks").document(deck_Id)
        .collection("tests").document(tstId).collection("questions").document(quId).collection("answers").snapshots()
        .map(_answersListFromSnapshot);
  }

  List<AnswerModel> _answersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return AnswerModel(
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
  List<DeckModel> _decksListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return DeckModel(deckId: doc.documentID, title: doc.data['title']??'', cardsCount: doc.data['cardsCount']??0, testsCount: doc.data['testsCount']?? 0,
        completion: doc.data['completion']?? 0.0, visited: doc.data['visited'].toDate()?? null, isHidden: doc.data['isHidden']??false,);
    }).toList();
  }

  Stream<List<DeckModel>> get decks {
    return deckCollection.document(uid).collection("decks").snapshots()
        .map(_decksListFromSnapshot);
  }

  Stream<List<DeckModel>> get decksSorted {
    return deckCollection.document(uid).collection("decks").orderBy("visited", descending: true).snapshots()
        .map(_decksListFromSnapshot);
  }

  UserModel _userFromSnapshot(DocumentSnapshot snapshot) {
    // TODO test for anonym
    return UserModel(uid:uid??"", username:snapshot.data['username']??"");
  }

  Stream<UserModel> get username {
    return users.document(uid).snapshots().map(_userFromSnapshot);
  }

  Future getDecks() async {
    QuerySnapshot qn = await deckCollection.document(uid).collection("decks").getDocuments();
    return qn.documents;
  }

  Future getCards(String deckId) async {
    QuerySnapshot qn = await deckCollection.document(uid).collection("decks").document(deckId).collection("cards").getDocuments();
    return qn.documents;
  }

  Future getUsername() async {
    DocumentSnapshot ds = await users.document(uid).get();
    return ds.data['username'];
  }

}