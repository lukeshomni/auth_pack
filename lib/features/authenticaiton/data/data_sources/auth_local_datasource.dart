import '../models/app_user_model.dart';

abstract class AuthLocalDataSource{
  Future<AppUserModel> getUser();
  Future<void> logOut();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource{
  @override
  Future<AppUserModel> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}