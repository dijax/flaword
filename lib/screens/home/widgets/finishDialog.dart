import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class FinishDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Icon icon;

  FinishDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 30.0,
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
          ),
          margin: EdgeInsets.only(top: 20.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonText, style: TextStyle(color: CustomColors.PurpleDark, fontSize: 16),),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10.0,
          right: 10.0,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 20.0,
            child: this.icon,
          ),
        ),
      ],
    );
  }
}