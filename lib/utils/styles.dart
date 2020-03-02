import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  errorStyle: TextStyle( fontSize: 14),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: CustomColors.White,)
  ),
  icon: Icon(Icons.lock_outline, color: CustomColors.White,),
  labelText: 'Password',
  labelStyle: TextStyle(
      color: CustomColors.White,
      fontFamily: 'Monsterrat',
      fontSize: 18
  ),
);

const textStyleWhite = TextStyle(
    color: CustomColors.White,
    decorationColor: CustomColors.White
);

const appNameTextStyle = TextStyle(
    fontFamily: 'MrDafoe',
    color: CustomColors.White,
    fontSize: 25);
