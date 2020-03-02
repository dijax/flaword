import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage();
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage>{
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String _username;
  String _email;
  String _password;
  String _error;
  bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/graphics/forest.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.dstIn
                ),
              ),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    radius: 50,
                    child: Icon(Icons.layers, size: 60, color: CustomColors.White,),
                  ),
                  Center(
                    child: Text("FLAWORLD",
                      style: TextStyle(
                          fontFamily: 'MrDafoe',
                          color: CustomColors.White,
                          fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      style: TextStyle(
                          color: CustomColors.White,
                          decorationColor: CustomColors.White
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(fontSize: 14),
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.White,)
                        ),
                        icon: new Icon(
                          Icons.perm_identity,
                          color: CustomColors.White,
                        ),
                        labelText: 'Username',
                        labelStyle: TextStyle(
                            color: CustomColors.White,
                            fontFamily: 'Monsterrat',
                            fontSize: 18),
                      ),
                      validator: (val) => val.isEmpty ? 'Enter your username':null,
                      onSaved: (val)=> _username = val.trim(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      style: TextStyle(
                          color: CustomColors.White,
                          decorationColor: CustomColors.White
                      ),
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.White,)
                        ),
                        icon: new Icon(Icons.mail_outline, color: CustomColors.White,),
                        labelText: 'Email adress',
                        labelStyle: TextStyle(color: CustomColors.White, fontFamily: 'Monsterrat', fontSize: 18),
                      ),
                      validator: (val){
                        if(val.isEmpty) return "Enter your email";
                        if(!val.contains("@")) return "Enter a valid email";
                        return null;
                      },
                      onSaved: (val) => _password = val.trim(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      controller: _pass,
                      style: TextStyle(color: CustomColors.White, decorationColor: CustomColors.White),
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.White,)
                        ),
                        icon: new Icon(Icons.lock_open, color: CustomColors.White,),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: CustomColors.White, fontFamily: 'Monsterrat', fontSize: 18),
                      ),
                      validator: (val) => val.isEmpty ? "Enter your password" : null,
                      onSaved: (val) => _password = val.trim(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextFormField(
                      controller: _confirmPass,
                      style: TextStyle(color: CustomColors.White, decorationColor: CustomColors.White),
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.White,)
                        ),
                        icon: new Icon(Icons.lock_open, color: CustomColors.White,),
                        labelText: 'Retype password',
                        labelStyle: TextStyle(color: CustomColors.White, fontFamily: 'Monsterrat', fontSize: 18),
                      ),
                      validator: (val) {
                        if(val.isEmpty) return 'Retype your password';
                        if(val != _pass.text) return "Do not match";
                        return null;
                      },
                      onSaved: (val) => _password = val.trim(),
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
                        child: Text('SIGN UP', style: TextStyle(color: CustomColors.White, fontSize: 18, ), textAlign: TextAlign.center,),
                      ),
                    ),
                    onPressed: (){
                      submitForm();
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
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
      String uid = "";
    }
  }
}