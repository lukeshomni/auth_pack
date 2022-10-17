import 'package:authentication/features/authentication/domain/entities/app_user.dart';

class AppUserModel extends AppUser{

  AppUserModel({required super.email, required super.uid});

  @override
  List<Object?> get props => [email, uid];
}