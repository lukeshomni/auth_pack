import '../../models/app_user_model.dart';
import 'login_with_email_and_password.dart';
import 'login_with_gmail.dart';

enum LoginMethod{emailAndPassword, gmail}
abstract class LoginWrapper{
  factory LoginWrapper(LoginMethod loginMethod){
    switch(loginMethod){
      case LoginMethod.emailAndPassword:
        return LoginWithEmailAndPassword();
      case LoginMethod.gmail:
        return LoginWithGmail();
      default:
        throw UnimplementedError();
    }
  }
  Future<AppUserModel> login(String email, String password);
}