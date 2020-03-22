import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SpinKitRotatingPlain(
        color: CustomColors.White.withOpacity(0.5),
        size: 50,
      ),
    );
  }
}