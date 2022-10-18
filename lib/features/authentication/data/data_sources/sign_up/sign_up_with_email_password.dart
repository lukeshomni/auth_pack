import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up.dart';
import 'package:authentication/features/authentication/data/models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/errors/exceptions.dart';

class SignUpWithEmailPassword implements SignUpWrapper {
  @override
  Future<AppUserModel> signUp(
      {required String email, required String password}) async {
    try {
      final user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      if (user == null) {
        throw AuthException();
      }
      AppUserModel appUser =
          AppUserModel(email: user.email.toString(), uid: user.uid);
      return appUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw UserAlreadyExistsException();
      }
      throw AuthException();
    } catch (e) {
      print('create user $e');
      throw AuthException();
    }
  }
}
