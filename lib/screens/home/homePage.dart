import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/screens/home/decksList.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  HomePage({this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  //TODO use the Random color generator

  int deckIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
//        StreamProvider<UserModel>.value(value: DatabaseService(uid: widget.user.uid).username),
        StreamProvider<List<DeckModel>>.value(value: DatabaseService(uid: widget.user.uid).decksSorted),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      StreamProvider<UserModel>.value(
                        value: DatabaseService(uid: widget.user.uid).username,
                        child: TitleWidget(),
                      ),
                      Text("Nice to see you.", style:  TextStyle(backgroundColor: Colors.black.withOpacity(0.5),fontSize: 16.0, color: Colors.white, fontFamily: 'Poppins')),
                      Text("Keep the good work, keep learning.", style: TextStyle(backgroundColor: Colors.black.withOpacity(0.5),fontSize: 16.0, color: Colors.white, fontFamily: 'Poppins'),),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text("Last visited", style: TextStyle(backgroundColor:CustomColors.black.withOpacity(0.5), color: CustomColors.White),),
                ),
                StreamProvider<List<DeckModel>>.value(
                  value: DatabaseService(uid: widget.user.uid).decksSorted,
                  child: Container(
                    height: 300.0,
                    child: DecksList(user:widget.user),
                  ),
                ),
              ]
          ),
        ),
    ));
  }
}

class TitleWidget extends StatelessWidget {
  TitleWidget();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return (user!= null)?Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
        child: Text("Hello, ${user.username}", style: TextStyle(fontSize: 30.0,
            color: CustomColors.White, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),)
    ):Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
      child: Text("Hello,", style: TextStyle(fontSize: 30.0, color: CustomColors.White,
          fontFamily: 'Montserrat', fontWeight: FontWeight.bold),));
  }
}