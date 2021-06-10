import 'package:flutter/material.dart';

//color
const cModeDark = Color(0xFF1000000);
const cModeDarkColorButtom = Color(0xFFEF3652);
const cModeDarkColorButtonText = Color(0xFFFFFFFF);
const cModeDarkColorFontTitle = Color(0xFFFFFFFF);
const cModeDarkColorFontSubTitle = Color(0xFFABB4BD);
const cModeDarkColorTextBox = Color(0xFF2A2C36);
const cModeDarkColorTextBoxLabel = Color(0xFFABB4BD);

//size
const cSizeTextHeader = 34.0;
//home tbalbiz
Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCD = Colors.grey.shade700;
Color fCL = Colors.grey;

BoxDecoration nMbox = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: Colors.deepOrange[100],
  boxShadow: [
    BoxShadow(
      color: mCD,
      offset: Offset(10, 10),
      blurRadius: 10,
    ),
    BoxShadow(
      color: mCL,
      offset: Offset(-10, -10),
      blurRadius: 10,
    ),
  ]
);
BoxDecoration nMboxInvert = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: mCD,
  boxShadow: [
    BoxShadow(
      color: mCL,
      offset: Offset(3, 3),
      blurRadius: 3,
      spreadRadius: -3
    ),
  ]
);






//url api
const apiUrl = "http://192.168.1.15:8080/";
//login
final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);