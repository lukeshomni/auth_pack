
import 'package:authentication/features/authenticaiton/presentation/bloc/auth_bloc.dart';
import 'package:authentication/features/authenticaiton/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authenticaiton/presentation/bloc/auth_state.dart';
import 'package:authentication/features/authenticaiton/presentation/screens/login_screen.dart';
import 'package:authentication/features/authenticaiton/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future<void> initializeAuthentication() async {
  await di.init();
  await Firebase.initializeApp();
}

class AuthenticationWrapper extends StatelessWidget {
  final Function onUserAuthenticatedCallBack;
  AuthenticationWrapper({
    required this.onUserAuthenticatedCallBack,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (ctx) => sl<AuthBloc>(),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            print('state is $state');
            if (state is Empty) {
              BlocProvider.of<AuthBloc>(context).add(GetAuthStateEvent());
              return SplashScreen();
            } else if (state is Authenticated) {
              BlocProvider.of<AuthBloc>(context).add(CallOnUserAuthenticatedCallback(onUserAuthenticatedCallBack));
              return _loadingScreen;
            } else if (state is Loading) {
              return _loadingScreen;
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }

  Widget _loadingScreen = Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
