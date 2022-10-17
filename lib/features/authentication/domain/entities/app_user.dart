import 'package:equatable/equatable.dart';

class AppUser extends Equatable{
  final String email;
  final String uid;
  AppUser({required this.email, required this.uid});

  @override
  List<Object?> get props => [email, uid];
}