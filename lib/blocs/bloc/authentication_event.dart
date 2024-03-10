part of 'authentication_bloc.dart';
sealed class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationUserChanges extends AuthenticationEvent{
  final MyUser? user;

  AuthenticationUserChanges({required this.user});
  @override
  List<Object?> get props => [user];
}