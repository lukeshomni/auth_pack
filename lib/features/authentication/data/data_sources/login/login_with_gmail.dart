import 'package:authentication/features/authentication/data/data_sources/login/login.dart';
import 'package:authentication/features/authentication/data/models/app_user_model.dart';

class LoginWithGmail implements LoginWrapper {
  @override
  Future<AppUserModel> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
