import 'package:cloud_firestore/cloud_firestore.dart';

class Deck{
  final String deckId;
  final String title;
  final int cardsCount;
  final int testsCount;
  final double completion;
  final DateTime visited;
  final bool isHidden;
  Deck({this.deckId, this.title, this.cardsCount, this.testsCount, this.completion, this.visited, this.isHidden});

  Deck fromSnapshot(DocumentSnapshot doc) {
    return Deck(deckId:doc.documentID, title: doc.data['title'], cardsCount: doc.data['cardsCount'],
      testsCount:doc.data['testsCount'], completion:doc.data['completion'], visited:doc.data['visited'], isHidden: doc.data['isHidden']);
  }
}
