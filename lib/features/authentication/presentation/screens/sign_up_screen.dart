
import 'dart:developer';

import 'package:authentication/features/authentication/presentation/widgets/confirm_password_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles/theme.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/shared_widgets/flat_text_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/email_input_widget.dart';
import '../widgets/password_input_widget.dart';

class SignUpScreen extends StatelessWidget {
  static String tag = '/login_screen';
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                  color: primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      _buildTitle(),
                      const SizedBox(
                        height: 50,
                      ),
                      _buildSignUpContainer(context),
                    ],
                  )),
            ),
          );
        });
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Text(
        Constants.signUpScreenTitle,
        style: headlineLarge,
      ),
    );
  }

  Widget _buildSignUpContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: _buildSingUpForm(context),
    );
  }

  Widget _buildSingUpForm(BuildContext context) {
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
            height: 22,
          ),
          ConfirmPasswordInputWidget(
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
          ),
          const SizedBox(
            height: 67,
          ),
          _buildErrorMessage(),
          const SizedBox(
            height: 5,
          ),
          _buildSignUpButton(context),
          const SizedBox(
            height: 21,
          ),
          _buildLoginButton(),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginText() {
    return Text(
      Constants.signUpText,
      style: headline2,
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return FlatButton(
      text: Constants.signUpText,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          log("email: " + _emailController.text + "\n pass: " + _passwordController.text);
          authBloc.add(SignUpButtonClickEvent(
              email: _emailController.text,
              password: _passwordController.text));
        }
      },
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: (){
        BlocProvider.of<AuthBloc>(_context).add(ShowLoginScreenEvent());
      },
      child: Text(
        Constants.loginText,
        style: GoogleFonts.raleway(
          color: primaryColor,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
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
              textAlign: TextAlign.center,
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
