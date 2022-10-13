import 'package:flutter/material.dart';

import '../../styles/theme.dart';

class WhiteButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const WhiteButton({
    super.key,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.only(top: 22, bottom: 22),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: primaryColor),
      ),
    );
  }
}
