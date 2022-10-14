import 'package:authentication/core/styles/theme.dart';
import 'package:authentication/core/utils/constants.dart';
import 'package:authentication/core/utils/shared_widgets/flat_text_button.dart';
import 'package:authentication/features/authenticaiton/domain/use_cases/logout_usecase.dart';
import 'package:authentication/features/authenticaiton/presentation/bloc/auth_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'injection_container.dart';
import 'features/authenticaiton/presentation/bloc/auth_bloc.dart';
import 'features/authenticaiton/presentation/bloc/auth_state.dart';

class LogOutButton extends StatelessWidget {
  final Function onLoggedOutCallback;
  LogOutButton({
    required this.onLoggedOutCallback,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => sl<AuthBloc>(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return TextButton(
              child: Text(
                Constants.logoutText,
                style: GoogleFonts.raleway(color: primaryColor),
              ),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(LogOutEvent(onLoggedOutCallback));
              });
        },
      ),
    );
  }
}
