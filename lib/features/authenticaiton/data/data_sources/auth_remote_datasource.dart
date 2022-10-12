import 'package:authentication/core/errors/exceptions.dart';
import 'package:authentication/features/authenticaiton/data/models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource{
  Future<AppUserModel> logIn({required String email, required String password});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource{
  @override
  Future<AppUserModel> logIn({required String email, required String password}) async {
    try{
      final user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)).user;
      if(user == null) throw UserNotFoundException();
      AppUserModel appUser = AppUserModel(email: user.email.toString(), uid: user.uid);
      return appUser;
    } catch (e) {
        throw AuthException();
    }
  }
}