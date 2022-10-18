
import 'package:authentication/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_event.dart';
import 'package:authentication/features/authentication/presentation/bloc/auth_state.dart';
import 'package:authentication/features/authentication/presentation/screens/login_screen.dart';
import 'package:authentication/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:authentication/features/authentication/presentation/screens/splash_screen.dart';
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
  Widget? previousScreen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (ctx) {
          final authBloc = sl<AuthBloc>();
          authBloc.onUserAuthenticatedCallback = onUserAuthenticatedCallBack;
          return authBloc;
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current){
            if(previous != current){
              switch(current.runtimeType){
                case Loading:
                  return true;
                case ShowLoginScreen:
                  return true;
                case ShowSignUpScreen:
                  return true;
                case Error:
                  return true;
                default:
                  return false;
              }
            }
            return false;
          },
          builder: (context, state) {
            print('$state');
            switch(state.runtimeType){
              case Empty:
                BlocProvider.of<AuthBloc>(context).add(GetAuthStateEvent());
                return _loadingScreen;
              case Loading:
                return _loadingScreen;
              case ShowLoginScreen:
                previousScreen =  LoginScreen();
                return previousScreen!;
              case ShowSignUpScreen:
                previousScreen = SignUpScreen();
                return previousScreen!;
              case Error:
                if(previousScreen == null) return LoginScreen();
                return previousScreen!;
              default:
                return _loadingScreen;
            }
          },
        ),
      ),
    );
  }

  final Widget _loadingScreen = Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
