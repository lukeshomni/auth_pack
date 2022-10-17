
import 'dart:developer';

import 'package:authentication/features/authentication/presentation/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles/theme.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/shared_widgets/flat_text_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/email_input_widget.dart';
import '../widgets/password_input_widget.dart';

class LoginScreen extends StatelessWidget {
  static String tag = '/login_screen';
  static final _formKey = GlobalKey<FormState>();
  static final _emailController = TextEditingController();
  static final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: primaryColor,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 50,
                ),
                _buildTitle(),
                const SizedBox(
                  height: 50,
                ),
                _buildLoginContainer(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Text(
        Constants.loginScreenTitle,
        style: headlineLarge,
      ),
    );
  }

  Widget _buildLoginContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: _buildLoginForm(context),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 36,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _buildLoginText(),
          ),
          const SizedBox(
            height: 44,
          ),
          EmailInputWidget(
            controller: _emailController,
          ),
          const SizedBox(
            height: 22,
          ),
          PasswordInputWidget(
            controller: _passwordController,
          ),
          const SizedBox(
            height: 67,
          ),
          _buildErrorMessage(),
          const SizedBox(
            height: 5,
          ),
          _buildLoginButton(context),
          const SizedBox(
            height: 21,
          ),
          // _buildCreateAccountButton(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginText() {
    return Text(
      Constants.loginText,
      style: headline2,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return FlatButton(
      text: Constants.loginText,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          log("email: " + _emailController.text + "\n pass: " + _passwordController.text);
          BlocProvider.of<AuthBloc>(context).add(LogInButtonClickEvent(
              email: _emailController.text,
              password: _passwordController.text));
        }
      },
    );
  }

  Widget _buildCreateAccountButton() {
    return Text(
      Constants.createAccount,
      style: GoogleFonts.raleway(
        color: primaryColor,
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildErrorMessage() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Error) {
        return Container(
          child: Center(
            child: Text(
              state.errorMessage,
              style: GoogleFonts.raleway(
                color: Colors.red,
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }
}
