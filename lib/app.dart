import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/bloc/authentication_bloc.dart';
import 'package:pizza/screens/auth/auth_home_controller.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  final BaseUserRepository userRepository;
  const App({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository),
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Colors.green.shade400,
                onPrimary: Colors.white,
                secondary: Colors.purple.shade400,
                onSecondary: Colors.white,
                error: Colors.red.shade400,
                onError: Colors.white,
                background: Colors.grey.shade200,
                onBackground: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black),
            elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16)
            ))
          ),
        home: const AuthHomeController(),
      ),
    );
  }
}
