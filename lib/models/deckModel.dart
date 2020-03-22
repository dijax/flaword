import 'package:cloud_firestore/cloud_firestore.dart';

class DeckModel{
  final String deckId;
  final String title;
  final String descritpion;
  final int cardsCount;
  final int testsCount;
  final double completion;
  final DateTime visited;
  final bool isHidden;
  DeckModel({this.deckId, this.title, this.descritpion, this.cardsCount, this.testsCount, this.completion, this.visited, this.isHidden});

  DeckModel fromSnapshot(DocumentSnapshot doc) {
    return DeckModel(deckId:doc.documentID, title: doc.data['title'], cardsCount: doc.data['cardsCount'],
      testsCount:doc.data['testsCount'], completion:doc.data['completion'], visited:doc.data['visited'].toDate(), isHidden: doc.data['isHidden']);
  }
}
