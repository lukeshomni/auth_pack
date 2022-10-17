import 'package:authentication/core/errors/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user_model.dart';

abstract class AuthLocalDataSource{
  Future<AppUserModel> getUser();
  Future<void> logOut();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource{
  @override
  Future<AppUserModel> getUser() {
      final user = FirebaseAuth.instance.currentUser;
      if(user == null) throw UserNotFoundException();
      AppUserModel appUser = AppUserModel(email: user.email.toString(), uid: user.uid);
      return Future(() => appUser);
  }

  @override
  Future<void> logOut() {
    return FirebaseAuth.instance.signOut();
  }
}