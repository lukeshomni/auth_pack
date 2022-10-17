import 'login/login.dart';
import 'package:authentication/features/authentication/data/models/app_user_model.dart';

//implement factory patterns
abstract class AuthRemoteDataSource{
  Future<AppUserModel> logIn({required LoginMethod loginMethod, required String email, required String password});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource{
  @override
  Future<AppUserModel> logIn({required LoginMethod loginMethod, required String email, required String password}) async {
    return LoginWrapper(LoginMethod.emailAndPassword).login(email, password);
  }

}