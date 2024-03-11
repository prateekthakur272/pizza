import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

sealed class SignInState extends Equatable{
  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState{}
class SignInLoading extends SignInState{}
class SignInSuccess extends SignInState{
  final MyUser user;
  SignInSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
class SignInFailed extends SignInState{
  final String message;
  SignInFailed(this.message);

  @override
  List<Object?> get props => [message];
}

sealed class SignInEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SignInRequired extends SignInEvent{
  final String email;
  final String password;
  SignInRequired(this.email, this.password);
  
  @override
  List<Object?> get props => [email, password];
}

class SignInBloc extends Bloc<SignInEvent, SignInState>{

  final BaseUserRepository _userRepository;

  SignInBloc(this._userRepository):super(SignInInitial()){
    on<SignInRequired>((event, emit) async {
      emit(SignInLoading());
      try{
        await _userRepository.signIn(event.email, event.password);
      }catch(e){
        emit(SignInFailed(e.toString()));
      }
    });
  }
}