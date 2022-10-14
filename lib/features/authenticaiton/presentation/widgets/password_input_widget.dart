import 'package:authentication/features/authenticaiton/presentation/bloc/auth_bloc.dart';
import 'package:authentication/features/authenticaiton/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authenticaiton/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles/theme.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';

class PasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;
  PasswordInputWidget({required this.controller});

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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool showPassword = false;
        if (state is ShowPassword) {
          showPassword = state.showPassword;
        }
        return TextFormField(
          controller: controller,
          style: GoogleFonts.raleway(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              letterSpacing: 5),
          decoration: InputDecoration(
              suffix: GestureDetector(
            onTap: () {
              BlocProvider.of<AuthBloc>(context)
                  .add(ShowPasswordEvent(!showPassword));
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
      },
    );
  }

  String? _passwordValidator(String? text){
    if(text == null || text.isEmpty || text.length < 6) return Constants.enterValidPassword;
    return null;
  }
}
