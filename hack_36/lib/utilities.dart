import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final tStyle = GoogleFonts.raleway(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    textStyle: TextStyle(shadows: <Shadow>[
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 1.0,
        color: Colors.black38,
      ),
    ]));
