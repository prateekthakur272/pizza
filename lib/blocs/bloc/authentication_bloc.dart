import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final BaseUserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;
  AuthenticationBloc(this.userRepository) : super(AuthenticationUnauthenticated()) {
    _userSubscription = userRepository.user.listen((user) {
      add(AuthenticationUserChanges(user: user));
    });
    on<AuthenticationUserChanges>((event, emit) {
      if(event.user != null){
        emit(AuthenticationSuccess(user: event.user!));
      }else{
        emit(AuthenticationFailure());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
