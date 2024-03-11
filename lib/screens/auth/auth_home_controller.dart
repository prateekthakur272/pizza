import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/bloc/authentication_bloc.dart';
import 'package:pizza/screens/auth/auth_screen.dart';
import 'package:pizza/screens/home/home_screen.dart';

class AuthHomeController extends StatelessWidget {
  const AuthHomeController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
      if(state is AuthenticationSuccess){
        return const HomeScreen();
      }
      return const AuthScreen();
    });
  }
}
