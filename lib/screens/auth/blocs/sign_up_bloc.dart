import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

sealed class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final MyUser user;
  SignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignUpFailed extends SignUpState {
  final String message;
  SignUpFailed(this.message);

  @override
  List<Object?> get props => [message];
}

sealed class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;
  SignUpRequired(this.user, this.password);

  @override
  List<Object?> get props => [user, password];
}

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final BaseUserRepository _userRepository;

  SignUpBloc(this._userRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpLoading());
      try {
        MyUser user = await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        emit(SignUpSuccess(user));
      } catch (e) {
        emit(SignUpFailed(e.toString()));
      }
    });
  }
}
