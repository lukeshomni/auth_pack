

import 'package:authentication/core/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';

class EmailInputWidget extends StatelessWidget{
  final TextEditingController controller;
  EmailInputWidget({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildEmailIcon(),
            const SizedBox(
              width: 13,
            ),
            _buildEmailText(),
          ],
        ),
        _buildInput(),
      ],
    );
  }

  Widget _buildEmailText() {
    return Text(
      Constants.emailText,
      style: GoogleFonts.raleway(
        color: lightGreyTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
    );
  }

  Widget _buildEmailIcon() {
    return SvgPicture.asset(
      Assets.email,
    );
  }

  Widget _buildInput() {
    return TextFormField(
      controller: controller,
      validator: _emailValidator,
      style: GoogleFonts.raleway(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w500
      ),
    );
  }

  String? _emailValidator(String? text){
    if(text == null || text.isEmpty ) return Constants.enterValidEmail;
    bool validEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
    if(!validEmail) return Constants.enterValidEmail;
    return null;
  }
}