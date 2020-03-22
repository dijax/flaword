import 'package:flutter/material.dart';

class CustomColors {
  static const Color GreyBackground = Color.fromRGBO(249, 252, 255, 1);
  static const Color GreyBorder = Color.fromRGBO(207, 207, 207, 1);
  static const Color BackgroundColor = Color.fromRGBO(242, 243, 248,1);
  static const Color GreenLight = Color.fromRGBO(93, 230, 26, 1);
  static const Color GreenDark = Color.fromRGBO(57, 170, 2, 1);
  static const Color GreenIcon = Color.fromRGBO(30, 209, 2, 1);
  static const Color GreenAccent = Color.fromRGBO(30, 209, 2, 1);
  static const Color GreenShadow = Color.fromRGBO(30, 209, 2, 0.24); // 24%
  static const Color GreenBackground = Color.fromRGBO(181, 255, 155, 0.36); // 36%
  static const Color NotWhite = Color(0xFFEDF0F2);
  static const Color DeepBlue = const Color(0xff262545);
  static const Color BlueCiel = const Color(0xff6f6f97);
  static const Color black = Colors.black;

  static const Color MistyRose = Color.fromRGBO(255,228,225,1);

  static const Color OrangeIcon = Color.fromRGBO(236, 108, 11, 1);
  static const Color OrangeBackground = Color.fromRGBO(255, 208, 155, 0.36); // 36%

  static const Color PurpleLight = Color.fromRGBO(248, 87, 195, 1);
  static const Color Purple = Color.fromRGBO(224, 19, 156, 1);
  static const Color PurpleIcon = Color.fromRGBO(209, 2, 99, 1);
  static const Color PurpleDark = Color.fromRGBO(209, 2, 99, 1);
  static const Color PurpleShadow = Color.fromRGBO(209, 2, 99, 0.27); // 27%
  static const Color PurpleBackground = Color.fromRGBO(255, 155, 205, 0.36); // 36%

  static const Color DeeppurlpleIcon = Color.fromRGBO(191, 0, 128, 1);
  static const Color DeeppurlpleBackground = Color.fromRGBO(245, 155, 255, 0.36); // 36%

  static const Color BlueLight = Color.fromRGBO(126, 182, 255, 1);
  static const Color BlueDark = Color.fromRGBO(95, 135, 231, 1);
  static const Color BlueIcon = Color.fromRGBO(9, 172, 206, 1);
  static const Color BlueBackground = Color.fromRGBO(155, 255, 248, 0.36); // 36%
  static const Color BlueShadow = Color.fromRGBO(104, 148, 238, 1);

  static const Color HeaderBlueLight = Color.fromRGBO(129, 199, 245, 1);
  static const Color HeaderBlueDark = Color.fromRGBO(56, 103, 213, 1);
  static const Color HeaderGreyLight = Color.fromRGBO(225, 255, 255, 0.31); // 31%

  static const Color YellowIcon = Color.fromRGBO(249, 194, 41, 1);
  static const Color YellowBell = Color.fromRGBO(225, 220, 0, 1);
  static const Color YellowAccent = Color.fromRGBO(255, 213, 6, 1);
  static const Color YellowShadow = Color.fromRGBO(243, 230, 37, 0.27); // 27%
  static const Color YellowBackground = Color.fromRGBO(255, 238, 155, 0.36); // 36%

  static const Color BellGrey = Color.fromRGBO(217, 217, 217, 1);
  static const Color BellYellow = Color.fromRGBO(255, 220, 0, 1);

  static const Color TrashRed = Color.fromRGBO(251, 54, 54, 1);
  static const Color TrashRedBackground = Color.fromRGBO(255, 207, 207, 1);

  static const Color TextHeader = Color.fromRGBO(85, 78, 143, 1);
  static const Color TextHeaderGrey = Color.fromRGBO(104, 104, 104, 0.8);
  static const Color TextSubHeaderGrey = Color.fromRGBO(161, 161, 161, 1);
  static const Color TextSubHeader = Color.fromRGBO(139, 135, 179, 1);
  static const Color TextBody = Color.fromRGBO(130, 160, 183, 1);
  static const Color TextGrey = Color.fromRGBO(198, 198, 200, 1);
  static const Color TextWhite = Color.fromRGBO(243, 243, 243, 1);
  static const Color HeaderCircle = Color.fromRGBO(255, 255, 255, 0.17);
  static const Color Gradient_Bottom = Color.fromRGBO(106, 136, 229, 1);

  static const Color NearlyWhite = Color(0xFFFAFAFA);
  static const Color White = Color(0xFFFFFFFF);
  static const Color Background = Color(0xFFF2F3F8);
  static const Color NearlyDarkBlue = Color(0xFF2633C5);

  static const Color NearlyBlue = Color(0xFF00B6F0);
  static const Color NearlyBlack = Color(0xFF213333);
  static const Color Nearlyblack = Color(0xDD000000);
  static const Color Grey = Color(0xFF3A5160);
  static const Color VeryLightGrey = Color(0xFFEEEEEE);
  static const Color LightGrey = Color(0xFFBDBDBD);
  static const Color Darkgrey = Color(0xFF313A44);

  static const Color DarkText = Color(0xFF253840);
  static const Color DarkerText = Color(0xFF17262A);
  static const Color LightText = Color(0xFF4A6572);
  static const Color DeactivatedText = Color(0xFF767676);
  static const Color DismissibleBackground = Color(0xFF364A54);
  static const Color Spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const List<Color> OrangeGradients = [
    Color(0xFFFF9844),
    Color(0xFFFE8853),
    Color(0xFFFD7267),
  ];

  static const List<Color> PurpleGradient = [
    Color.fromRGBO(248, 87, 195, 1),
    Color.fromRGBO(224, 19, 156, 1),
  ];

  static const List<Color> AquaGradients = [
    Color(0xFF5AEAF1),
    Color(0xFF8EF7DA),
  ];

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: DarkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: DarkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: DarkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: DarkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: DarkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: DarkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: LightText, // was lightText
  );

}