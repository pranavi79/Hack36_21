import 'package:flutter/material.dart';

String radioItem = '';
String radioItem2 = '';
String birthDateInString;
var birthDate;
bool isDateSelected;
var on = true;

final kHintTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  fontSize: 15,
  color: Colors.black38,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(1.0, 1.0),
      blurRadius: 2.0,
      color: Colors.black45,
    ),
  ],
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(200.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
