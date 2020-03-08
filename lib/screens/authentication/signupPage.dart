import 'package:flashcards/services/auth.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/utils/styles.dart';
import 'package:flashcards/widgets/loadingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleAuthView;
  const SignUpPage({this.toggleAuthView});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage>{
  final _formKey = new GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String _username;
  String _email;
  String _password;
  String _error="";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading? LoadingWidget():Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CircleAvatar(child: Icon(Icons.layers, size: 30, color: CustomColors.White,), backgroundColor: CustomColors.black.withOpacity(0.3),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: widget.toggleAuthView,
              child: Row(
                children: <Widget>[
                  Center(child: Text("Login", style: TextStyle(color: CustomColors.White, fontSize: 16, fontFamily: 'Monsterrat'),)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.person, color: CustomColors.White,),
                  ),
                ],
              ),
            ),
          ),
//          IconButton(
//            icon: Icon(Icons.perm_identity, color: CustomColors.White,),
//            tooltip: "Login",
//            onPressed: widget.toggleAuthView ,
//          ),
        ],
        title: Text("FLAWORD", style: appNameTextStyle,),
      ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 70, 40, 10),
            color: Colors.transparent,
//            padding: EdgeInsets.fromLTRB(40, 30, 40, 130),
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: ExactAssetImage('assets/graphics/forest.jpg'),
//                fit: BoxFit.cover,
//                colorFilter: ColorFilter.mode(
//                    Colors.black.withOpacity(0.6),
//                    BlendMode.dstIn
//                ),
//              ),
//            ),
            child: Column(
              children: <Widget>[
//                Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Row(
//                        children: <Widget>[
//                          Icon(Icons.layers, size: 30, color: CustomColors.White,),
//                          Text("FLAWORLD",
//                              style: TextStyle(
//                                  fontFamily: 'MrDafoe',
//                                  color: CustomColors.White,
//                                  fontSize: 18),
//                            ),
//                        ],
//                      ),
//                      InkWell(
//                        onTap: widget.toggleAuthView,
//                        child: Row(
//                          children: <Widget>[
//                            IconButton(icon: Icon(Icons.person, color: CustomColors.White, size: 30,),),
//                            Text("Login", style: TextStyle(color: CustomColors.White, fontSize: 18, fontFamily: 'Monsterrat'),),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
                Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
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
                          onSaved: (val) => _email = val.trim(),
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
                          validator: (val) => val.length<6 ? "Enter a password 6+ chars long" : null,
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
                            border: Border.all(color: CustomColors.PurpleDark),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text('SIGN UP', style: TextStyle(color: CustomColors.White, fontSize: 18,), textAlign: TextAlign.center,),
                          ),
                        ),
                        onPressed: (){
                          submitForm();
                        },
                      ),
                      SizedBox(height: 5,),
                      Text(_error, style: TextStyle(color: Colors.red),),
                    ],
                  ),
                ),
              ],
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
    if (validateForm()) {
      setState(() {
        _isLoading = true;
      });
      dynamic result = await _auth.signUp(_username, _email, _password);
      if(result == null) {
        setState(() {
          _error = "sign up not successefull, please suply a valid email";
          _isLoading = false;
          print(_error);
        });
      }
    }
  }
}