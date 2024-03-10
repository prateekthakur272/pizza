part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable{
  @override
  List<Object?> get props => [];
}

final class AuthenticationUnauthenticated extends AuthenticationState {}

final class AuthenticationPending extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  final MyUser user;
  AuthenticationSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

final class AuthenticationFailure extends AuthenticationState {}
