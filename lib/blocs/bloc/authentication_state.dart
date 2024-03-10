part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable{
  @override
  List<Object?> get props => [];
}

final class AuthenticationUnauthenticated extends AuthenticationState {}
final class AuthenticationPending extends AuthenticationState {}
final class AuthenticationSuccess extends AuthenticationState {
  
}
final class AuthenticationFailure extends AuthenticationState {}
