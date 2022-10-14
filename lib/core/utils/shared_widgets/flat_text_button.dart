import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/theme.dart';

class FlatButton extends StatelessWidget{
  final String text;
  final Function onPressed;
  const FlatButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () { onPressed(); },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.only(top: 22, bottom: 22),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          text,
          style: GoogleFonts.raleway(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        )
    );
  }
}