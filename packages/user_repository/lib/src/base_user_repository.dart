import 'dart:async';

import 'package:user_repository/user_repository.dart';

abstract class BaseUserRepository{
  Stream<MyUser?> get user;
  Future<MyUser> signUp(MyUser user, String password);
  Future<void> setUserData(MyUser user);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}
