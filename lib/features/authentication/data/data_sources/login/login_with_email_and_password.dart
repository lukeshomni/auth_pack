import 'package:authentication/features/authentication/data/data_sources/login/login.dart';
import 'package:authentication/features/authentication/data/models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/errors/exceptions.dart';

class LoginWithEmailAndPassword implements LoginWrapper {
  @override
  Future<AppUserModel> login(String email, String password) async {
    try {
      final user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) {
        throw UserNotFoundException();
      }
      AppUserModel appUser =
          AppUserModel(email: user.email.toString(), uid: user.uid);
      return appUser;
    } on FirebaseAuthException catch (e) {
      print('login $e');
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      }
      if (e.code == 'wrong-password') {
        throw (InValidCredentialsException());
      }
      throw AuthException();
    } catch (e) {
      print('login $e');
      throw AuthException();
    }
  }
}
