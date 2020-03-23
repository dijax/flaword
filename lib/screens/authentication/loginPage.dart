import 'dart:ui';

import 'package:flashcards/services/auth.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/utils/styles.dart';
import 'package:flashcards/screens/home/widgets/loadingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function toggleAuthView;
  const LoginPage({this.toggleAuthView});

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  final _formKey = new GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String _email;
  String _password;
  String _error;
  bool _isLoading = false;

  @override
  void initState(){
    _error = "";
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? LoadingWidget():Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 73),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    radius: 50,
                    child: Icon(Icons.layers, size: 60, color: CustomColors.White,),
                  ),
                  Center(
                    child: Text("FLAWORLD",
                      style: appNameTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      style: textStyleWhite,
                      decoration: textInputDecoration.copyWith(labelText: "Email"),
                      validator: (value)=> value.isEmpty ? 'Enter Email': null,
                      onSaved: (value)=> _email = value.trim(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: TextFormField(
                      style: textStyleWhite,
                      autofocus: false,
                      obscureText: true,
                      decoration: textInputDecoration,
                      validator: (value) => value.length<6? "password is too short":null,
                      onSaved: (value) => _password = value.trim(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                  ),
                  FlatButton(
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
                          'LOGIN',
                          style: TextStyle(color: CustomColors.White, fontSize: 18),
                          textAlign: TextAlign.center,),
                      ),
                    ),
                    onPressed: submitForm,
                  ),
                  SizedBox(height: 20),
                  Text(
                    _error, style: TextStyle(color: Colors.red,),textAlign: TextAlign.center,
                  ),
//                  Padding(
//                    padding: EdgeInsets.all(30),
//                  ),
//                  FlatButton(
//                    child: Text(
//                      "Anonym",
//                      style: TextStyle(color: CustomColors.PurpleDark, fontSize: 18),
//                    ),
//                    onPressed: signInanon,
//                  ),
//                  Padding(
//                    padding: EdgeInsets.all(20),
//                  ),
                  FlatButton(
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(color: CustomColors.PurpleDark, fontSize: 18),
                    ),
                    onPressed: widget.toggleAuthView,
                  ),
                ],
              ),
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
    if (validateForm()) {
      setState(() {
        _isLoading = true;
      });
        dynamic result = await _auth.signIn(_email, _password);
        if(result == null) {
          setState(() {
            _error = "login failed. Please try again";
            _isLoading = false;
          });
        }
    }
  }

  // sign In anonymously
  void signInanon() async {
      dynamic result = await _auth.signInAnon();
      if(result == null) print("error login");
      else {
        print("login");
        print(result.uid);
      }
  }


}