import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/home/decksList.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/views/deckView.dart';
import 'package:flashcards/widgets/settingsMenu.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/services/database.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  //TODO use the Random color generator
//  final appColors = [Color.fromRGBO(231, 129, 109, 1.0),Color.fromRGBO(99, 138, 223, 1.0),Color.fromRGBO(111, 194, 173, 1.0)];
  int deckIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
//  AuthService _auth = AuthService();

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;
//  List<DeckModel> decks = MockData.decksList.take(3).toList();


  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    print("home " + widget.user?.uid);

    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: DatabaseService(uid: widget.user.uid).username),
        StreamProvider<List<Deck>>.value(value: DatabaseService(uid: widget.user.uid).decks),
      ],
      child: Scaffold(
//    return Scaffold(
        backgroundColor: Colors.transparent,
//      resizeToAvoidBottomPadding: false, // used to fix the pixels overflow
        body: Container(
          child: ListView(
              children: <Widget>[
                Row(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black.withOpacity(0.4),
                              child: Icon(Icons.layers, color: CustomColors.White,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("FLAWORLD",
                              style: TextStyle(
                                  fontFamily: 'MrDafoe',
                                  color: CustomColors.White,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      StreamProvider<User>.value(
                        value: DatabaseService(uid: widget.user.uid).username,
                        child: TitleWidget(),
                      ),

//                      TitleWidget(user: widget.user),
                      Text("Nice to see you.", style:  TextStyle(backgroundColor: Colors.black.withOpacity(0.5),fontSize: 16.0, color: Colors.white, fontFamily: 'Poppins')),
                      Text("Keep the good work, keep learning.", style: TextStyle(backgroundColor: Colors.black.withOpacity(0.5),fontSize: 16.0, color: Colors.white, fontFamily: 'Poppins'),),

                    ],
                  ),
                ),
//            StreamBuilder<QuerySnapshot>(
//              stream: Firestore.instance.collection("deck").snapshots(),
//              builder: (context, snapshot) {
//                if(!snapshot.hasData) return LinearProgressIndicator();
//                final record = Record.fromSnapshot(snapshot.data.documents.elementAt(0));
//                return Column(
//                  children: <Widget>[
//                    InkWell(
//                      onTap: () => record.reference.updateData({'name': "Deckk"}),
//                      child: Text("change the name"),
//                    ),
//                    Padding(
//                      padding: EdgeInsets.all(10),
//                      key: ValueKey(record.name),
//                      child: Container(
//                        child: Text(record.description),
//                      ),
//                    ),
//                  ],
//                );
//              },
//            ),

                    StreamProvider<List<Deck>>.value(
                      value: DatabaseService(uid: widget.user.uid).decks,
                      child: Container(
                        height: 300.0,
                        child: DecksList(user:widget.user),
                      ),
                    ),
              ]
          ),
        ),
//      ),
    ));
  }
}

class TitleWidget extends StatelessWidget {
  TitleWidget();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user!=null) {
      print("Titlewidget " + user.uid);
    }
    return (user!= null)?Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
        child: Text("Hello, ${user.username}", style: TextStyle(fontSize: 30.0, color: CustomColors.White, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),)
    ):Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
      child: Text("Hello,", style: TextStyle(fontSize: 30.0, color: CustomColors.White, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),));
  }
}


//class TitleWidget extends StatelessWidget {
////  final userId = DatabaseService().uid;
//  final User user;
//  TitleWidget({this.user});
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
////    final user = Provider.of<User>(context);
////    print("user"+ user.username);
//          return (user!= null)?Padding(
//            padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
//            child: StreamBuilder<DocumentSnapshot>(
//              stream: DatabaseService().users.document(user.uid).snapshots(),
//              builder: (context, snapshot) {
//                if(!snapshot.hasData) {
//                  print("Error snapshot does not have data");
//                  return Container();
//                } else if (snapshot.hasData) {
//                  print("userId " + user.uid);
//                  return Text("Hello, ${snapshot.data['username']}", style: TextStyle(fontSize: 30.0, color: CustomColors.White, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),);
//                } else return Container();
//              }
//            ),
//          ):Container(child: Text("user is null"),);
//  }
//}