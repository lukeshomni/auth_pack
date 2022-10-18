import 'package:authentication/features/authentication/data/data_sources/sign_up/sign_up_with_email_password.dart';
import 'package:authentication/features/authentication/data/models/app_user_model.dart';

import '../../../domain/entities/app_user.dart';

enum SignUpMethod {emailAndPassword, gmail}
abstract class SignUpWrapper{
  factory SignUpWrapper(SignUpMethod signUpMethod){
    switch(signUpMethod){
      case SignUpMethod.emailAndPassword:
        return SignUpWithEmailPassword();
      default:
        throw UnimplementedError();
    }
  }
  Future<AppUserModel> signUp({required String email, required String password});
}