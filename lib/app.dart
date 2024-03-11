import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/blocs/bloc/authentication_bloc.dart';
import 'package:pizza/constants/constants.dart';
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
                primary: colorPrimary,
                onPrimary: colorOnPrimary,
                secondary: colorSecondary,
                onSecondary: colorOnSecondary,
                error: errorColor,
                onError: onErrorColor,
                background: backgroundColor,
                onBackground: onBackgroundColor,
                surface: surfaceColor,
                onSurface: onSurfaceColor),
            elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
              backgroundColor: colorPrimary,
              foregroundColor: colorOnPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16)
            ))
          ),
        home: const AuthHomeController(),
      ),
    );
  }
}
