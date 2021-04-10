import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final tStyle= GoogleFonts.raleway(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
    color: Color(0xFFE56AB3),
    textStyle: TextStyle(shadows: <Shadow>[
      Shadow(
        offset: Offset(3.0, 3.0),
        blurRadius: 3.0,
        color: Colors.black38,
      ),
    ]));