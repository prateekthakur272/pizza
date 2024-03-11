import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

sealed class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AuthenticationUnauthenticated extends AuthenticationState {}

final class AuthenticationSuccess extends AuthenticationState {
  final MyUser user;
  AuthenticationSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

sealed class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationUserChanges extends AuthenticationEvent {
  final MyUser? user;

  AuthenticationUserChanges({required this.user});
  @override
  List<Object?> get props => [user];
}

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final BaseUserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;
  AuthenticationBloc(this.userRepository)
      : super(AuthenticationUnauthenticated()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanges(user: user));
    });
    on<AuthenticationUserChanges>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationSuccess(user: event.user!));
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
