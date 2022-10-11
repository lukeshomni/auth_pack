import 'package:authentication/features/authenticaiton/data/models/app_user_model.dart';

abstract class AuthRemoteDataSource{
  Future<bool> isAuthenticated();
  Future<AppUserModel> logIn({required String email, required String password});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource{
  @override
  Future<bool> isAuthenticated() {
    // TODO: implement isAuthenticated
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel> logIn({required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }
}