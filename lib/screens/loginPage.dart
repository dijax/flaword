import 'package:flashcards/screens/signupPage.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
//  final AuthService auth;
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  final _formKey = new GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String _email;
  String _password;
  String _error;
  bool _isLoading;

  @override
  void initState(){
    _error = "";
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 73),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/graphics/mountain.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
                      BlendMode.dstIn
                  ),
              ),
            ),
//            child: Form(
//              key: _formKey,
//              child: ListView(
//                shrinkWrap: true,
//                children: <Widget>[
//                  CircleAvatar(
//                    backgroundColor: Colors.black.withOpacity(0.6),
//                    radius: 50,
//                    child: Icon(Icons.layers, size: 60, color: CustomColors.White,),
//                  ),
//                  Center(
//                    child: Text("FLAWORLD",
//                      style: TextStyle(
//                          fontFamily: 'MrDafoe',
//                          color: CustomColors.White,
//                          fontSize: 25),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//                    child: TextFormField(
//                      maxLines: 1,
//                      keyboardType: TextInputType.emailAddress,
//                      autofocus: false,
//                      style: TextStyle(
//                          color: CustomColors.White,
//                          decorationColor: CustomColors.White
//                      ),
//                      decoration: InputDecoration(
//                        errorStyle: TextStyle(fontSize: 14),
//                        enabledBorder: new UnderlineInputBorder(
//                            borderSide: BorderSide(color: CustomColors.White,)
//                        ),
//                        icon: new Icon(
//                          Icons.mail_outline,
//                          color: CustomColors.White,
//                        ),
//                        labelText: 'Email',
//                        labelStyle: TextStyle(
//                            color: CustomColors.White,
//                            fontFamily: 'Monsterrat',
//                            fontSize: 18
//                        ),
//                      ),
//                      validator: (value)=> value.isEmpty ? 'Enter Email': null,
//                      onSaved: (value)=> _email = value.trim(),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//                    child: TextFormField(
//                      style: TextStyle(
//                          color: CustomColors.White,
//                          decorationColor: CustomColors.White
//                      ),
//                      autofocus: false,
//                      obscureText: true,
//                      decoration: InputDecoration(
//                        errorStyle: TextStyle( fontSize: 14),
//                        enabledBorder: new UnderlineInputBorder(
//                            borderSide: BorderSide(color: CustomColors.White,)
//                        ),
//                        icon: new Icon(Icons.lock_outline, color: CustomColors.White,),
//                        labelText: 'Password',
//                        labelStyle: TextStyle(
//                            color: CustomColors.White,
//                            fontFamily: 'Monsterrat',
//                            fontSize: 18
//                        ),
//                      ),
//                      validator: (value) => value.isEmpty? "Enter password":null,
//                      onSaved: (value) => _password = value.trim(),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(30),
//                  ),
//                  FlatButton(
//                    color: Colors.transparent,
//                    disabledColor: Colors.transparent,
//                    child: Container(
//                      width: 200,
//                      height: 40,
//                      decoration: BoxDecoration(
//                        border: Border.all(color: CustomColors.White),
//                        borderRadius: BorderRadius.circular(10.0),
//                      ),
//                      child: Center(
//                        child: Text(
//                          'LOGIN',
//                          style: TextStyle(color: CustomColors.White, fontSize: 18),
//                          textAlign: TextAlign.center,),
//                      ),
//                    ),
//                    onPressed: submitForm,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(30),
//                  ),
//                  FlatButton(
//                    child: Text(
//                      "SIGNUP",
//                      style: TextStyle(color: CustomColors.PurpleDark, fontSize: 18),
//                    ),
//                    onPressed: (){
//                      print("hiiii");
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
//                    },
//                  ),
//                ],
//              ),
//            ),
            child: FlatButton(
              color: Colors.transparent,
              disabledColor: Colors.transparent,
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.White),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Sign in anonymously',
                    style: TextStyle(color: CustomColors.White, fontSize: 18),
                    textAlign: TextAlign.center,),
                ),
              ),
              onPressed: () async{
                dynamic result = await _auth.signInAnon();
                if(result == null) {
                  print("error");

                } else {
                  print("sign in");
                  print(result);
                }
              },
            ),

          ),
        )
    );
  }


  void resetForm() {
    _formKey.currentState.reset();
    _error = "";
  }

  bool validateForm() {
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void submitForm() async {
    setState(() {
      _error = "";
      _isLoading = true;
    });
    if (validateForm()) {
//      dynamic result = await widget.auth.signInAnon();
      String uid = "";
    }
  }

  void signInanon() async {
//    dynamic result = await widget.auth.signInAnon();
//    if(result == null) print("error sign in anon");
//    else print("sign in");
//    print(result);
//    String uid = "";
      dynamic result = await _auth.signInAnon();
      if(result == null) print("error sign in");
      else {
        print("sign in");
        print(result);
      }

  }
}