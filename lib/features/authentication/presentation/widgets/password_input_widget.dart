
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles/theme.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';

class PasswordInputWidget extends StatefulWidget {
  final TextEditingController controller;
  PasswordInputWidget({required this.controller});

  @override
  State<StatefulWidget> createState() => PasswordInputWidgetState();
}

class PasswordInputWidgetState extends State<PasswordInputWidget>{
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildPasswordIcon(),
            const SizedBox(
              width: 13,
            ),
            _buildPasswordText(),
          ],
        ),
        _buildInput(),
      ],
    );
  }

  Widget _buildPasswordText() {
    return Text(
      Constants.passwordText,
      style: GoogleFonts.raleway(
        color: lightGreyTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
    );
  }

  Widget _buildPasswordIcon() {
    return SvgPicture.asset(
      Assets.password,
    );
  }

  Widget _buildInput() {
    return TextFormField(
      controller: widget.controller,
      style: GoogleFonts.raleway(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          letterSpacing: 5),
      decoration: InputDecoration(
          suffix: GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Text(
          showPassword ? Constants.hidePassword : Constants.showPassword,
          style: GoogleFonts.raleway(
              color: primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              letterSpacing: 0),
        ),
      )),
      obscuringCharacter: '*',
      obscureText: !showPassword,
      enableSuggestions: false,
      autocorrect: false,
      validator: _passwordValidator,
    );
  }

  String? _passwordValidator(String? text) {
    if (text == null || text.isEmpty || text.length < 6)
      return Constants.enterValidPassword;
    return null;
  }
}
